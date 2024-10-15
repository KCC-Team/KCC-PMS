package com.kcc.pms.domain.test.controller;

import com.kcc.pms.domain.test.domain.dto.TestInsertRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestVO;
import com.kcc.pms.domain.test.service.TestService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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
    public String showInsertForm(Model model) {
        model.addAttribute("type", "register");
        model.addAttribute("testReq", new TestInsertRequestDto());
//        model.addAttribute("testType", testService.getTestType());
        model.addAttribute("testType", Map.of(
                0, "테스트를 선택하세요",
                1, "단위",
                2, "통합"
        ));
        model.addAttribute("workType", List.of("개발", "테스트"));
        model.addAttribute("systemType", List.of("WEB", "APP"));
        model.addAttribute("testStatus", List.of("대기", "진행", "완료"));
        return "test/test";
    }

    @PostMapping("/register")
    public String insertTest(Model model, @RequestBody TestInsertRequestDto testReq) {
        System.out.println(testReq);
        testService.saveTest(testReq);
        return "redirect:/projects/tests";
    }

    @GetMapping("/{id}")
    public String findById(Model model, @PathVariable Long id, HttpSession session) {
        return "test/test";
    }
}
