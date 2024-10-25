package com.kcc.pms.domain.output.controller;

import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import com.kcc.pms.domain.output.service.OutputService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/projects/outputs")
@RequiredArgsConstructor
public class OutputController {
    private final OutputService outputService;

    @GetMapping
    public String list() {
        return "output/list";
    }

    @GetMapping("/api/list")
    @ResponseBody
    public ResponseEntity<List<FileStructResponseDto>> listApi(HttpSession session,
                   @RequestParam(value = "option", defaultValue = "n") String option) {
//        Long prjNo = (Long) session.getAttribute("prjNo");
        Long prjNo = 1L;
        return ResponseEntity.ok().body(outputService.findList(prjNo, option));
    }
}
