package com.kcc.pms.domain.output.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static lombok.AccessLevel.PROTECTED;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class OutputFile {
    private FileItem fileItem;
    private String fileType;
    private String fileSize;
    private String registedDate;
    private String registedBy;

    @Getter
    @NoArgsConstructor(access = PROTECTED)
    @AllArgsConstructor
    public static class FileItem {
        private Long fileNo;
        private String fileTitle;
    }
}