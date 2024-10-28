package com.kcc.pms.domain.feature.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class FeatureCreateRequestDto {
    private Long featNo;
    private String featId;
    private String featTitle;
    private String featDescription;
    private String preStartDateStr;
    private String preEndDateStr;
    private String startDateStr;
    private String endDateStr;
    private String diffCode;
    private String classCode;
    private String statusCode;
    private String priorCode;
    private Long teamNo;
    private Long systemNo;
    private Long memberNo;
    private String memberName;
    private Long progress;
    private Long prjNo;
}
