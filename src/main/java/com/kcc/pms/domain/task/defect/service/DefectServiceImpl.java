package com.kcc.pms.domain.task.defect.service;

import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectRequestDto;
import com.kcc.pms.domain.task.defect.mapper.DefectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DefectServiceImpl implements DefectService {
    private final DefectMapper defectMapper;
    private final CommonService commonService;

    @Transactional
    @Override
    public void saveDefect(Long prgNo, DefectRequestDto req, DefectFileRequestDto files, String order, String status) {
        Long[] numbers = generateFiles(prgNo, files);

        Map<String, Object> map = Map.of(
                "req", req,
                "order", order,
                "status", status,
                "numbers", numbers
        );
//        defectMapper.saveDefect(req, files, order, status);
    }

    private Long[] generateFiles(Long prgNo, DefectFileRequestDto files) {
        Long[] numbers = new Long[2];

        if (files.getDis_files() != null) {
            numbers[0] = commonService.fileUpload(files.getDis_files(), prgNo, null);
        }
        if (files.getWork_files() != null) {
            numbers[1] = commonService.fileUpload(files.getWork_files(), prgNo, null);
        }

        return numbers;
    }
}
