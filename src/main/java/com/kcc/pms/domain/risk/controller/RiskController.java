package com.kcc.pms.domain.risk.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kcc.pms.auth.PrincipalDetail;
import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.common.model.dto.FileResponseDto;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.risk.model.dto.RiskDto;
import com.kcc.pms.domain.risk.model.dto.RiskFileRequestDto;
import com.kcc.pms.domain.risk.service.RiskService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class RiskController {

    private final RiskService service;
    private final CommonService commonService;
    private final ObjectMapper objectMapper;

    @GetMapping("/api/risk/options")
    @ResponseBody
    public ResponseEntity<List<CommonCodeOptions>> getRiskCommonCode(){
        try {
            List<CommonCodeOptions> commonCodeOptions = service.getRiskCommonCode();
            return ResponseEntity.ok(commonCodeOptions);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Collections.emptyList());
        }
    }

    @PostMapping("/projects/risks/risk")
    @ResponseBody
    public ResponseEntity<String> insert(HttpSession session, RiskDto req, RiskFileRequestDto files,
                                         @AuthenticationPrincipal PrincipalDetail principalDetail) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        System.out.println("prjNo = " + prjNo);
        System.out.println("req = " + req);
        System.out.println("files = " + files);

        String memberName = principalDetail.getMember().getMemberName();

        req.setPrjNo(prjNo);

        Long riskNumber = service.saveRisk(req, files, memberName);
        String redirectUrl = "/projects/dangerInfo?no=" + riskNumber;
        return ResponseEntity.ok().body(redirectUrl);
    }


    @PutMapping("/projects/risks/risk")
    @ResponseBody
    public ResponseEntity<String> updateRisk(HttpSession session, RiskDto req, RiskFileRequestDto files,
                                         @AuthenticationPrincipal PrincipalDetail principalDetail) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        req.setPrjNo(prjNo);

        String memberName = principalDetail.getMember().getMemberName();
        System.out.println("update req = " + req);
        System.out.println("update files = " + files);
        service.updateRisk(req, files, memberName);

        String redirectUrl = "/projects/dangerInfo?no=" + req.getRiskNumber();

        return ResponseEntity.ok().body(redirectUrl);
    }


    @GetMapping("/projects/risks/risk/{no}")
    public ResponseEntity<RiskDto> findRiskByNo(@PathVariable Long no) {
        System.out.println("no = " + no);
        Optional<FileMasterNumbers> fileMasterNumbers = service.getFileMasterNumbers(no);

        List<FileResponseDto> discoverFiles = new ArrayList<>();
        List<FileResponseDto> workFiles = new ArrayList<>();
        if (fileMasterNumbers.isPresent()) {
            if (fileMasterNumbers.get().getFileMasterFoundNumber() != null) {
                discoverFiles = commonService.getFileList(fileMasterNumbers.get().getFileMasterFoundNumber());
            }
            if (fileMasterNumbers.get().getFileMasterWorkNumber() != null) {
                workFiles = commonService.getFileList(fileMasterNumbers.get().getFileMasterWorkNumber());
            }
        }

        String discoverFilesJson = generateFilesJson(discoverFiles);
        String workFilesJson = generateFilesJson(workFiles);

        RiskDto riskByNo = service.getRiskByNo(no);
        riskByNo.setDiscoverFilesJson(discoverFilesJson);
        riskByNo.setWorkFilesJson(workFilesJson);

        return ResponseEntity.ok(riskByNo);
//        service.getRisk(no);
//
//        model.addAttribute("req", defectService.getDefect(no));
//        model.addAttribute("discoverFilesJson", discoverFilesJson);
//        model.addAttribute("workFilesJson", workFilesJson);
//        return "danger/info";
    }


    private String generateFilesJson(List<FileResponseDto> files) {
        try {
            if (files != null && !files.isEmpty()) {
                return objectMapper.writeValueAsString(files);
            } else {
                return "[]";
            }
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Error converting files to JSON: " + e.getMessage());
        }
    }

}
