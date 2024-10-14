package com.kcc.pms.domain.test.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class TestListResponseDto {
    private String test_no;
    private String test_id;
    private String test_type;
    private String test_name;
    private String work_type;
    private LocalDate test_start_date;
    private LocalDate test_end_date;
    private Integer test_case_count;
    private Integer defect_count;
    private String test_status;
}
