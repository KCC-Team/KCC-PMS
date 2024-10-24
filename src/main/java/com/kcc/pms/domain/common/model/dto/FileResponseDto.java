package com.kcc.pms.domain.common.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.Serializable;

import static lombok.AccessLevel.PROTECTED;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class FileResponseDto implements Serializable {
    private Long fileNumber;
    private String filePath;
    private String fileName;
    private String fileSize;
}
