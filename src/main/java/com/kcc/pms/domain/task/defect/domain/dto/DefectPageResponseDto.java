package com.kcc.pms.domain.task.defect.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

import static lombok.AccessLevel.PROTECTED;

@Getter
@Setter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class DefectPageResponseDto {
    private List<DefectResponseDto> defectList;
    private int totalPage;
    private int totalElements;
}
