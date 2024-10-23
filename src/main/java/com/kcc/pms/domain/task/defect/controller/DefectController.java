package com.kcc.pms.domain.task.defect.controller;

import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;
import com.kcc.pms.domain.task.defect.service.DefectService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects/defects")
public class DefectController {
    private final DefectService defectService;
    private final CommonService commonService;

    private static final String PRIORITY = "PMS006";
    private static final String STATUS = "PMS007";

    @GetMapping
    public String findAll(){
        return "defect/list";
    }

    @GetMapping("/defect")
    public String showInsertForm(Model model, @RequestParam(value = "id", required = false) Long id) {
        model.addAttribute("type", "register");
        model.addAttribute("req", new DefectDto());
        model.addAttribute("priority", commonService.getCommonCodeSelectList(PRIORITY));
        model.addAttribute("status", commonService.getCommonCodeSelectList(STATUS));
        return "defect/defect";
    }

    @PostMapping("/defect")
    @ResponseBody
    public ResponseEntity<String> insert(HttpSession session,
                                 DefectDto req, DefectFileRequestDto files,
                                 @ModelAttribute("priority") String priority,
                                 @ModelAttribute("status") String status) {
//        Long prgNo = (Long) session.getAttribute("prgNo");
        Long projectNumber = 1L;
        Long defectNumber = defectService.saveDefect(projectNumber, req, files, priority, status);
        String redirectUrl = "/projects/defects/defect?id=" + defectNumber;
        return ResponseEntity.ok().body(redirectUrl);
    }
}
