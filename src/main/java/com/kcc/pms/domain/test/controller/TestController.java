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
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "page", defaultValue = "1") int page) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        return ResponseEntity.ok().body(testService.getTestList(prjNo, work_no, testType, status, search, page));
    }

    @GetMapping("/test")
    public String showInsertForm() {
        return "test/test";
    }

    @PostMapping("/test")
    @ResponseBody
    public ResponseEntity<Void> insertTest(@RequestBody TestRequestDto testReq) {
        testService.saveTest(testReq);
        return ResponseEntity.ok().build();
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
