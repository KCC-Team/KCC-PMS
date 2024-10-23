package com.kcc.pms.domain.task.defect.service;

import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectRequestDto;

public interface DefectService {
    void saveDefect(Long prgNo, DefectRequestDto req, DefectFileRequestDto files, String order, String status);
}
