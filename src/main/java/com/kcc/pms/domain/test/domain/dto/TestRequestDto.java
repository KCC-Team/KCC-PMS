package com.kcc.pms.domain.test.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static lombok.AccessLevel.PROTECTED;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class TestRequestDto {
    private Long testDetailNumber;
    private String testId;
    private String testStageContent;
}
