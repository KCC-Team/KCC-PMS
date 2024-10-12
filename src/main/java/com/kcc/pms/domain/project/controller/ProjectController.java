package com.kcc.pms.domain.project.controller;

import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.project.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects")
public class ProjectController {

    private final ProjectService projectService;

    // 프로젝트 현황
    @GetMapping("/list")
    public String list(Model model) {
        String login_id = "user1";
        model.addAttribute("projectList", projectService.getProjects(login_id));
        return "project/list";
    }

    // 프로젝트 정보
    @GetMapping("/info")
    public String info() {
        return "project/info";
    }

    // 대시보드
    @GetMapping("/dashboard")
    public String dashboard() {
        return "project/dashboard";
    }

    @PostMapping("/saveProject")
    public String saveProject(ProjectRequestDto project) {
        int result = projectService.saveProject(project);
        return "redirect:/projects/list";
    }

}
