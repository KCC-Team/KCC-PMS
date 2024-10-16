package com.kcc.pms.domain.wbs.service;

import com.kcc.pms.domain.wbs.model.dto.WbsRequestDto;
import com.kcc.pms.domain.wbs.model.dto.WbsResponseDto;

import java.util.List;

public interface WbsService {
    int saveWbs(WbsRequestDto wbs);
    List<WbsResponseDto> getWbsList(Long prj_no);
}
