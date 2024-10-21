package com.kcc.pms.domain.output.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class FileStructResponseDto {
    private String id;
    private String text;
    private String type;
    private List<FileStructResponseDto> children;
}
