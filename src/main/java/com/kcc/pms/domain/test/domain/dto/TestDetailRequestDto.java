package com.kcc.pms.domain.test.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import static lombok.AccessLevel.PROTECTED;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class TestDetailRequestDto implements Serializable {
    private String featNumber;
    private String workProcessContent;  // 업무 처리 내용
    private String testDetailId;        // 테스트 케이스 ID
    private String testData;            // 테스트 데이터
    private String estimatedResult;     // 예상 결과
    private String testDetailContent;   // 테스트 케이스 내용
    private String progressContent;     // 수행절차
    private String preCondition;        // 사전 조건
    private String note;

    public Map<String, Object> toUnitMap() {
        Map<String, Object> map = new HashMap<>();
        map.put("featNumber", featNumber);
        map.put("workProcessContent", workProcessContent);
        map.put("testDetailId", testDetailId);
        map.put("testData", testData);
        map.put("estimatedRlt", estimatedResult);
        map.put("testDetailContent", testDetailContent);
        map.put("progressContent", progressContent);
        map.put("preCondition", preCondition);
        map.put("note", note);
        return map;
    }
}
