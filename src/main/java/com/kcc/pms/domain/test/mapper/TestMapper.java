package com.kcc.pms.domain.test.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureSimpleResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestDetailRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestMasterRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestPageResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface TestMapper {
    List<CommonCodeOptions> getCommonCodeOptions();
    TestPageResponseDto findAllByOptions(Long projectNumber, Long workNumber, String testType, String status, String search, int page, int limit);
    int saveTest(Long memberNo, Long projectNo, TestMasterRequestDto testReq);
    int saveFeatureTest(Long featureNo, Long testDetailNo);
    int deleteFeatureTests(Long testDetailNo);
    int saveUnitTestDetails(Long testNo, TestDetailRequestDto testDetail);
    int saveIntegrationTestDetails(Long testNo, String testDetailId, TestDetailRequestDto testDetail);
    int saveTestDetails(Long testNo, TestDetailRequestDto testDetail, Long parDetailNo);
    int saveTestStage(Long testDetailNo, Long testNo, @Param(value = "test") TestRequestDto test);

    String getTestType(Long testNo);
    Optional<TestMasterRequestDto> getTest(Long testNo);
    Optional<TestMasterRequestDto> getIntegrationTest(Long testNo);
    void deleteTestStage(Long testDetailNumber);

    int updateTest(TestMasterRequestDto testReq);
    int updateIntegrationTestDetails(Long testNo, TestDetailRequestDto testDetail);
    int updateTestDetail(TestDetailRequestDto testDetail);
    int updateTestStatus(@Param(value = "testNo") Long testNo, @Param(value = "statusSelect") String statusSelect);
    int updateStatus(Long testNo, String status);
    int updateTestStage(TestRequestDto test);
    Integer deleteTest(Long testNo);
    List<FeatureSimpleResponseDto> getFeatures(Long projectNo);
}
