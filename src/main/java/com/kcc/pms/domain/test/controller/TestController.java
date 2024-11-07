package com.kcc.pms.domain.test.controller;

import com.aspose.cells.SaveFormat;
import com.aspose.cells.Workbook;
import com.kcc.pms.auth.PrincipalDetail;
import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureSimpleResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestPageResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestMasterRequestDto;
import com.kcc.pms.domain.test.service.TestService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.OutputStream;
import java.util.List;

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
    public ResponseEntity<Long> insertTest(
            @AuthenticationPrincipal PrincipalDetail principal,
            HttpSession session, @RequestBody TestMasterRequestDto testReq,
            @RequestParam(value = "type") String type) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        return ResponseEntity.ok().body(testService.saveTest(principal.getMember().getMemNo(), prjNo, testReq, type));
    }

    @PutMapping("/{id}")
    @ResponseBody
    public ResponseEntity<Long> updateTest(@PathVariable Long id, @RequestBody TestMasterRequestDto testReq) {
        return ResponseEntity.ok().body(testService.updateTest(testReq));
    }

    @GetMapping("/excelDownload/{id}")
    @ResponseBody
    public ResponseEntity<HttpServletResponse> excelDownload(HttpServletResponse response, @PathVariable Long id) throws Exception {
        Workbook workbook = testService.excelDownload(response, id);
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"download.xlsx\"");
        OutputStream out = response.getOutputStream();
        workbook.save(out, SaveFormat.XLSX);
        out.flush();
        out.close();
        return ResponseEntity.ok().body(response);
    }

    @GetMapping("/{id}")
    public String getTest() {
        return "test/test";
    }

    @GetMapping("/api/{id}")
    @ResponseBody
    public ResponseEntity<TestMasterRequestDto> findById(@PathVariable Long id) {
        return ResponseEntity.ok().body(testService.getTest(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTest(@PathVariable Long id) {
        testService.deleteTest(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/features")
    @ResponseBody
    public ResponseEntity<List<FeatureSimpleResponseDto>> getFeatures(HttpSession session) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        return ResponseEntity.ok().body(testService.getFeatures(prjNo));
    }
}
