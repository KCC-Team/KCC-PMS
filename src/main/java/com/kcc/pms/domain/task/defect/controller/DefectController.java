package com.kcc.pms.domain.task.defect.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kcc.pms.auth.PrincipalDetail;
import com.kcc.pms.domain.common.model.dto.FileResponseDto;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectResponseDto;
import com.kcc.pms.domain.task.defect.service.DefectService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects/defects")
public class DefectController {
    private final DefectService defectService;
    private final CommonService commonService;

    private final ObjectMapper objectMapper;

    private static final String PRIORITY = "PMS006";
    private static final String STATUS = "PMS007";
    private static final String TYPE = "PMS008";

    @GetMapping("/defect")
    public String showInsertForm(Model model) {
        model.addAttribute("req", new DefectDto());
        model.addAttribute("priority", commonService.getCommonCodeSelectList(PRIORITY));
        model.addAttribute("status", commonService.getCommonCodeSelectList(STATUS));
        model.addAttribute("type", commonService.getCommonCodeSelectList(TYPE));
        return "defect/defect";
    }

    @PostMapping("/defect")
    @ResponseBody
    public ResponseEntity<String> insert(HttpSession session,
                                 DefectDto req, DefectFileRequestDto files,
                                 @AuthenticationPrincipal PrincipalDetail principalDetail,
                                 @ModelAttribute("priority") String priority,
                                 @ModelAttribute("status") String status,
                                 @ModelAttribute("type") String type) {
//        Long projectNo = (Long) session.getAttribute("prgNo");
        Long projectNo = 1L;
        Long defectNumber = defectService.saveDefect(projectNo, principalDetail.getMember().getMemberName(), req, files, priority, status,type);
        String redirectUrl = "/projects/defects/" + defectNumber;
        return ResponseEntity.ok().body(redirectUrl);
    }

    @GetMapping("/{no}")
    public String findDefect(Model model, @PathVariable Long no) {
        Optional<FileMasterNumbers> fileMasterNumbers = defectService.getFileMasterNumbers(no);

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

        model.addAttribute("req", defectService.getDefect(no));
        model.addAttribute("discoverFilesJson", discoverFilesJson);
        model.addAttribute("workFilesJson", workFilesJson);
        model.addAttribute("priority", commonService.getCommonCodeSelectList(PRIORITY));
        model.addAttribute("status", commonService.getCommonCodeSelectList(STATUS));
        model.addAttribute("type", commonService.getCommonCodeSelectList(TYPE));

        return "defect/defect";
    }

    @PutMapping("/{no}")
    @ResponseBody
    public ResponseEntity<String> update(@PathVariable Long no, DefectDto req, DefectFileRequestDto files,
                                         @AuthenticationPrincipal PrincipalDetail principalDetail,
                                         @ModelAttribute("priority") String priority,
                                         @ModelAttribute("status") String status,
                                         @ModelAttribute("type") String type) {
        //        Long prgNo = (Long) session.getAttribute("prgNo");
        Long projectNumber = 1L;
        defectService.updateDefect(projectNumber, principalDetail.getMember().getMemberName(), no, req, files, priority, status, type);
        String redirectUrl = "/projects/defects/" + no;
        return ResponseEntity.ok().body(redirectUrl);
    }

    @DeleteMapping("/{no}")
    @ResponseBody
    public ResponseEntity<String> delete(@PathVariable Long no) {
        defectService.deleteDefect(no);
        return ResponseEntity.ok().body("success");
    }

    @GetMapping
    public String findAll(Model model) {
        model.addAttribute("status", commonService.getCommonCodeSelectList(STATUS));
        return "defect/list";
    }

    @GetMapping("/api/list")
    @ResponseBody
    public ResponseEntity<List<DefectResponseDto>> findAll(
            HttpSession session,
            @RequestParam(value = "workNo", defaultValue = "0") Long workNo,
            @RequestParam(value = "status", defaultValue = "all") String status,
            @RequestParam(value = "search", defaultValue = "") String search,
            @RequestParam(value = "page", defaultValue = "1") int page) {
//        Long projectNo = (Long) session.getAttribute("prjNo");
        Long projectNo = 1L;
        return ResponseEntity.ok().body(defectService.getDefectList(projectNo, workNo, status, search, page));
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
