package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureSimpleResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestMasterRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestPageResponseDto;

import java.util.List;

public interface TestService {
    List<CommonCodeOptions> getDefectCommonCodeOptions();
    TestPageResponseDto getTestList(Long prj_no, Long work_no, String test_type, String status, String search, int page);
    Long saveTest(Long memberNo, Long prjNo, TestMasterRequestDto testReq, String type);
    TestMasterRequestDto getTest(Long testNo);
    Long updateTest(TestMasterRequestDto testReq);
    void deleteTest(Long testNo);
    List<FeatureSimpleResponseDto> getFeatures(Long prjNo);
}
