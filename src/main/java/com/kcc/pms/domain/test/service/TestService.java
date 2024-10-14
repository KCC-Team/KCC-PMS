package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.test.domain.dto.TestListVO;

import java.util.List;

public interface TestService {
    List<TestListVO> getTestList(Long prj_no, Long systemId, String work_type, String test_type, int page);
}
