package com.kcc.pms.domain.test.service;

import com.kcc.pms.domain.test.domain.dto.TestDetailRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestRequestDto;
import com.kcc.pms.domain.test.domain.dto.TestVO;
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

    @Override
    public List<TestVO> getTestList(Integer prj_no, Integer sys_no, Integer work_no, String test_type, String status, int page) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("prj_no", prj_no);
        parameters.put("sys_no", sys_no);
        parameters.put("work_no", work_no);
        parameters.put("test_type", test_type);
        parameters.put("status", status);
        parameters.put("page", page);
        List<TestVO> allByOptions = testMapper.findAllByOptions(parameters);
        return allByOptions;
    }

    @Transactional
    @Override
    public void saveTest(TestRequestDto testReq) {
        SqlSession session = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
        try {
            TestMapper mapper = session.getMapper(TestMapper.class);

            // 테스트 정보 저장 (테스트 헤더 정보)
            Map<String, Object> testReqMapWithoutTestCase = testReq.toMapWithoutTestCase();
            testReqMapWithoutTestCase.put("prj_no", 1);

            int isPass = mapper.saveTest(testReqMapWithoutTestCase);
            if (isPass == 0) {
                throw new RuntimeException("테스트 등록에 실패했습니다.");
            }

            // 테스트 케이스 리스트를 반복하면서 배치 처리
            for (TestDetailRequestDto detail : testReq.getTestCaseList()) {
                Map<String, Object> map = detail.toUnitMap();
                map.put("testNo", testReqMapWithoutTestCase.get("testNo"));

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
    public TestRequestDto getTestDetail(Integer testNo) {
        return testMapper.getUnitTest(testNo);
    }

    @Transactional
    @Override
    public void updateTest(TestRequestDto testReq) {

    }

    @Transactional
    @Override
    public void deleteTest(Integer testNo) {
        testMapper.deleteTest(testNo);
    }
}
