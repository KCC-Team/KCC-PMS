package com.kcc.pms.domain.test.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TestMasterRequestDto implements Serializable {
    private Long testNumber;
    private String testId;
    private String testTitle;
    private String testContent;
    private String testStatus;
    private String testType;
    private Long workSystemNo;
    private LocalDate testStartDate;
    private LocalDate testEndDate;
    private List<TestDetailRequestDto> testCaseList;
}
