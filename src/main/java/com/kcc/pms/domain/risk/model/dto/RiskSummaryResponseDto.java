package com.kcc.pms.domain.risk.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;

@Getter
@Setter
@ToString
public class RiskSummaryResponseDto implements Serializable {
    private Long riskNo;
    private String riskTitle;
    private String findMember;
    private String className;
    private String status;
    private String priority;
    private String system;
    private Date dueDate;
    private Date completeDate;
    private String dueDateStr;
    private String completeDateStr;
}
