package com.kcc.pms.domain.risk.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.risk.mapper.RiskMapper;
import com.kcc.pms.domain.risk.model.dto.CriteriaRisk;
import com.kcc.pms.domain.risk.model.dto.RiskDto;
import com.kcc.pms.domain.risk.model.dto.RiskFileRequestDto;
import com.kcc.pms.domain.risk.model.dto.RiskSummaryResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
@RequiredArgsConstructor
public class RiskServiceImpl implements RiskService {
    private final RiskMapper mapper;
    private final CommonService commonService;

    @Override
    public List<CommonCodeOptions> getRiskCommonCode() {
        return mapper.getRiskCommonCode();
    }

    @Override
    public Long saveRisk(RiskDto req, RiskFileRequestDto files, String memberName) {
        Long[] numbers = generateFiles(req.getPrjNo(), memberName, files);
        int isPassed = mapper.saveRisk(req, numbers[0], numbers[1]);
        if (isPassed != 1) {
            throw new RuntimeException("Risk 저장 중 오류가 발생했습니다.");
        }
        return req.getRiskNumber();
    }

    @Override
    public Optional<FileMasterNumbers> getFileMasterNumbers(Long no) {
        return mapper.getFileMasterNumbers(no);
    }

    @Override
    public RiskDto getRiskByNo(Long riskNo) {
        return mapper.getRiskByNo(riskNo);
    }


    @Override
    public void updateRisk(RiskDto req, RiskFileRequestDto files, String memberName) {
        Optional<FileMasterNumbers> numbers = mapper.getFileMasterNumbers(req.getRiskNumber());
        if (numbers.isPresent()) {
            if (numbers.get().getFileMasterFoundNumber() != null && files.getDisFiles() != null) {
                commonService.generateFiles(req.getPrjNo(), memberName, files.getDisFiles(), numbers.get().getFileMasterFoundNumber());
            }
            if (numbers.get().getFileMasterWorkNumber() != null && files.getWorkFiles() != null) {
                commonService.generateFiles(req.getPrjNo(), memberName, files.getWorkFiles(), numbers.get().getFileMasterWorkNumber());
            }
        }

        Optional.ofNullable(files.getDeleteFiles())
                .ifPresent(deleteFiles -> deleteFiles.forEach(file -> {
                    commonService.deleteFileDetail(memberName, file);
                }));
        int isPassed = mapper.updateRiskInfo(req);
        if (isPassed != 1) {
            throw new RuntimeException("Risk 수정 중 오류가 발생했습니다.");
        }
    }

    @Override
    public List<RiskSummaryResponseDto> getRiskList(CriteriaRisk cri) {
        Map<String, Object> params = makeParams(cri);

        List<RiskSummaryResponseDto> riskList = mapper.getRiskList(params);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for (RiskSummaryResponseDto risk : riskList) {
            if(risk.getCompleteDate() != null){
                risk.setCompleteDateStr(sdf.format(risk.getCompleteDate()));
            }
            if(risk.getDueDate() != null){
                risk.setDueDateStr(sdf.format(risk.getDueDate()));
            }
        }

        return riskList;
    }

    @Override
    public int countRisks(CriteriaRisk cri) {
        Map<String, Object> params = makeParams(cri);
        System.out.println("Params: " + params); // 로그로 파라미터 확인
        return mapper.countRisks(params);
    }

    private static Map<String, Object> makeParams(CriteriaRisk cri) {
        Map<String, Object> params = new HashMap<>();
        params.put("prjNo", cri.getPrjNo());
        params.put("startRow", cri.getStartRow());
        params.put("endRow", cri.getEndRow());

        params.put("systemNo", cri.getFilters().get("systemNo"));
        params.put("selectedClassNo", cri.getFilters().get("selectedClassNo"));
        params.put("selectedStatusNo", cri.getFilters().get("selectedStatusNo"));
        params.put("selectedPriorNo", cri.getFilters().get("selectedPriorNo"));
        params.put("keyword", cri.getFilters().get("keyword"));
        return params;
    }


    private Long[] generateFiles(Long projectNumber, String memberName, RiskFileRequestDto files) {
        Long[] numbers = new Long[2];
        List<MultipartFile> nullDisFiles = new ArrayList<>();
        List<MultipartFile> nullWorkFiles = new ArrayList<>();

        if (files.getDisFiles() == null) {
            numbers[0] = commonService.fileUpload(nullDisFiles, memberName, projectNumber, null);
        }

        if (files.getWorkFiles() == null) {
            numbers[1] = commonService.fileUpload(nullWorkFiles, memberName, projectNumber, null);
        }

        if (files.getDisFiles() != null) {
            numbers[0] = commonService.fileUpload(files.getDisFiles(), memberName, projectNumber, null);
        }
        if (files.getWorkFiles() != null) {
            numbers[1] = commonService.fileUpload(files.getWorkFiles(), memberName, projectNumber, null);
        }

        return numbers;
    }
}
