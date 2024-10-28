package com.kcc.pms.domain.output.controller;

import com.kcc.pms.auth.PrincipalDetail;
import com.kcc.pms.domain.member.model.vo.MemberVO;
import com.kcc.pms.domain.output.domain.dto.DeleteOutputResponseDto;
import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import com.kcc.pms.domain.output.domain.dto.OutputFile;
import com.kcc.pms.domain.output.domain.dto.OutputResponseDto;
import com.kcc.pms.domain.output.service.OutputService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/projects/outputs")
@RequiredArgsConstructor
public class OutputController {
    private final OutputService outputService;

    @GetMapping
    public String list() {
        return "output/list";
    }

    @GetMapping("/{id}")
    @ResponseBody
    public ResponseEntity<OutputResponseDto> findOutput(HttpSession session, @PathVariable("id") Long id) {
//        Long prjNo = (Long) session.getAttribute("prjNo");
        Long prjNo = 1L;
        return ResponseEntity.ok().body(outputService.findOutput(prjNo, id));
    }

    @GetMapping("/api/list")
    @ResponseBody
    public ResponseEntity<List<FileStructResponseDto>> listApi(HttpSession session,
                   @RequestParam(value = "option", defaultValue = "n") String option) {
//        Long prjNo = (Long) session.getAttribute("prjNo");
        Long prjNo = 1L;
        return ResponseEntity.ok().body(outputService.findList(prjNo, option));
    }

    @PostMapping("/api/save")
    @ResponseBody
    public ResponseEntity<Void> saveOutputFolders(HttpSession session,
                            @AuthenticationPrincipal PrincipalDetail principalDetail,
                            String title,
                            @RequestPart("res") List<FileStructResponseDto> res,
                            @RequestParam("files") List<MultipartFile> files) {
        //        Long prjNo = (Long) session.getAttribute("prjNo");
        Long prjNo = 1L;
        outputService.insertOutput(prjNo, principalDetail.getMember().getMemberName(), title, res, files);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/api/fileinsert")
    @ResponseBody
    public ResponseEntity<Void> insertOutputFile(
                                    @AuthenticationPrincipal PrincipalDetail principalDetail,
                                    HttpSession session,
                                    @RequestParam("outputNo") Long outputNo,
                                    @RequestPart("files") List<MultipartFile> files) {
        //        Long prjNo = (Long) session.getAttribute("prjNo");
        Long prjNo = 1L;
        outputService.insertOutputFiles(prjNo, principalDetail.getMember().getMemberName(), outputNo, files);
        return ResponseEntity.ok().build();
    }

    @PatchMapping("/api/update")
    @ResponseBody
    public ResponseEntity<Void> updateOutputInfo(HttpSession session,
                              @RequestParam("title") String title,
                              @RequestParam("outputNo") Long outputNo) {
        outputService.updateOutputInfo(title, outputNo);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/api/update")
    @ResponseBody
    public ResponseEntity<String> updateOutputFolders(HttpSession session,
                          @RequestParam(value = "option", defaultValue = "n") String option,
                          @RequestBody List<FileStructResponseDto> res) {
        //        Long prjNo = (Long) session.getAttribute("prjNo");
        Long prjNo = 1L;
        outputService.updateOutput(prjNo, res, option, null);
        return ResponseEntity.ok().body("success");
    }

    @DeleteMapping("/api/delete")
    @ResponseBody
    public ResponseEntity<String> deleteOutput(HttpSession session, @RequestParam("outputNo") Long outputNo) {
        outputService.deleteOutput(outputNo);
        return ResponseEntity.ok().body("success");
    }

    @GetMapping("/api/delete")
    @ResponseBody
    public ResponseEntity<List<DeleteOutputResponseDto>> findDeleteOutputs(HttpSession session, @RequestParam("outputNo") Long outputNo) {
        return ResponseEntity.ok().body(outputService.findDeleteOutputs(outputNo));
    }

    @PostMapping("/api/deletefile")
    @ResponseBody
    public ResponseEntity<String> deleteOutputFile(HttpSession session,
                                                   @AuthenticationPrincipal PrincipalDetail principalDetail,
                                                   @RequestBody Map<String, List<Long>> payload) {
        List<Long> files = payload.get("files");
        outputService.deleteOutputFiles(principalDetail.getMember().getMemberName(), files);
        return ResponseEntity.ok().body("success");
    }

    @GetMapping("/search")
    public String searchOutput() {
        return "output/output-search";
    }
}
