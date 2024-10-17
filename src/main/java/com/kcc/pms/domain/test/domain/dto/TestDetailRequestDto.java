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
    private String featNo;
    private String testDtlId;      // 테스트 케이스 ID
    private String preCondition;    // 사전 조건
    private String testCaseCont;    // 테스트 케이스 내용
    private String preoceedCont;    // 수행절차
    private String testData;        // 테스트 데이터
    private String estimatedResult; // 예상 결과
    private String note;

    public Map<String, Object> toUnitMap() {
        Map<String, Object> map = new HashMap<>();
        map.put("featNo", featNo);
        map.put("testDtlId", testDtlId);
        map.put("testData", testData);
        map.put("estimatedRlt", estimatedResult);
        map.put("testDetailCont", testCaseCont);
        map.put("preoceedCont", preoceedCont);
        map.put("preCond", preCondition);
        map.put("note", note);
        return map;
    }
}
