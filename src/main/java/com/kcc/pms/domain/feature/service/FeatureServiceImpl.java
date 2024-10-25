package com.kcc.pms.domain.feature.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.mapper.FeatureMapper;
import com.kcc.pms.domain.feature.model.dto.FeatureCreateRequestDto;
import com.kcc.pms.domain.feature.model.dto.FeatureProgressResponseDto;
import com.kcc.pms.domain.feature.model.dto.FeatureSummaryResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FeatureServiceImpl implements FeatureService{

    private final FeatureMapper mapper;

    @Override
    public List<CommonCodeOptions> getFeatureCommonCode() {
        return mapper.getFeatureCommonCode();
    }

    @Override
    public Integer createFeature(FeatureCreateRequestDto requestDto) {
        return mapper.createFeature(requestDto);
    }

    @Override
    public FeatureProgressResponseDto getProgressSummary(Long systemNo, String featClassCd, Long prjNo) {
        return mapper.getProgressSummary(systemNo, featClassCd, prjNo);
    }

    @Override
    public List<FeatureSummaryResponseDto> getSystemFeatureList(Long systemNo, String featClassCd, Long prjNo) {
        return mapper.getSystemFeatureList(systemNo, featClassCd, prjNo);
    }

}
