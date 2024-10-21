package com.kcc.pms.domain.feature.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects/features")
public class FeatureController {

    @GetMapping()
    public String featureList(){
        return "feature/list";
    }

    @GetMapping("/register")
    public String featureInfo(HttpSession session){
        Integer prjNo = (Integer) session.getAttribute("prjNo");
        System.out.println("prjNo = " + prjNo);
        return "feature/featureInfo";
    }
}
