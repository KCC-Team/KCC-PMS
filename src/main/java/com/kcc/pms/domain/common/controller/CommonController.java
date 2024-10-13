package com.kcc.pms.domain.common.controller;

import com.kcc.pms.domain.common.model.dto.CommonCodeSelectListResponseDto;
import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import com.kcc.pms.domain.project.service.ProjectService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class CommonController {

    private final CommonService commonService;
    private final ProjectService projectService;

    @GetMapping({"/projects", "/outputs"})
    @ResponseBody
    public List<ProjectResponseDto> getCommonProjectList() {
        String login_id = "user1"; // 회원아이디(세션정보)

        return projectService.getCommonProjectList(login_id);
    }


    @GetMapping("/commonProjectInfo")
    public String getCommonProject(@RequestParam int prjNo, @RequestParam String prjTitle,
                                   HttpSession session, HttpServletRequest request) {
        session.setAttribute("prjNo", prjNo);
        session.setAttribute("prjTitle", prjTitle);

        String referer = request.getHeader("Referer");

        if (referer == null || referer.isEmpty()) {
            referer = "/projects/dashboard"; // 기본 경로 설정
        }

        System.out.println("referer = " + referer);

        return "redirect:" + referer;
    }


    @GetMapping("/login")
    public String login() {
        return "login";
    }


    @GetMapping("/getCommonCodeList")
    @ResponseBody
    public List<CommonCodeSelectListResponseDto> getCommonCodeList(@RequestParam("commonCodeNo") String commonCodeNo) {
        System.out.println(commonCodeNo);
        return commonService.getCommonCodeSelectList(commonCodeNo);
    }

}
