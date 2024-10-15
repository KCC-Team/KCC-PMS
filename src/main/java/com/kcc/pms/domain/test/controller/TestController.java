package com.kcc.pms.domain.test.controller;

import com.kcc.pms.domain.test.domain.dto.TestVO;
import com.kcc.pms.domain.test.service.TestService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/projects/tests")
@RequiredArgsConstructor
public class TestController {
    private final TestService testService;

    @GetMapping
    public String getTestList() {
        return "test/list";
    }

    @GetMapping("/api/list")
    @ResponseBody
    public ResponseEntity<List<TestVO>> findAll(
            HttpSession session,
            @RequestParam(value = "sys", defaultValue = "0") Integer sys_no,
            @RequestParam(value = "work", defaultValue = "0") Integer work_no,
            @RequestParam(value = "test", defaultValue = "all") String test_type,
            @RequestParam(value = "status", defaultValue = "all") String status,
            @RequestParam(value = "page", defaultValue = "1") int page) {
//        Integer prj_no = (int) session.getAttribute("prjNo");
        Integer prj_no = 1;
        List<TestVO> testList = testService.getTestList(prj_no, sys_no, work_no, test_type, status, page);
        return ResponseEntity.ok().body(testList);
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
