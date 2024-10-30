package com.kcc.pms.domain.test.domain.dto;

import lombok.*;

import java.io.Serializable;

import static lombok.AccessLevel.*;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class TestDto implements Serializable {
    private TestItem testItem;
    private String testType;
    private String testTitle;
    private String workTitle;
    private String testStartDate;
    private String testEndDate;
    private Integer detailCount;
    private Integer defectCount;
    private String testStatus;

    @Getter
    @NoArgsConstructor(access = PROTECTED)
    @AllArgsConstructor
    private static class TestItem implements Serializable {
        private Integer testNumber;
        private String testId;
    }
}
