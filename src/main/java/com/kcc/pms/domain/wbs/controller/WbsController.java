package com.kcc.pms.domain.wbs.controller;

import com.kcc.pms.domain.project.model.dto.CombinedProjectResponseDto;
import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.team.model.dto.TeamOrderUpdateRequestDto;
import com.kcc.pms.domain.wbs.model.dto.WbsOrderUpdateRequestDto;
import com.kcc.pms.domain.wbs.model.dto.WbsRequestDto;
import com.kcc.pms.domain.wbs.model.dto.WbsResponseDto;
import com.kcc.pms.domain.wbs.service.WbsService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects")
public class WbsController {

    private final WbsService wbsService;

    @GetMapping("/wbsList")
    public String wbs() {
        return "wbs/wbsList";
    }

    @GetMapping("/wbsInfo")
    public String wbsInfo() {
        return "wbs/wbsInfo";
    }

    @GetMapping("/api/wbs")
    @ResponseBody
    public ResponseEntity<List<WbsResponseDto>> info(HttpSession session) {
        int prjNo = (int)session.getAttribute("prjNo");
        Long prjNoLong = Long.valueOf(prjNo);

        List<WbsResponseDto> wbsList = wbsService.getWbsList(prjNoLong);

        return ResponseEntity.ok(wbsList);
    }

    @PostMapping("/api/wbs")
    @ResponseBody
    public ResponseEntity<String> saveWbs(WbsRequestDto wbs, HttpSession session) {
        String login_id = "user1"; // 회원아이디(세션정보)
        int prjNo = (int) session.getAttribute("prjNo"); // 프로젝트번호(세션정보)
        Long prjNoLong = Long.valueOf(prjNo);
        wbs.setReg_id(login_id);
        wbs.setPrj_no(prjNoLong);


        try {
            int result = wbsService.saveWbs(wbs);
            if (result > 0) {
                return ResponseEntity.ok("success save wbs");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail save wbs");
            }
        } catch (Exception e) {
            System.out.println("e.getMessage() = " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error: " + e.getMessage());
        }
    }

    @PostMapping("/wbs/updateOrder")
    @ResponseBody
    public void updateOrder(@RequestBody WbsOrderUpdateRequestDto request){
        wbsService.updateOrder(request.getWbsNo(), request.getNewParentNo(), request.getNewPosition() + 1);
    }

}
