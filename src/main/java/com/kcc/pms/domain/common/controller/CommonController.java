package com.kcc.pms.domain.common.controller;

import com.kcc.pms.auth.PrincipalDetail;
import com.kcc.pms.domain.common.config.EnvVariableProperties;
import com.kcc.pms.domain.common.model.dto.CommonCodeSelectListResponseDto;
import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.project.model.dto.ProjectManagerResponseDto;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import com.kcc.pms.domain.project.service.ProjectService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URI;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class CommonController {
    private final CommonService commonService;
    private final ProjectService projectService;

    private final EnvVariableProperties properties;

    @GetMapping({"/projects", "/outputs"})
    @ResponseBody
    public List<ProjectResponseDto> getCommonProjectList(@AuthenticationPrincipal PrincipalDetail principalDetail) {
        String login_id = principalDetail.getMember().getId(); // 회원아이디(세션정보)

        return projectService.getCommonProjectList(login_id);
    }

    @GetMapping("/commonProjectInfo")
    public String getCommonProject(@RequestParam Long prjNo, @RequestParam String prjTitle,
                                   HttpSession session, HttpServletRequest request,
                                   @AuthenticationPrincipal PrincipalDetail principalDetail) {
        Long memNo = principalDetail.getMember().getMemNo();
        ProjectManagerResponseDto pmDto = projectService.getAuthCode(prjNo, memNo);
        String authCode = pmDto.getProjectAuthCode();

        projectService.updateRecentProject(prjNo, memNo);

        session.setAttribute("prjNo", prjNo);
        session.setAttribute("prjTitle", prjTitle);
        session.setAttribute("authCode", authCode);
        session.setAttribute("memberNo", memNo);
        String referer = request.getHeader("Referer");

        if (referer == null || referer.isEmpty()) {
            referer = "/projects/dashboard"; // 기본 경로 설정
        }

        return "redirect:" + referer;
    }


    @GetMapping("/loginForm")
    public String login() {
        return "loginForm";
    }


    @GetMapping("/getCommonCodeList")
    @ResponseBody
    public List<CommonCodeSelectListResponseDto> getCommonCodeList(@RequestParam("commonCodeNo") String commonCodeNo) {
        return commonService.getCommonCodeSelectList(commonCodeNo);
    }

    @GetMapping("/fileDownload")
    @ResponseBody
    public ResponseEntity<byte[]> fileDownload(@RequestParam("filePath") String filePath) {
        try {
            return ResponseEntity.ok().body(commonService.downloadFile(filePath));
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/files-kccpms/{projectNo}/{fileName:.+}")
    public ResponseEntity<Void> getImage(
            @PathVariable("projectNo") String userId,
            @PathVariable("fileName") String fileName) {
        try {
            if (!isValidFileName(fileName)) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }

            String path = properties.getS3().getUrl() + userId + "/" + fileName;

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(URI.create(path));
            return new ResponseEntity<>(headers, HttpStatus.FOUND);

        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    private boolean isValidFileName(String fileName) {
        return !fileName.contains("..") && !fileName.contains("/");
    }
}
