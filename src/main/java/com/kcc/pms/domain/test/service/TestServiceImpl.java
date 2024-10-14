package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.test.domain.dto.TestListVO;
import com.kcc.pms.domain.test.mapper.TestMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TestServiceImpl implements TestService {
    private final TestMapper testMapper;

    @Override
    public List<TestListVO> getTestList(Long prj_no, Long systemId, String work_type, String test_type, int page) {
        Map<String, String> parameters = new HashMap<>();
        parameters.put("prj_no", prj_no.toString());
        parameters.put("systemId", systemId.toString());
        parameters.put("work_type", work_type);
        parameters.put("test_type", test_type);
        parameters.put("page", String.valueOf(page));
        return testMapper.findAllByOptions(parameters).orElseThrow();
    }
}
