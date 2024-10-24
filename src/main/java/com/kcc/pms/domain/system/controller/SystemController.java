package com.kcc.pms.domain.system.controller;

import com.kcc.pms.domain.system.model.dto.SystemResponseDTO;
import com.kcc.pms.domain.system.service.SystemService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/systems")
public class SystemController {
    private final SystemService systemService;

    @GetMapping
    @ResponseBody
    public List<SystemResponseDTO> getSystemData(HttpSession session) {
//        Long prjNo = (Long) session.getAttribute("prjNo");
        Long prjNo = 1L;
        return systemService.getSystemsByProjectNo(prjNo);
    }
}
