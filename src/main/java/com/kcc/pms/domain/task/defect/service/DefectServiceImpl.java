package com.kcc.pms.domain.task.defect.service;

import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;
import com.kcc.pms.domain.task.defect.mapper.DefectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DefectServiceImpl implements DefectService {
    private final DefectMapper defectMapper;
    private final CommonService commonService;

    @Transactional
    @Override
    public Long saveDefect(Long projectNumber, DefectDto defect, DefectFileRequestDto files, String priority, String status) {
        Long[] numbers = generateFiles(projectNumber, files);

        Map<String, Object> map = new HashMap<>();
        map.put("defect", defect);
        map.put("priority", priority);
        map.put("status", status);
        map.put("numbers", numbers);
        map.put("projectNumber", projectNumber);

        defectMapper.saveDefect(map);
        return ((DefectDto) map.get("defect")).getDefectNumber();
    }

    private Long[] generateFiles(Long projectNumber, DefectFileRequestDto files) {
        Long[] numbers = new Long[2];

        if (files.getDisFiles() != null) {
            numbers[0] = commonService.fileUpload(files.getDisFiles(), projectNumber, null);
        }
        if (files.getWorkFiles() != null) {
            numbers[1] = commonService.fileUpload(files.getWorkFiles(), projectNumber, null);
        }

        return numbers;
    }
}
