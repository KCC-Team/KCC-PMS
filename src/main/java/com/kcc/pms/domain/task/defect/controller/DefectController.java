package com.kcc.pms.domain.task.defect.controller;

import lombok.NoArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@NoArgsConstructor
@RequestMapping("/projects/defects")
public class DefectController {

    @GetMapping
    public String findAll(){
        return "defect/list";
    }

    @GetMapping("/{id}")
    public String findById(Model model, @PathVariable Long id) {
        return "defect/defect";
    }
}
