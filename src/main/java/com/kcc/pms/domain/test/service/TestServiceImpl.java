package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.test.domain.dto.TestListResponseDto;
import com.kcc.pms.domain.test.mapper.TestMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TestServiceImpl implements TestService {
    private final TestMapper testMapper;

    @Override
    public List<TestListResponseDto> getTestList(Integer systemId, String work_type, String test_type, int page) {
        return List.of();
    }
}
