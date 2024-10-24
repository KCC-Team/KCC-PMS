package com.kcc.pms.domain.task.issue.controller;

import lombok.NoArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@NoArgsConstructor
@RequestMapping("/projects")
public class IssueController {

    @GetMapping("/issues")
    public String issueList() {
        return "issue/list";
    }

    @GetMapping("/issueInfo")
    public String issueInfo() {
        return "issue/info";
    }

}
