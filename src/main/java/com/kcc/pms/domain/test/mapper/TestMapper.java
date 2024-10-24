package com.kcc.pms.domain.test.mapper;

import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TestMapper {
    List<TestDto> findAllByOptions(Map<String, Object> parameters);
    Integer saveTest(Map<String, Object> parameters);
    Integer saveUnitTestDetails(Map<String, Object> parameters);
    TestRequestDto getUnitTest(Long testNo);
    Integer updateTest(Map<String, Object> parameters);
    Integer deleteTest(Long testNo);
}
