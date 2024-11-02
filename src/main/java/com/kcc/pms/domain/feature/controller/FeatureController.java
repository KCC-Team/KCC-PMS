package com.kcc.pms.domain.feature.controller;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.*;
import com.kcc.pms.domain.feature.service.FeatureService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

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
    public String featureInfo(@RequestParam(value = "featureNo", required=false) Long featureNo,
                              HttpSession session, Model model) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        model.addAttribute("prjNo", prjNo);
        model.addAttribute("featureNo", featureNo);

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
    public ResponseEntity<PagedResponse<FeatureSummaryResponseDto>> getFeatureSummary(@RequestParam(value = "systemNo", required = false) Long systemNo,
                                                                                      @RequestParam(value = "featClassCd", required = false) String featClassCd,
                                                                                      @RequestParam(defaultValue = "1") int page,
                                                                                      @RequestParam(defaultValue = "10") int pageSize,
                                                                                      @RequestParam(value = "type", required = false) String type,
                                                                                      @RequestParam(value = "keyword", required = false) String keyword,
                                                                                      HttpSession session) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        CriteriaY cri = new CriteriaY(page, pageSize);
        cri.setType(type);
        cri.setKeyword(keyword);
        System.out.println("cri = " + cri);
        List<FeatureSummaryResponseDto> systemFeatureList = service.getSystemFeatureList(systemNo, featClassCd, prjNo, cri);
        System.out.println("systemFeatureList = " + systemFeatureList);

        int totalItems = service.countFeatures(systemNo, featClassCd, prjNo, cri);
        System.out.println("totalItems = " + totalItems);
        PageYDto pageInfo = new PageYDto(cri, totalItems);
        PagedResponse<FeatureSummaryResponseDto> response = new PagedResponse<>(systemFeatureList, pageInfo);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/list/delay")
    @ResponseBody
    public ResponseEntity<?> getDelayList(HttpSession session){
        Long prjNo = (Long) session.getAttribute("prjNo");
        List<FeatureSummaryResponseDto> delayList = service.getDelayList(prjNo);
        return ResponseEntity.ok(delayList);
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


    @GetMapping("/details")
    @ResponseBody
    public ResponseEntity<FeatureDetailResponseDto> getFeatureDetail(@RequestParam("featNo") Long featNo){
        FeatureDetailResponseDto featureDetail = service.getFeatureDetail(featNo);

        if(featureDetail != null){
            return ResponseEntity.ok(featureDetail);
        } else{
            return ResponseEntity.notFound().build();
        }

    }

    @GetMapping("/members")
    @ResponseBody
    public ResponseEntity<List<FeatureMemberPrgResponseDto>> getMemberProgress(HttpSession session){
        Long prjNo = (Long) session.getAttribute("prjNo");
        List<FeatureMemberPrgResponseDto> memberProgress = service.getMemberProgress(prjNo);
        return ResponseEntity.ok(memberProgress);
    }

    @GetMapping("/member/{memberNo}")
    @ResponseBody
    public ResponseEntity<?> getMemberFeatures(@PathVariable("memberNo") Long memberNo, HttpSession session){
        System.out.println("memberNo = " + memberNo);
        Long prjNo = (Long) session.getAttribute("prjNo");
        MemberFeaturesResponseDto memberFeatures = service.getMemberFeatures(memberNo, prjNo);
        return ResponseEntity.ok(memberFeatures);
    }

    @GetMapping("/member/{memberNo}/graph")
    @ResponseBody
    public ResponseEntity<?> getMemberFeatureGraph(@PathVariable("memberNo") Long memberNo, HttpSession session){
        System.out.println("FeatureController.getMemberFeatureGraph");
        System.out.println("memberNo = " + memberNo);
        Long prjNo = (Long) session.getAttribute("prjNo");
        List<MemberFeatGraphResponseDto> memberFeatureGraph = service.getMemberFeatureGraph(prjNo, memberNo);
        return ResponseEntity.ok(memberFeatureGraph);
    }

    @PutMapping()
    @ResponseBody
    public ResponseEntity<?> update(FeatureDetailResponseDto requestDto, HttpSession session){
        Long prjNo = (Long) session.getAttribute("prjNo");
        requestDto.setPrjNo(prjNo);

        System.out.println("update requestDto = " + requestDto);
        Integer result = service.updateFeature(requestDto);

        if (result == null || result == 0) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("생성에 실패하였습니다.");
        }

        return ResponseEntity.status(HttpStatus.CREATED).body("성공적으로 수정되었습니다.");
    }

}
