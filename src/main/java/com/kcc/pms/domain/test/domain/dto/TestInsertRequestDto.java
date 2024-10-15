package com.kcc.pms.domain.test.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDate;
import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TestInsertRequestDto {
    private String testTitle;
    private String testId;
    private LocalDate testStartDate;
    private LocalDate testEndDate;
    private String testType;
    private String testStatus;
    private String systemType;
    private String workType;
    private String testCont;
    private List<TestCaseInsertRequestDto> testCaseList;
}
