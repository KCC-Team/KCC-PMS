package com.kcc.pms.domain.risk.controller;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.risk.service.RiskService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collections;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class RiskController {

    private final RiskService service;

    @GetMapping("/api/risk/options")
    @ResponseBody
    public ResponseEntity<List<CommonCodeOptions>> getRiskCommonCode(){
        try {
            List<CommonCodeOptions> commonCodeOptions = service.getRiskCommonCode();
            return ResponseEntity.ok(commonCodeOptions);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Collections.emptyList());
        }

//        } catch (Exception e) {
//
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
//                    .body(Collections.emptyList());
//        }
    }

}
