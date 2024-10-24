package com.kcc.pms.domain.feature.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureCreateRequestDto;
import com.kcc.pms.domain.feature.model.dto.FeatureProgressRequestDto;
import com.kcc.pms.domain.feature.model.dto.FeatureProgressResponseDto;

import java.util.List;

public interface FeatureService {
    List<CommonCodeOptions> getFeatureCommonCode();
    Integer createFeature(FeatureCreateRequestDto requestDto);
    FeatureProgressResponseDto getProgressSummary(FeatureProgressRequestDto requestDto, Long prjNo);
}
