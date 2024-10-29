package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.task.defect.domain.dto.DefectPageResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestDetailRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestPageResponseDto;
import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestDto;
import com.kcc.pms.domain.test.mapper.TestMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
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
    private final SqlSessionFactory sqlSessionFactory;

    private final static int LIMIT = 10;

    @Override
    public List<CommonCodeOptions> getDefectCommonCodeOptions() {
        return testMapper.getCommonCodeOptions();
    }

    @Override
    public TestPageResponseDto getTestList(Long projectNumber, Long workNumber, String testType, String status, int page) {

        List<TestDto> tests = testMapper.findAllByOptions(projectNumber, workNumber, testType, status, page, LIMIT);
        int testTotalCount = testMapper.getTestTotalCount(projectNumber, workNumber, testType, status);
        int totalPage = (int) Math.ceil((double) testTotalCount / LIMIT);

        return new TestPageResponseDto(tests, totalPage, testTotalCount);
    }

    @Transactional
    @Override
    public void saveTest(TestRequestDto testReq) {
        SqlSession session = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
        try {
            TestMapper mapper = session.getMapper(TestMapper.class);

            // 테스트 정보 저장 (테스트 헤더 정보)
            Map<String, Object> testReqMapWithoutTestCase = testReq.toMapWithoutTestCase();
            testReqMapWithoutTestCase.put("projectNumber", 1);

            int isPass = mapper.saveTest(testReqMapWithoutTestCase);
            if (isPass == 0) {
                throw new RuntimeException("테스트 등록에 실패했습니다.");
            }

            // 테스트 케이스 리스트를 반복하면서 배치 처리
            for (TestDetailRequestDto detail : testReq.getTestCaseList()) {
                Map<String, Object> map = detail.toUnitMap();
                map.put("testNumber", testReqMapWithoutTestCase.get("testNumber"));

                // 개별 테스트 케이스 삽입
                mapper.saveUnitTestDetails(map);
            }

            session.flushStatements(); // 배치 실행
            session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public TestRequestDto getTestDetail(Long testNo) {
        return testMapper.getUnitTest(testNo);
    }

    @Transactional
    @Override
    public void updateTest(TestRequestDto testReq) {

    }

    @Transactional
    @Override
    public void deleteTest(Long testNo) {
        testMapper.deleteTest(testNo);
    }
}
