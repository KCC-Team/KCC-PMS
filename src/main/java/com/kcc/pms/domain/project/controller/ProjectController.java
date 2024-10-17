package com.kcc.pms.domain.project.controller;

import com.kcc.pms.domain.project.model.dto.*;
import com.kcc.pms.domain.project.service.ProjectService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects")
public class ProjectController {

    private final ProjectService projectService;

    @GetMapping("/list")
    public String list(ProjectRequestDto prjReqDto, Criteria cri, Model model) {
        String login_id = "user1"; // 회원아이디(세션정보)
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
        //int prj_no = (int)session.getAttribute("prjNo"); // dashboard 정보가져와야함

        return "project/dashboard";
    }

    @GetMapping("/dashboardInfo")
    public String dashboard(@RequestParam int prjNo, @RequestParam String prjTitle, HttpSession session) {
        if (prjNo > 0 && prjTitle != null) {
            session.setAttribute("prjNo", prjNo);
            session.setAttribute("prjTitle", prjTitle);
        }

        return "/project/dashboard";
    }

    @GetMapping("/api/project")
    @ResponseBody
    public ResponseEntity<CombinedProjectResponseDto> info(HttpSession session) {
        int prjNo = (int)session.getAttribute("prjNo");

        CombinedProjectResponseDto projectInfo = projectService.findByProject(prjNo);
        return ResponseEntity.ok(projectInfo);
    }

    @PostMapping("/api/project")
    @ResponseBody
    public ResponseEntity<String> saveProject(ProjectRequestDto project) {
        String login_id = "user1"; // 회원아이디(세션정보)
        project.setReg_id(login_id);

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
    public ResponseEntity<String> updateProject(ProjectRequestDto project, HttpSession session) {
        int prjNo = (int)session.getAttribute("prjNo");
        String login_id = "user1"; // 회원아이디(세션정보)
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


}
