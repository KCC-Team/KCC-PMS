package com.kcc.pms.domain.output.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static lombok.AccessLevel.PROTECTED;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class OutputRequestDto {
    private Long projectNo;
    private String title;
    private String type;
    private String parentNo;

}

