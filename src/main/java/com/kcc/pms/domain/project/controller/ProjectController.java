package com.kcc.pms.domain.project.controller;

import com.kcc.pms.auth.PrincipalDetail;
import com.kcc.pms.domain.project.model.dto.*;
import com.kcc.pms.domain.project.service.ProjectService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Map;


@Controller
@RequiredArgsConstructor
@RequestMapping("/projects")
public class ProjectController {

    private final ProjectService projectService;

    @GetMapping("/list")
    public String list(ProjectRequestDto prjReqDto, Criteria cri, Model model, @AuthenticationPrincipal PrincipalDetail principalDetail) {
        String login_id = principalDetail.getMember().getId(); // 회원아이디(세션정보)
        prjReqDto.setLogin_id(login_id);

        int total = projectService.getProjectCount(prjReqDto);

        model.addAttribute("projectList", projectService.getProjects(prjReqDto, cri));
        model.addAttribute("pageMaker", new PageDto(cri, total));

        return "project/list";
    }

    @GetMapping("/info")
    public String info(Model model) {
        return "project/info";
    }

    @GetMapping("/dashboard")
    public String dashboardInfo() {
//        Integer prjNo = (Integer)session.getAttribute("prjNo");
//        Long prjNogValue = prjNo.longValue();

        return "project/dashboard";
    }

    @GetMapping("/dashboardInfo")
    public String dashboard(@RequestParam Long prjNo, @RequestParam String prjTitle, HttpSession session, @AuthenticationPrincipal PrincipalDetail principalDetail) {
        if (prjNo > 0 && prjTitle != null) {
            Long memNo = principalDetail.getMember().getMemNo();
            ProjectManagerResponseDto pmDto = projectService.getAuthCode(prjNo, memNo);
            String authCode = pmDto.getProjectAuthCode();

            projectService.updateRecentProject(prjNo, memNo);

            session.setAttribute("prjNo", prjNo);
            session.setAttribute("prjTitle", prjTitle);
            session.setAttribute("authCode", authCode);
        }

        return "/project/dashboard";
    }

    @GetMapping("/api/project")
    @ResponseBody
    public ResponseEntity<CombinedProjectResponseDto> info(HttpSession session) {
        Long prjNo = (Long)session.getAttribute("prjNo"); // 프로젝트번호(세션정보)
        CombinedProjectResponseDto projectInfo = projectService.findByProject(prjNo);
        
        return ResponseEntity.ok(projectInfo);
    }

    @PostMapping("/api/project")
    @ResponseBody
    public ResponseEntity<String> saveProject(ProjectRequestDto project, HttpSession session, @AuthenticationPrincipal PrincipalDetail principalDetail) {
        String login_id = principalDetail.getMember().getId(); // 회원아이디(세션정보)
        Long prjNo = (Long)session.getAttribute("prjNo"); // 프로젝트번호(세션정보)
        project.setReg_id(login_id);
        project.setPrj_no(prjNo);

        try {
            int result = projectService.saveProject(project);
            if (result > 0) {
                return ResponseEntity.ok("success save project");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail save project");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error: " + e.getMessage());
        }
    }

    @PutMapping("/api/project")
    @ResponseBody
    public ResponseEntity<String> updateProject(ProjectRequestDto project, HttpSession session, @AuthenticationPrincipal PrincipalDetail principalDetail) {
        Long prjNo = (Long)session.getAttribute("prjNo"); // 프로젝트번호(세션정보)
        String login_id = principalDetail.getMember().getId(); // 회원아이디(세션정보)
        project.setMod_id(login_id);

        try {
            int result = projectService.updateProject(project);
            if (result > 0) {
                CombinedProjectResponseDto projectInfo = projectService.findByProject(prjNo);
                String prjTitle = projectInfo.getProject().getPrj_title();
                session.setAttribute("prjTitle", prjTitle);

                return ResponseEntity.ok("success update project");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail update project");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error: " + e.getMessage());
        }
    }

    @GetMapping("/api/project/recentProjectInfo")
    @ResponseBody
    public ResponseEntity<RecentProjectDto> recentProjectInfo(@AuthenticationPrincipal PrincipalDetail principalDetail) {
        Long memNo = principalDetail.getMember().getMemNo();
        RecentProjectDto projectInfo = projectService.getRecentProject(memNo);
        return ResponseEntity.ok(projectInfo);
    }

    @PatchMapping("/api/prg")
    @ResponseBody
    public ResponseEntity<String> updateProgress(Integer progress, HttpSession session) {
        Long prjNo = (Long)session.getAttribute("prjNo"); // 프로젝트번호(세션정보)

        try {
            int result = projectService.updateProjectProgress(prjNo, progress);
            if (result > 0) {
                return ResponseEntity.ok("success update progress");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail update progress");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error: " + e.getMessage());
        }
    }

    @GetMapping("/api/dashboard")
    @ResponseBody
    public ResponseEntity<Map<String, BigDecimal>> dashboardCount(HttpSession session) {
        Long prjNo = (Long)session.getAttribute("prjNo"); // 프로젝트번호(세션정보)
        Map<String, BigDecimal> counts = projectService.getCountsByProject(prjNo);

        return ResponseEntity.ok(counts);
    }

}
