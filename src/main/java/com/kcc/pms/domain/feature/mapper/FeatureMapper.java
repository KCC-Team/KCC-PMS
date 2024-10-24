package com.kcc.pms.domain.feature.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureCreateRequestDto;
import com.kcc.pms.domain.feature.model.dto.FeatureProgressResponseDto;
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
}
