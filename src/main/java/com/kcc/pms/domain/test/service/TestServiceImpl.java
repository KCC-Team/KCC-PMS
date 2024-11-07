package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.feature.model.dto.FeatureSimpleResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestDetailRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestMasterRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestPageResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
import com.kcc.pms.domain.test.mapper.TestMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.compress.utils.Lists;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TestServiceImpl implements TestService {
    private final TestMapper testMapper;

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
    public Long saveTest(Long memberNo, Long projectNo, TestMasterRequestDto testReq, String type) {
        if (Objects.equals(type, "n")) {
            testMapper.saveTest(memberNo, projectNo, testReq);

            for (TestDetailRequestDto testDetail : testReq.getTestCaseList()) {
                if ("PMS01201".equals(testReq.getTestType())) {
                    saveUnitTestDetails(testReq.getTestNumber(), testDetail);
                    testMapper.deleteFeatureTests(testDetail.getTestDetailNumber());
                    testMapper.saveFeatureTest(testDetail.getFeatNumbers().get(0), testDetail.getTestDetailNumber());
                } else if ("PMS01202".equals(testReq.getTestType())) {
                    testMapper.saveIntegrationTestDetails(testReq.getTestNumber(), testDetail.getTestDetailId(), testDetail);
                    saveIntegrationTestDetails(testReq.getTestNumber(), testDetail);
                }

            }
        } else {
            testMapper.saveTest(memberNo, projectNo, testReq);
        }

        return testReq.getTestNumber();
    }

    @Override
    public TestMasterRequestDto getTest(Long testNo) {
        String testType = testMapper.getTestType(testNo);
        if (Objects.equals(testType, "PMS01201")) {
            return testMapper.getTest(testNo).orElseThrow(() -> new IllegalArgumentException("해당 테스트가 존재하지 않습니다."));
        } else {
            TestMasterRequestDto testMasterRequestDto = testMapper.getIntegrationTest(testNo).orElseThrow(() -> new IllegalArgumentException("해당 테스트가 존재하지 않습니다."));

            List<TestDetailRequestDto> details = new ArrayList<>();
            int idx = -1;
            int detailIdx = -1;
            for (TestDetailRequestDto req : testMasterRequestDto.getTestCaseList()) {
                if (req.getPreCondition() != null) {
                    idx++;
                    req.setTests(new ArrayList<>());
                    req.setTestCaseDetails(new ArrayList<>());
                    details.add(req);
                } else if (req.getTestData() != null) {
                    details.get(idx).getTestCaseDetails().add(new TestDetailRequestDto());
                    detailIdx++;
                    details.get(idx).getTestCaseDetails().get(detailIdx).setTestDetailNumber(req.getTestDetailNumber());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setWorkContent(req.getWorkContent());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setTestData(req.getTestData());
                    if (!req.getFeatNumbers().isEmpty()) {
                        details.get(idx).getTestCaseDetails().get(detailIdx).setFeatNumbers(req.getFeatNumbers());
                    }
                    details.get(idx).getTestCaseDetails().get(detailIdx).setEstimatedResult(req.getEstimatedResult());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setWrittenDate(req.getWrittenDate());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setWriterNo(req.getWriterNo());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setWriterName(req.getWriterName());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setTestDate(req.getTestDate());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setResult(req.getResult());
                    details.get(idx).getTestCaseDetails().get(detailIdx).setDefectNos(req.getDefectNos());
                } else if (req.getTestDetailContent() != null) {
                    if (details.get(idx).getTestCaseDetails().get(detailIdx).getTests() == null) {
                        details.get(idx).getTestCaseDetails().get(detailIdx).setTests(new ArrayList<>());
                    }
                    details.get(idx).getTestCaseDetails().get(detailIdx).getTests().add(
                            new TestRequestDto(req.getTestDetailNumber(), req.getTestDetailId(), req.getTestDetailContent())
                    );
                }
            }
            testMasterRequestDto.setTestCaseList(details);
             return  testMasterRequestDto;
        }
    }

    @Transactional
    @Override
    public Long updateTest(TestMasterRequestDto testReq) {
        String testType = testMapper.getTestType(testReq.getTestNumber());
        testMapper.updateTest(testReq);

            for (TestDetailRequestDto testDetail : testReq.getTestCaseList()) {
                if (Objects.equals(testType, "PMS01201")) {
                    if (testDetail.getFeatNumbers() != null) {
                        testMapper.deleteFeatureTests(testDetail.getTestDetailNumber());
                        for (Long featNumber : testDetail.getFeatNumbers()) {
                            testMapper.saveFeatureTest(featNumber, testDetail.getTestDetailNumber());
                        }
                    }

                    if (testReq.getTestCaseList() != null) {
                        testMapper.updateTestDetail(testDetail);
                    } else {
                        testMapper.saveUnitTestDetails(testReq.getTestNumber(), testDetail);
                    }

                    if (testDetail.getTests() != null) {
                        for (TestRequestDto test : testDetail.getTests()) {
                            testMapper.updateTestStage(test);
                        }
                    }
                } else {
                    if (testDetail.getTestDetailNumber() == null) {
                        testMapper.saveIntegrationTestDetails(testReq.getTestNumber(), testDetail.getTestDetailId(), testDetail);
                    } else {
                        testMapper.updateIntegrationTestDetails(testReq.getTestNumber(), testDetail);
                    }
                    updateIntegrationTestDetails(testReq.getTestNumber(), testDetail);
                }
            }

        return testReq.getTestNumber();
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

    private void saveUnitTestDetails(Long testNo, TestDetailRequestDto testCase) {
        testMapper.saveUnitTestDetails(testNo, testCase);
    }

    private void saveIntegrationTestDetails(Long testNo, TestDetailRequestDto testCase) {
        for (TestDetailRequestDto testDetail : testCase.getTestCaseDetails()) {
            testMapper.saveTestDetails(testNo, testDetail, testCase.getTestDetailNumber());

            for (Long featNumber : testDetail.getFeatNumbers()) {
                testMapper.saveFeatureTest(featNumber, testDetail.getTestDetailNumber());
            }
            for (TestRequestDto test : testDetail.getTests()) {
                testMapper.saveTestStage(testDetail.getTestDetailNumber(), testNo, test);
            }
        }
    }

    private void updateIntegrationTestDetails(Long testNo, TestDetailRequestDto testCase) {
        for (TestDetailRequestDto testDetail : testCase.getTestCaseDetails()) {
            if (testDetail.getTestDetailNumber() != null) {
                testMapper.updateTestDetail(testDetail);
            } else {
                testMapper.saveTestDetails(testNo, testDetail, testCase.getTestDetailNumber());
            }

            testMapper.deleteFeatureTests(testDetail.getTestDetailNumber());
            for (Long featNumber : testDetail.getFeatNumbers()) {
                testMapper.saveFeatureTest(featNumber, testDetail.getTestDetailNumber());
            }

            testMapper.deleteTestStage(testDetail.getTestDetailNumber());
            for (TestRequestDto test : testDetail.getTests()) {
                testMapper.saveTestStage(testDetail.getTestDetailNumber(), testNo, test);
            }
        }
    }
}
