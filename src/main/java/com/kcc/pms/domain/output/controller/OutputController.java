package com.kcc.pms.domain.output.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/projects/outputs")
public class OutputController {

    @GetMapping
    public String list() {
        return "output/list";
    }

    @GetMapping("/api/list")
    public ResponseEntity<?> listApi() {
        return ResponseEntity.ok().body("output list");
    }
}
