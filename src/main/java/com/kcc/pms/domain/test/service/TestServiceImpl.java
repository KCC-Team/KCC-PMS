package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.test.domain.dto.TestInsertRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestVO;
import com.kcc.pms.domain.test.mapper.TestMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TestServiceImpl implements TestService {
    private final TestMapper testMapper;

    @Override
    public List<TestVO> getTestList(Integer prj_no, Integer sys_no, Integer work_no, String test_type, String status, int page) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("prj_no", prj_no);
        parameters.put("sys_no", sys_no);
        parameters.put("work_no", work_no);
        parameters.put("test_type", test_type);
        parameters.put("status", status);
        parameters.put("page", page);
        return testMapper.findAllByOptions(parameters);
    }

    @Override
    public void saveTest(TestInsertRequestDto testReq) {

    }
}
