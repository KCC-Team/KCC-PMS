package com.kcc.pms.domain.risk.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RiskHistoryDto {
    private Long historyNo;
    private String recordDate;
    private String recordContent;
    private Long riskNo;
    private Long memberNo;
    private String memberName;
}
