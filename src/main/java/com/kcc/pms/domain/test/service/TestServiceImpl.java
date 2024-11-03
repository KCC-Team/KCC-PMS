package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureSimpleResponseDto;
import com.kcc.pms.domain.test.domain.dto.*;
import com.kcc.pms.domain.test.mapper.TestMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TestServiceImpl implements TestService {
    private final TestMapper testMapper;
    private final SqlSessionFactory sqlSessionFactory;

    private final static int LIMIT = 15;

    @Override
    public List<CommonCodeOptions> getDefectCommonCodeOptions() {
        return testMapper.getCommonCodeOptions();
    }

    @Override
    public TestPageResponseDto getTestList(Long projectNumber, Long workNumber, String testType, String status, String search, int page) {
        TestPageResponseDto tests = testMapper.findAllByOptions(projectNumber, workNumber, testType, status, search, page, LIMIT);
        tests.setTotalPage((int) Math.ceil((double) tests.getTotalElements() / LIMIT));
        return tests;
    }

    @Transactional
    @Override
    public Long saveTest(Long memberNo, Long projectNo, TestMasterRequestDto testReq) {
        testMapper.saveTest(memberNo, projectNo, testReq);

        for (TestDetailRequestDto testDetail : testReq.getTestCaseList()) {
            if ("PMS01201".equals(testReq.getTestType())) {
                saveUnitTestCase(testReq.getTestNumber(), testDetail);
            } else if ("PMS01202".equals(testReq.getTestType())) {
                saveIntegrationTestCase(testReq.getTestNumber(), testDetail);
            }
        }

        return testReq.getTestNumber();
    }

    private void saveUnitTestCase(Long testNo, TestDetailRequestDto testCase) {
        testCase.setTestNumber(testNo);
        testMapper.saveUnitTestDetails(testCase);
    }

    private void saveIntegrationTestCase(Long testNo, TestDetailRequestDto testCase) {
        testCase.setTestNumber(testNo);
        testMapper.saveIntegrationTestDetails(testCase);

        for (TestDto test : testCase.getTests()) {
            testMapper.saveTestContent(test);
        }
    }

    @Override
    public TestMasterRequestDto getTestDetail(Long testNo) {
        return testMapper.getUnitTest(testNo);
    }

    @Transactional
    @Override
    public void updateTest(TestMasterRequestDto testReq) {

    }

    @Transactional
    @Override
    public void deleteTest(Long testNo) {
        testMapper.deleteTest(testNo);
    }

    @Override
    public List<FeatureSimpleResponseDto> getFeatures(Long projectNo) {
        return testMapper.getFeatures(projectNo);
    }
}
