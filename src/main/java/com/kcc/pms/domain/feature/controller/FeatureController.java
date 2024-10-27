package com.kcc.pms.domain.feature.controller;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureCreateRequestDto;
import com.kcc.pms.domain.feature.model.dto.FeatureProgressResponseDto;
import com.kcc.pms.domain.feature.model.dto.FeatureSummaryResponseDto;
import com.kcc.pms.domain.feature.service.FeatureService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects/features")
public class FeatureController {

    private final FeatureService service;

    @GetMapping()
    public String featureList(){
        return "feature/list";
    }

    @GetMapping("/register")
    public String featureInfo(HttpSession session, Model model){
        Long prjNo = (Long) session.getAttribute("prjNo");
        model.addAttribute("prjNo", prjNo);
        return "feature/featureInfo";
    }

    @GetMapping("/options")
    @ResponseBody
    public List<CommonCodeOptions> getOptions(){
        return service.getFeatureCommonCode();
    }

    @PostMapping()
    @ResponseBody
    public ResponseEntity<?> createFeature(FeatureCreateRequestDto requestDto, HttpSession session){
        Long prjNo = (Long) session.getAttribute("prjNo");

        requestDto.setPrjNo(prjNo);

        Integer result = service.createFeature(requestDto);

        if (result == null || result == 0) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("생성에 실패하였습니다.");
        }

        return ResponseEntity.status(HttpStatus.CREATED).body("성공적으로 생성되었습니다.");
    }

    @GetMapping("/progress")
    @ResponseBody
    public ResponseEntity<FeatureProgressResponseDto> getProgressSummary(@RequestParam(value = "systemNo", required = false) Optional<Long> systemNo,
                                                                         @RequestParam(value = "featClassCd", required = false) String featClassCd,
                                                                         HttpSession session){
        Long prjNo = (Long) session.getAttribute("prjNo");
        Long systemNoValue = systemNo.orElse(null);

        FeatureProgressResponseDto progressSummary = service.getProgressSummary(systemNoValue, featClassCd, prjNo);

        if (progressSummary != null) {
            return ResponseEntity.ok(progressSummary);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<List<FeatureSummaryResponseDto>> getFeatureSummary(@RequestParam(value = "systemNo", required = false) Long systemNo,
                                                                             @RequestParam(value = "featClassCd", required = false) String featClassCd,
                                                                             HttpSession session) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        List<FeatureSummaryResponseDto> systemFeatureList = service.getSystemFeatureList(systemNo, featClassCd, prjNo);
        System.out.println("systemFeatureList = " + systemFeatureList);
        return ResponseEntity.ok(systemFeatureList != null ? systemFeatureList : Collections.emptyList());
    }

    @GetMapping("/totalProgress")
    @ResponseBody
    public ResponseEntity<FeatureProgressResponseDto> getProjectFeatureProgressSummary(HttpSession session) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        FeatureProgressResponseDto progressSummary = service.getProjectProgressSummary(prjNo);

        if (progressSummary != null) {
            return ResponseEntity.ok(progressSummary);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @GetMapping("/totalList")
    @ResponseBody
    public ResponseEntity<List<FeatureSummaryResponseDto>> getProjectFeatureSummary(HttpSession session){
        Long prjNo = (Long) session.getAttribute("prjNo");
        List<FeatureSummaryResponseDto> projectFeatureList = service.getProjectFeatureList(prjNo);

        if (projectFeatureList != null && !projectFeatureList.isEmpty()) {
            return ResponseEntity.ok(projectFeatureList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }


}
