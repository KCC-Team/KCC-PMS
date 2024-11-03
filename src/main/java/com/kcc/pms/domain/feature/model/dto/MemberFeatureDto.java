package com.kcc.pms.domain.feature.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class MemberFeatureDto implements Serializable {
    private Long featNo;
    private String featTitle;
    private String system;
    private String status;
    private Integer progress;
    private String preEndDate;
    private String preStartDate;
    private String startDate;
    private String endDate;
    private String priority;
    private String difficulty;
    private String className;
}
