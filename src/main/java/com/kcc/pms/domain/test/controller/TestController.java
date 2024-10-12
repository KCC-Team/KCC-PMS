package com.kcc.pms.domain.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/projects/tests")
public class TestController {

    @GetMapping
    public String findAll() {
        return "test/list";
    }

    @GetMapping("/register")
    public String create(Model model) {
        model.addAttribute("type", "register");
        return "test/test";
    }

    @GetMapping("/{id}")
    public String findById(Model model, @PathVariable Long id) {
        return "test/test";
    }
}
