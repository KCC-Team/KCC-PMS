package com.kcc.pms.domain.test.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import static lombok.AccessLevel.PROTECTED;

@Getter
@Setter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class TestDefectDto {
    private Long defectNumber;
    private String defectId;
    private String defectStatusCode;
}
