package com.kcc.pms.domain.task.danger.controller;

import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@NoArgsConstructor
@RequestMapping("/projects")
public class DangerController {

    @GetMapping("/dangers")
    public String danger(){
        return "danger/danger_list";
    }

    @GetMapping("/dangerInfo")
    public String dangerInfo() {
        return "danger/info";
    }
}
