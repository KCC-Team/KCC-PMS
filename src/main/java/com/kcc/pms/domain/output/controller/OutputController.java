package com.kcc.pms.domain.output.controller;

import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import com.kcc.pms.domain.output.service.OutputService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
    public ResponseEntity<FileStructResponseDto> listApi() {
        return ResponseEntity.ok().body(outputService.showOutputList());
    }
}
