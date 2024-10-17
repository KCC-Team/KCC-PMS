package com.kcc.pms.domain.test.controller;

import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
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
        model.addAttribute("testReq", new TestRequestDto());
//        model.addAttribute("testType", testService.getTestType());
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
    public ResponseEntity<TestRequestDto> findById(@PathVariable Integer id) {
        return ResponseEntity.ok().body(testService.getTestDetail(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTest(@PathVariable Integer id) {
        testService.deleteTest(id);
        return ResponseEntity.ok().build();
    }
}
