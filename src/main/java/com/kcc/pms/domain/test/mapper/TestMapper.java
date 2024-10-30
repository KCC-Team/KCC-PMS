package com.kcc.pms.domain.test.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TestMapper {
    List<CommonCodeOptions> getCommonCodeOptions();
    List<TestDto> findAllByOptions(Long projectNumber, Long workNumber, String testType, String status, String search, int page, int limit);
    int getTestTotalCount(Long projectNumber, Long workNumber, String testType, String status, String search);
    Integer saveTest(Map<String, Object> parameters);
    Integer saveUnitTestDetails(Map<String, Object> parameters);
    TestRequestDto getUnitTest(Long testNo);
    Integer updateTest(Map<String, Object> parameters);
    Integer deleteTest(Long testNo);
}
