package com.kcc.pms.domain.output.controller;

import com.kcc.pms.auth.PrincipalDetail;
import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.output.domain.dto.*;
import com.kcc.pms.domain.output.service.OutputService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/projects/outputs")
@RequiredArgsConstructor
public class OutputController {
    private final OutputService outputService;
    private final CommonService commonService;

    @GetMapping
    public String list() {
        return "output/list";
    }

    @GetMapping("/{id}")
    @ResponseBody
    public ResponseEntity<OutputResponseDto> findOutput(@PathVariable("id") Long id) {
        OutputResponseDto output = outputService.findOutput(id);
        return ResponseEntity.ok().body(output);
    }

    @GetMapping("/api/list")
    @ResponseBody
    public ResponseEntity<List<FileStructResponseDto>> listApi(HttpSession session,
                   @RequestParam(value = "option", defaultValue = "n") String option) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        return ResponseEntity.ok().body(outputService.findList(prjNo, option));
    }

    @PostMapping("/api/save")
    @ResponseBody
    public ResponseEntity<Long> saveOutputFolders(HttpSession session,
                            @AuthenticationPrincipal PrincipalDetail principalDetail,
                            String title,
                            String note,
                            @RequestPart("res") List<FileStructResponseDto> res,
                            @RequestParam("files") List<MultipartFile> files) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        return ResponseEntity.ok().body(outputService.insertOutput(prjNo, principalDetail.getMember().getMemberName(), title, note, res, files));
    }

    @PostMapping("/api/fileinsert")
    @ResponseBody
    public ResponseEntity<Void> insertOutputFile(
                                    @AuthenticationPrincipal PrincipalDetail principalDetail,
                                    HttpSession session,
                                    @RequestParam("outputNo") Long outputNo,
                                    @RequestPart("files") List<MultipartFile> files) {
        Long prjNo = (Long) session.getAttribute("prjNo");
        outputService.insertOutputFiles(prjNo, principalDetail.getMember().getMemberName(), outputNo, files);
        return ResponseEntity.ok().build();
    }

    @PatchMapping("/api/update")
    @ResponseBody
    public ResponseEntity<Void> updateOutputInfo(HttpSession session,
                              @RequestParam("title") String title,
                              @RequestParam("note") String note,
                              @RequestParam("outputNo") Long outputNo) {
        outputService.updateOutputInfo(title, note, outputNo);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/api/update")
    @ResponseBody
    public ResponseEntity<String> updateOutputFolders(HttpSession session,
                          @RequestParam(value = "option", defaultValue = "n") String option,
                          @RequestBody List<FileStructResponseDto> res) {
        Long prjNo = (Long) session.getAttribute("prjNo");
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

    @PostMapping("/api/downloadmultiple")
    public ResponseEntity<InputStreamResource> downloadMultipleFiles(@RequestBody List<OutputDownloadRequestDto> files) {
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ZipArchiveOutputStream zos = new ZipArchiveOutputStream(baos);

            for (OutputDownloadRequestDto output : files) {
                try {
                    byte[] fileData = commonService.downloadFile(output.getFilePath());
                    ZipArchiveEntry zipEntry = new ZipArchiveEntry(output.getFileTitle());
                    zos.putArchiveEntry(zipEntry);
                    zos.write(fileData);
                    zos.closeArchiveEntry();
                } catch (Exception e) {
                    System.out.println("Error downloading from S3: " + e.getMessage());
                }
            }

            zos.finish();
            zos.close();

            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Disposition", "attachment; filename=\"download.zip\"");

            return ResponseEntity.ok()
                    .headers(headers)
                    .contentLength(baos.size())
                    .contentType(MediaType.parseMediaType("application/zip"))
                    .body(new InputStreamResource(new ByteArrayInputStream(baos.toByteArray())));
        } catch (Exception e) {
            System.out.println("Error creating zip file: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/api/download")
    @ResponseBody
    public ResponseEntity<byte[]> downloadFile(@RequestBody OutputDownloadRequestDto file) {
        try {
            byte[] downloadFile = commonService.downloadFile(file.getFilePath());
            String contentType = "application/octet-stream";

            String encodedFileName = URLEncoder.encode(file.getFileTitle(), StandardCharsets.UTF_8).replaceAll("\\+", "%20");
            String contentDisposition = "attachment; filename=\"" + encodedFileName + "\"; filename*=UTF-8''" + encodedFileName;

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.parseMediaType(contentType));
            headers.add(HttpHeaders.CONTENT_DISPOSITION, contentDisposition);

            return ResponseEntity.ok().headers(headers).body(downloadFile);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
}
