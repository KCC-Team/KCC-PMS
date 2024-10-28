package com.kcc.pms.domain.output.domain.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class DeleteOutputResponseDto {
    private Long fileDetailNo;
    private String fileName;
    private String filePath;
    private String fileSize;
    private String fileType;
    private String deleteName;
    private String deletedDate;
}
