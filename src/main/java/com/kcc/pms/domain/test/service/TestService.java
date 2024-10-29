package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.test.domain.dto.TestPageResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestDto;

import java.util.List;

public interface TestService {
    List<CommonCodeOptions> getDefectCommonCodeOptions();
    TestPageResponseDto getTestList(Long prj_no, Long work_no, String test_type, String status, int page);
    void saveTest(TestRequestDto testReq);
    TestRequestDto getTestDetail(Long testNo);
    void updateTest(TestRequestDto testReq);
    void deleteTest(Long testNo);
}
