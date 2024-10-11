package com.kcc.pms.domain.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/projects/tests")
public class TestController {

    @GetMapping("/list")
    public String list() {
        return "test/list";
    }

    @GetMapping("/register")
    public String create(Model model) {
        model.addAttribute("type", "register");
        return "test/test";
    }
}
