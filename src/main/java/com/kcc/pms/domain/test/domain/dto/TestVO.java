package com.kcc.pms.domain.test.domain.dto;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDate;

import static lombok.AccessLevel.*;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class TestVO implements Serializable {
    private TestItem testItem;
    private String testType;
    private String testTitle;
    private String workTitle;
    private String testPeriod;
    private Integer testCaseCount;
    private Integer defectCount;
    private String testStatus;

    @Getter
    @NoArgsConstructor(access = PROTECTED)
    @AllArgsConstructor
    private static class TestItem implements Serializable {
        private Integer test_no;
        private String test_id;
    }
}