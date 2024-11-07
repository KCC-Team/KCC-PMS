package com.kcc.pms.domain.test.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static lombok.AccessLevel.PROTECTED;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TestDetailRequestDto implements Serializable {
    private Long testDetailNumber;
    private String testDetailId;        // 테스트 케이스 ID
    private String preCondition;        // 사전 조건
    private String testDetailContent;   // 테스트 케이스 내용
    private String testProcedure;       // 수행절차
    private String workContent;         // 업무 처리 내용
    private List<TestRequestDto> tests; // 통합 테스트용
    private List<Long> featNumbers;
    private String testData;            // 테스트 데이터
    private String estimatedResult;     // 예상 결과
    private String writtenDate;         // 작성일
    private String writerNo;            // 작성자 번호
    private String writerName;          // 작성자 이름
    private String testDate;            // 테스트 일자
    private String result;              // 결과
    private Long parentDetailNo;        // 상위 테스트 케이스 번호
    private Long testNo;                // 테스트 번호
    private List<TestDefectDto> defectNos;    // 결함 번호
    private List<TestDetailRequestDto> testCaseDetails; // 테스트 케이스 상세
}
