package com.kcc.pms.domain.task.defect.controller;

import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.task.defect.domain.dto.DefectRequestDto;
import com.kcc.pms.domain.task.defect.service.DefectService;
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
    public String showInsertForm(Model model) {
        model.addAttribute("type", "register");
        model.addAttribute("req", new DefectRequestDto());
        model.addAttribute("order", commonService.getCommonCodeSelectList(ORDER));
        model.addAttribute("status", commonService.getCommonCodeSelectList(STATUS));
        return "defect/defect";
    }

    @PostMapping("/defect")
    public String insert(DefectRequestDto req,
                         @ModelAttribute("order") String order,
                         @ModelAttribute("status") String status) {
        System.out.println("order = " + order);
        System.out.println("status = " + status);
        System.out.println("req = " + req);
        return "redirect:/projects/defects/defect";
    }

    @PostMapping("/files-dis")
    @ResponseBody
    public ResponseEntity<Void> saveDefectFilesDiscover(List<MultipartFile> files) {
        System.out.println("discover files = " + files);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/files-work")
    @ResponseBody
    public ResponseEntity<Void> saveDefectFilesWork(List<MultipartFile> files) {
        System.out.println("work files = " + files);
        commonService.fileUpload(files, 1L, null);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/{id}")
    public String findById(Model model, @PathVariable Long id) {
        return "defect/defect";
    }
}
