package com.kcc.pms.domain.test.domain.dto;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TestRequestDto implements Serializable {
    private Long testNo;
    private String testTitle;
    private String testId;
    private LocalDate testStartDate;
    private LocalDate testEndDate;
    private String testType;
    private String testStatus;
    private String workType;
    private String testCont;        // 테스트 내용 memberName;
    private List<TestDetailRequestDto> testCaseList;

    public Map<String, Object> toMapWithoutTestCase() {
        Map<String, Object> map = new HashMap<>();
        map.put("testNo", testNo);
        map.put("testId", testId);
        map.put("testTitle", testTitle);
        map.put("testCont", testCont);
        map.put("testStatus", testStatus);
        map.put("testType", testType);
        map.put("testStartDate", testStartDate);
        map.put("testEndDate", testEndDate);
        map.put("workType", workType);
        return map;
    }
}
