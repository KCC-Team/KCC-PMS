package com.kcc.pms.domain.output.service;

import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;

import java.util.List;

public interface OutputService {
    List<FileStructResponseDto> findList(Long prjNo, String option);
}
