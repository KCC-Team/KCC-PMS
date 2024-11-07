package com.kcc.pms.domain.output.domain.dto;

import com.kcc.pms.domain.common.model.dto.FileItem;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import static lombok.AccessLevel.PROTECTED;

@Getter
@Setter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class OutputFile {
    private FileItem fileItem;
    private String fileType;
    private String fileSize;
    private String registedDate;
    private String registedBy;
}
