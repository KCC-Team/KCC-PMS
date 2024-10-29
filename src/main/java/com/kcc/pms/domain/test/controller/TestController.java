package com.kcc.pms.domain.test.controller;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.test.domain.dto.TestPageResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
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

    @GetMapping("/options")
    @ResponseBody
    public ResponseEntity<List<CommonCodeOptions>> getDefectCommonCodeOptions() {
        return ResponseEntity.ok().body(testService.getDefectCommonCodeOptions());
    }

    @GetMapping
    public String getTestList() {
        return "test/list";
    }

    @GetMapping("/api/list")
    @ResponseBody
    public ResponseEntity<TestPageResponseDto> findAll(
            HttpSession session,
            @RequestParam(value = "work", defaultValue = "0") Long work_no,
            @RequestParam(value = "testType", defaultValue = "all") String testType,
            @RequestParam(value = "status", defaultValue = "all") String status,
            @RequestParam(value = "page", defaultValue = "1") int page) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        return ResponseEntity.ok().body(testService.getTestList(prjNo, work_no, testType, status, page));
    }

    @GetMapping("/register")
    public String showInsertForm() {
        return "test/test";
    }

    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<Void> insertTest(@RequestBody TestRequestDto testReq) {
        testService.saveTest(testReq);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(Model model, @PathVariable Long id) {
        model.addAttribute("type", "update");
//        model.addAttribute("testReq", testService.getTest(id));
        model.addAttribute("testType", Map.of(
                "0", "테스트를 선택하세요",
                "PMS01201", "단위",
                "PMS01202", "통합"
        ));
        model.addAttribute("workType", Map.of(
                0, "업무를 선택하세요",
                5, "범위관리",
                6, "일정관리",
                7, "테스트관리",
                8, "인적자원관리"
        ));
        model.addAttribute("systemType", Map.of(
                0, "시스템을 선택하세요",
                1, "A 업무 시스템",
                2, "B 업무 시스템",
                3, "C 업무 시스템"
        ));
        model.addAttribute("testStatus", Map.of(
                0, "상태를 선택하세요",
                1, "진행전",
                2, "진행중",
                3, "결함발생",
                4, "진행완료"
        ));
        return "test/test";
    }

    @GetMapping("/{id}")
    public String getTest() {
        return "test/test";
    }

    @GetMapping("/api/{id}")
    @ResponseBody
    public ResponseEntity<TestRequestDto> findById(@PathVariable Long id) {
        return ResponseEntity.ok().body(testService.getTestDetail(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTest(@PathVariable Long id) {
        testService.deleteTest(id);
        return ResponseEntity.ok().build();
    }
}
