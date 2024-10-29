package com.kcc.pms.domain.wbs.controller;

import com.kcc.pms.auth.PrincipalDetail;
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
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
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
    public ResponseEntity<List<WbsResponseDto>> list(HttpSession session) {
        Long prjNo = (Long)session.getAttribute("prjNo");

        List<WbsResponseDto> wbsList = wbsService.getWbsList(prjNo, null);

        return ResponseEntity.ok(wbsList);
    }

    @GetMapping("/api/wbs/info")
    @ResponseBody
    public ResponseEntity<List<WbsResponseDto>> info(Long tsk_no, HttpSession session) {
        Long prjNo = (Long)session.getAttribute("prjNo");

        List<WbsResponseDto> wbsList = wbsService.getWbsList(prjNo, tsk_no);

        return ResponseEntity.ok(wbsList);
    }

    @GetMapping("/api/wbs/topTask")
    @ResponseBody
    public ResponseEntity<List<WbsResponseDto>> topTask(Long tsk_no, HttpSession session) {
        Long prjNo = (Long)session.getAttribute("prjNo");

        List<WbsResponseDto> wbsList = wbsService.getTopTaskList(prjNo, tsk_no);

        return ResponseEntity.ok(wbsList);
    }

    @GetMapping("/api/wbs/output")
    @ResponseBody
    public ResponseEntity<List<WbsResponseDto>> output(Long tsk_no) {
        List<WbsResponseDto> wbsOutputList = wbsService.getWbsOutputList(tsk_no);

        return ResponseEntity.ok(wbsOutputList);
    }

    @PostMapping("/api/wbs")
    @ResponseBody
    public ResponseEntity<String> saveWbs(WbsRequestDto wbs, HttpSession session, @AuthenticationPrincipal PrincipalDetail principalDetail) {
        String login_id = principalDetail.getMember().getId(); // 회원아이디(세션정보)
        Long prjNo = (Long) session.getAttribute("prjNo"); // 프로젝트번호(세션정보)
        wbs.setReg_id(login_id);
        wbs.setPrj_no(prjNo);

        try {
            int result = wbsService.saveWbs(wbs);
            if (result > 0) {
                return ResponseEntity.ok("success save wbs");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail save wbs");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error: " + e.getMessage());
        }
    }

    @PostMapping("/wbs/updateOrder")
    @ResponseBody
    public void updateOrder(@RequestBody WbsOrderUpdateRequestDto request) {
        wbsService.updateOrder(request.getWbsNo(), request.getNewParentNo(), request.getNewPosition() + 1);
    }

    @PutMapping("/api/wbs")
    @ResponseBody
    public ResponseEntity<String> updateWbs(WbsRequestDto request, HttpSession session) {
        Long prjNo = (Long)session.getAttribute("prjNo");
        request.setPrj_no(prjNo);

        try {
            int result = wbsService.updateWbs(request);
            if (result > 0) {
                return ResponseEntity.ok("success update wbs");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail update wbs");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error: " + e.getMessage());
        }
    }

    @DeleteMapping("/api/wbs")
    @ResponseBody
    public ResponseEntity<String> deleteWbs(WbsRequestDto request, HttpSession session) {
        Long prjNo = (Long)session.getAttribute("prjNo");

        try {
            int result = wbsService.deleteWbs(prjNo, request.getTsk_no());
            if (result > 0) {
                return ResponseEntity.ok("success delete wbs");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail delete wbs");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error: " + e.getMessage());
        }
    }

}
