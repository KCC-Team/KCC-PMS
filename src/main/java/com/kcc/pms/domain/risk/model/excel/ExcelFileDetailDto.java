package com.kcc.pms.domain.risk.model.excel;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

@Getter
@Setter
@ToString
public class ExcelFileDetailDto implements Serializable {
    private Long flNo;
    private String originalTtl;
    private String filePath;
    private String flType;
    private Long flSize;
}
