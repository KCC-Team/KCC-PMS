package com.kcc.pms.domain.feature.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.mapper.FeatureMapper;
import com.kcc.pms.domain.feature.model.dto.FeatureCreateRequestDto;
import com.kcc.pms.domain.feature.model.dto.FeatureDetailResponseDto;
import com.kcc.pms.domain.feature.model.dto.FeatureProgressResponseDto;
import com.kcc.pms.domain.feature.model.dto.FeatureSummaryResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
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

    @Override
    public FeatureProgressResponseDto getProjectProgressSummary(Long prjNo) {
        return mapper.getProjectProgressSummary(prjNo);
    }

    @Override
    public List<FeatureSummaryResponseDto> getProjectFeatureList(Long prjNo) {
        return mapper.getProjectFeatureList(prjNo);
    }

    @Override
    public FeatureDetailResponseDto getFeatureDetail(Long featNo) {
        FeatureDetailResponseDto featureDetail = mapper.getFeatureDetail(featNo);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        // Date 필드를 포맷하여 String 필드에 저장
        if (featureDetail.getPreStartDate() != null) {
            featureDetail.setPreStartDateStr(sdf.format(featureDetail.getPreStartDate()));
        }
        if (featureDetail.getPreEndDate() != null) {
            featureDetail.setPreEndDateStr(sdf.format(featureDetail.getPreEndDate()));
        }
        if (featureDetail.getStartDate() != null) {
            featureDetail.setStartDateStr(sdf.format(featureDetail.getStartDate()));
        }
        if (featureDetail.getEndDate() != null) {
            featureDetail.setEndDateStr(sdf.format(featureDetail.getEndDate()));
        }

        return featureDetail;
    }

    @Override
    public Integer updateFeature(FeatureDetailResponseDto requestDto) {
        return mapper.updateFeature(requestDto);
    }

}
