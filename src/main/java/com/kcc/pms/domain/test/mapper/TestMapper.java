package com.kcc.pms.domain.test.mapper;

import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TestMapper {
    List<TestVO> findAllByOptions(Map<String, Object> parameters);
    Integer saveTest(Map<String, Object> parameters);
    Integer saveUnitTestDetails(Map<String, Object> parameters);
    TestRequestDto getUnitTest(Integer testNo);
    Integer updateTest(Map<String, Object> parameters);
    Integer deleteTest(Integer testNo);
    List<String> getTestStatus();
}
