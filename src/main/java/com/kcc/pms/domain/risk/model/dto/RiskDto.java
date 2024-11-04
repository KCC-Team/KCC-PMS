package com.kcc.pms.domain.risk.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RiskDto {
    private Long riskNumber;
    private String riskTitle;
    private String classCode;
    private String riskId;
    private String priorCode;
    private String riskContent;
    private String riskPlan;
    private String dueDate;
    private String completeDate;
    private String statusCode;
    private Long systemNo;
    private Long memberNo;
    private String memberName;
    private Long prjNo;
    private String discoverFilesJson;
    private String workFilesJson;
    private String issueRiskType;
}
