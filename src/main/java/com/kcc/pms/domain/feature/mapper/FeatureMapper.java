package com.kcc.pms.domain.feature.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureCreateRequestDto;
import com.kcc.pms.domain.feature.model.dto.FeatureDetailResponseDto;
import com.kcc.pms.domain.feature.model.dto.FeatureProgressResponseDto;
import com.kcc.pms.domain.feature.model.dto.FeatureSummaryResponseDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface FeatureMapper {
    List<CommonCodeOptions> getFeatureCommonCode();
    Integer createFeature(FeatureCreateRequestDto requestDto);
    FeatureProgressResponseDto getProgressSummary(@Param("systemNo") Long systemNo,
                                                  @Param("featClassCd") String featClassCd,
                                                  @Param("prjNo") Long prjNo);
    List<FeatureSummaryResponseDto> getSystemFeatureList(@Param("systemNo") Long systemNo,
                                                         @Param("featClassCd") String featClassCd,
                                                         @Param("prjNo") Long prjNo);
    FeatureProgressResponseDto getProjectProgressSummary(@Param("prjNo") Long prjNo);
    List<FeatureSummaryResponseDto> getProjectFeatureList(@Param("prjNo") Long prjNo);
    FeatureDetailResponseDto getFeatureDetail(@Param("featNo") Long featNo);
    Integer updateFeature(FeatureDetailResponseDto requestDto);
}
