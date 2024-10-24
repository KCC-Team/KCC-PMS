package com.kcc.pms.domain.output.domain.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import static lombok.AccessLevel.*;

@Getter
@NoArgsConstructor(access = PROTECTED)
@Setter
public class FileMasterVO {
    private Long fileMasterNumber;
    private String fileCode;

    public FileMasterVO(String fileCode) {
        this.fileCode = fileCode;
    }
}
