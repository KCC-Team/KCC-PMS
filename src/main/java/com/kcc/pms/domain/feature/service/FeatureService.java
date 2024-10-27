package com.kcc.pms.domain.feature.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureCreateRequestDto;
import com.kcc.pms.domain.feature.model.dto.FeatureProgressResponseDto;
import com.kcc.pms.domain.feature.model.dto.FeatureSummaryResponseDto;

import java.util.List;

public interface FeatureService {
    List<CommonCodeOptions> getFeatureCommonCode();
    Integer createFeature(FeatureCreateRequestDto requestDto);
    FeatureProgressResponseDto getProgressSummary(Long systemNo, String featClassCd, Long prjNo);
    List<FeatureSummaryResponseDto> getSystemFeatureList(Long systemNo, String featClassCd, Long prjNo);
    FeatureProgressResponseDto getProjectProgressSummary(Long prjNo);
    List<FeatureSummaryResponseDto> getProjectFeatureList(Long prjNo);
}
