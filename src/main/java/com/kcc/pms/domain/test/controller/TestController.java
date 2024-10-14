package com.kcc.pms.domain.test.controller;

import com.kcc.pms.domain.test.service.TestService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/projects/tests")
@RequiredArgsConstructor
public class TestController {
    private final TestService testService;

    @GetMapping
    public String findAll(
            Model model,
            HttpSession session,
            @RequestParam(value = "system", defaultValue = "0") Long systemId,
            @RequestParam(value = "work", defaultValue = "all") String work_type,
            @RequestParam(value = "test", defaultValue = "all") String test_type,
            @RequestParam(value = "page", defaultValue = "1") int page) {
        Long prj_no = (Long) session.getAttribute("prjNo");
        model.addAttribute("testList", testService.getTestList(prj_no, systemId, work_type, test_type, page));
        return "test/list";
    }

    @GetMapping("/register")
    public String create(Model model) {
        model.addAttribute("type", "register");
        return "test/test";
    }

    @GetMapping("/{id}")
    public String findById(Model model, @PathVariable Long id, HttpSession session) {
        return "test/test";
    }
}
