package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestVO;

import java.util.List;

public interface TestService {
    List<TestVO> getTestList(Integer prj_no, Integer sys_no, Integer work_no, String test_type, String status, int page);
    void saveTest(TestRequestDto testReq);
    TestRequestDto getTestDetail(Integer testNo);
    void updateTest(TestRequestDto testReq);
    void deleteTest(Integer testNo);
}
