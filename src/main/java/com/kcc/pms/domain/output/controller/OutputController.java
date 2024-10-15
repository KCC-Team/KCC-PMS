package com.kcc.pms.domain.output.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/outputs")
public class OutputController {

    @GetMapping
    public String list() {
        return "output/list";
    }
}
