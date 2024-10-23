package com.kcc.pms.domain.task.defect.service;

import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;

public interface DefectService {
    Long saveDefect(Long prgNo, DefectDto req, DefectFileRequestDto files, String priority, String status);
}
