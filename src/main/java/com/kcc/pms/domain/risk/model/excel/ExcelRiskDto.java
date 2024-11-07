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
public class ExcelRiskDto implements Serializable {
    private Long riskNo;
    private String riskId;
    private String rskTtl;
    private String typeCd;
    private String classCd;
    private String statCd;
    private String priCd;
    private String riskCont;
    private String riskPlan;
    private Date dueDt;
    private Date complDt;
    private Date registDt;
    private String sysTtl;
    private String memNm;
    private List<ExcelHistoryDto> histories;
    private List<ExcelFileDetailDto> findFiles;
}
