package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.test.domain.dto.TestListResponseDto;

import java.util.List;

public interface TestService {
    List<TestListResponseDto> getTestList(Integer systemId, String work_type, String test_type, int page);
}
