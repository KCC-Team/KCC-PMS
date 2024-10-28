package com.kcc.pms.domain.output.domain.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static lombok.AccessLevel.*;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class OutputDownloadRequestDto {
    private String filePath;
    private String fileTitle;
}
