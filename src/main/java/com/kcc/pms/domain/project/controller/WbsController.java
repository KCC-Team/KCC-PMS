package com.kcc.pms.domain.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/projects")
public class WbsController {

    @GetMapping("/wbsList")
    public String wbs() {
        return "wbs/wbsList";
    }

    @GetMapping("/wbsInfo")
    public String wbsInfo() {
        return "wbs/wbsInfo";
    }

}
