package com.kcc.pms.domain.feature.controller;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.service.FeatureService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects/features")
public class FeatureController {

    private final FeatureService service;

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

    @GetMapping("/options")
    @ResponseBody
    public List<CommonCodeOptions> getOptions(){
        return service.getFeatureCommonCode();
    }
}
