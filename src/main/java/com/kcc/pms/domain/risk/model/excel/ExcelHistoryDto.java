package com.kcc.pms.domain.risk.model.excel;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@ToString
public class ExcelHistoryDto implements Serializable {
    private Long historyNo;
    private Date recordDt;
    private String recordCont;
    private String memNm;
    private List<ExcelFileDetailDto> historyFiles;
}
