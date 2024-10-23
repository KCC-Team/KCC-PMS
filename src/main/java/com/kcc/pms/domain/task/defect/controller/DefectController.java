package com.kcc.pms.domain.task.defect.controller;

import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectRequestDto;
import com.kcc.pms.domain.task.defect.service.DefectService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects/defects")
public class DefectController {
    private final DefectService defectService;
    private final CommonService commonService;

    private static final String ORDER = "PMS006";
    private static final String STATUS = "PMS007";

    @GetMapping
    public String findAll(){
        return "defect/list";
    }

    @GetMapping("/defect")
    public String showInsertForm(Model model, @RequestParam(value = "id", required = false) Long id) {
        model.addAttribute("type", "register");
        model.addAttribute("req", new DefectRequestDto());
        model.addAttribute("order", commonService.getCommonCodeSelectList(ORDER));
        model.addAttribute("status", commonService.getCommonCodeSelectList(STATUS));
        return "defect/defect";
    }

    @PostMapping("/defect")
    public String insert(HttpSession session,
                       DefectRequestDto req, DefectFileRequestDto files,
                         @ModelAttribute("order") String order,
                         @ModelAttribute("status") String status) {
//        Long prgNo = (Long) session.getAttribute("prgNo");
        Long prgNo = 1L;
        defectService.saveDefect(prgNo, req, files, order, status);
        return "redirect:/projects/defects/defect";
    }
}
