package com.kcc.pms.domain.output.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FileStructResponseDto {
    private Long id;
    private String text;
    private String type;
    private Long parentId;
    private Long projectNo;
    private List<FileStructResponseDto> children = new ArrayList<>();
}
