package com.kcc.pms.domain.task.defect.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kcc.pms.auth.PrincipalDetail;
import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.common.model.dto.FileResponseDto;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectPageResponseDto;
import com.kcc.pms.domain.task.defect.service.DefectService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects/defects")
public class DefectController {
	private final DefectService defectService;
	private final CommonService commonService;

	private final ObjectMapper objectMapper;

	@GetMapping("/options")
	@ResponseBody
	public ResponseEntity<List<CommonCodeOptions>> getDefectCommonCodeOptions() {
		return ResponseEntity.ok().body(defectService.getDefectCommonCodeOptions());
	}

	@GetMapping("/defect")
	public String showInsertForm(Model model,
								 @RequestParam(value = "test", required = false) Long testNO,
								 @RequestParam(value = "testDetailNo", required = false) Long testDetailNo,
								 @RequestParam(value = "testDetailId", required = false) String testDetailId) {
		DefectDto defectDto = new DefectDto();
		defectDto.setTestNo(testNO);
		defectDto.setTestDetailNo(testDetailNo);
		defectDto.setTestDetailId(testDetailId);
		model.addAttribute("req", defectDto);
		return "defect/defect";
	}

	@PostMapping("/defect")
	@ResponseBody
	public ResponseEntity<String> insert(HttpSession session, DefectDto req, DefectFileRequestDto files,
			@AuthenticationPrincipal PrincipalDetail principalDetail) {
        Long projectNo = (Long) session.getAttribute("prjNo");
		Long defectNumber = defectService.saveDefect(projectNo, principalDetail.getMember().getMemberName(), req,
				files);
		String redirectUrl = "/projects/defects/" + defectNumber;
		return ResponseEntity.ok().body(redirectUrl);
	}

	@GetMapping("/{no}")
	public String findDefect(Model model, @PathVariable Long no) {
		Optional<FileMasterNumbers> fileMasterNumbers = defectService.getFileMasterNumbers(no);

		List<FileResponseDto> discoverFiles = new ArrayList<>();
		List<FileResponseDto> workFiles = new ArrayList<>();
		if (fileMasterNumbers.isPresent()) {
			if (fileMasterNumbers.get().getFileMasterFoundNumber() != null) {
				discoverFiles = commonService.getFileList(fileMasterNumbers.get().getFileMasterFoundNumber());
			}
			if (fileMasterNumbers.get().getFileMasterWorkNumber() != null) {
				workFiles = commonService.getFileList(fileMasterNumbers.get().getFileMasterWorkNumber());
			}
		}

		String discoverFilesJson = generateFilesJson(discoverFiles);
		String workFilesJson = generateFilesJson(workFiles);

		model.addAttribute("req", defectService.getDefect(no));
		model.addAttribute("discoverFilesJson", discoverFilesJson);
		model.addAttribute("workFilesJson", workFilesJson);
		return "defect/defect";
	}

	@PutMapping("/{no}")
	@ResponseBody
	public ResponseEntity<String> update(HttpServletResponse response, HttpSession session, @PathVariable Long no,
			DefectDto req, DefectFileRequestDto files, @AuthenticationPrincipal PrincipalDetail principalDetail)
			throws IOException {
		Long prjNo = (Long) session.getAttribute("prjNo");
		defectService.updateDefect(prjNo, principalDetail.getMember().getMemberName(), no, req, files);
		String redirectUrl = "/projects/defects/" + no;
		return ResponseEntity.ok().body(redirectUrl);
	}

	@DeleteMapping("/{no}")
	@ResponseBody
	public ResponseEntity<String> delete(@PathVariable Long no) {
		defectService.deleteDefect(no);
		return ResponseEntity.ok().body("success");
	}

	@GetMapping
	public String findAll() {
		return "defect/list";
	}

	@GetMapping("/api/list")
	@ResponseBody
	public ResponseEntity<DefectPageResponseDto> findAll(HttpServletResponse response, HttpSession session,
			@RequestParam(value = "workNo", defaultValue = "0") Long workNo,
			@RequestParam(value = "type", defaultValue = "all") String type,
			@RequestParam(value = "status", defaultValue = "all") String status,
			@RequestParam(value = "search", defaultValue = "") String search,
			@RequestParam(value = "page", defaultValue = "1") int page) throws IOException {
		Long projectNo = (Long) session.getAttribute("prjNo");
		if (projectNo == null) {
			response.sendRedirect("/projects/dashboardInfo");
			return ResponseEntity.ok().body(null);
		}

		return ResponseEntity.ok().body(defectService.getDefectList(projectNo, workNo, type, status, search, page));
	}

	private String generateFilesJson(List<FileResponseDto> files) {
		try {
			if (files != null && !files.isEmpty()) {
				return objectMapper.writeValueAsString(files);
			} else {
				return "[]";
			}
		} catch (JsonProcessingException e) {
			throw new RuntimeException("Error converting files to JSON: " + e.getMessage());
		}
	}
}
