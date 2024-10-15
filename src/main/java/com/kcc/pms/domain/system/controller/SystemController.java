package com.kcc.pms.domain.system.controller;

import com.kcc.pms.domain.system.model.dto.SystemResponseDTO;
import com.kcc.pms.domain.system.service.SystemService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class SystemController {
    private final SystemService systemService;

    @GetMapping("/systems")
    @ResponseBody
    public List<SystemResponseDTO> getSystemData(@RequestParam Long prjNo) {
        return systemService.getSystemsByProjectNo(prjNo);
    }
}
