package com.kcc.pms.domain.output.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

import static lombok.AccessLevel.PROTECTED;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class OutputResponseDto {
    private String title;
    private List<TaskOutput> tasks;
    private List<OutputFile> files;
}
