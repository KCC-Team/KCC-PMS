package com.kcc.pms.domain.feature.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class FeatureSummaryResponseDto implements Serializable {
    private Long featureNo;
    private String featureId;
    private String featureTitle;
    private String status;
    private String memberName;
    private String system;
    private Integer progress;
    private String remainingDays;
}
