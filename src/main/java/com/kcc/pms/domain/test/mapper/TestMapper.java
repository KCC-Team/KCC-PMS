package com.kcc.pms.domain.test.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureSimpleResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestDetailRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestDto;
import com.kcc.pms.domain.test.domain.dto.TestPageResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestMasterRequestDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TestMapper {
    List<CommonCodeOptions> getCommonCodeOptions();
    TestPageResponseDto findAllByOptions(Long projectNumber, Long workNumber, String testType, String status, String search, int page, int limit);
    int saveTest(Long memberNo, Long projectNo, TestMasterRequestDto testReq);
    int saveUnitTestDetails(TestDetailRequestDto testDetail);
    int saveIntegrationTestDetails(TestDetailRequestDto testDetail);
    int saveTestContent(TestDto test);

    TestMasterRequestDto getUnitTest(Long testNo);
    Integer updateTest(Map<String, Object> parameters);
    Integer deleteTest(Long testNo);
    List<FeatureSimpleResponseDto> getFeatures(Long projectNo);
}
