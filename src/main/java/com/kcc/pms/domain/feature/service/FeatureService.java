package com.kcc.pms.domain.feature.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.*;
import org.apache.ibatis.annotations.Param;


import java.util.List;

public interface FeatureService {
    List<CommonCodeOptions> getFeatureCommonCode();
    Integer createFeature(FeatureCreateRequestDto requestDto);
    FeatureProgressResponseDto getProgressSummary(Long systemNo, String featClassCd, Long prjNo);
    List<FeatureSummaryResponseDto> getSystemFeatureList(Long systemNo, String featClassCd, Long prjNo, CriteriaY cri);
    FeatureProgressResponseDto getProjectProgressSummary(Long prjNo);
    FeatureDetailResponseDto getFeatureDetail(Long featNo);
    Integer updateFeature(FeatureDetailResponseDto requestDto);
    int countFeatures(Long systemNo, String featClassCd, Long prjNo, CriteriaY cri);
    List<FeatureMemberPrgResponseDto> getMemberProgress(Long prjNo);
    MemberFeaturesResponseDto getMemberFeatures(Long memberNo, Long prjNo);
    List<MemberFeatGraphResponseDto> getMemberFeatureGraph(@Param("prjNo") Long prjNo, @Param("memberNo") Long memberNo);
}
