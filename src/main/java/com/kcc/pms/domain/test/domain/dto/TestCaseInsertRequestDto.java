package com.kcc.pms.domain.test.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import static lombok.AccessLevel.PROTECTED;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
@ToString
public class TestCaseInsertRequestDto {
    private String featId;
    private String testCaseId;
    private String preCondition;
    private String testCaseCont;
    private String preoceedCont;
    private String testData;
    private String estimatedResult;
}
