package com.kcc.pms.domain.feature.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.*;
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
                                                         @Param("prjNo") Long prjNo,
                                                         @Param("cri") CriteriaY cri);
    FeatureProgressResponseDto getProjectProgressSummary(@Param("prjNo") Long prjNo);

    FeatureDetailResponseDto getFeatureDetail(@Param("featNo") Long featNo);
    Integer updateFeature(FeatureDetailResponseDto requestDto);
    int countFeatures(@Param("systemNo") Long systemNo,
                      @Param("featClassCd") String featClassCd,
                      @Param("prjNo") Long prjNo, @Param("cri") CriteriaY cri);
    List<FeatureMemberPrgResponseDto> getMemberProgress(Long prjNo);
    MemberFeaturesResponseDto getMemberFeatures(@Param("memberNo") Long memberNo, @Param("prjNo") Long prjNo);
    List<MemberFeatGraphResponseDto> getMemberFeatureGraph(@Param("prjNo") Long prjNo, @Param("memberNo") Long memberNo);
    List<FeatureSummaryResponseDto> getDelayList(@Param("prjNo") Long prjNo);
    List<FeatureTestResponseDto> getFeatureTestNo(@Param("featNo") Long featNo);
}
