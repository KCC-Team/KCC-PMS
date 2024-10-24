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
    private String preStartDate;
    private String preEndDate;
    private String startDate;
    private String endDate;
    private String diffCode;
    private String featClassCode;
    private String statusCode;
    private String priorCode;
    private Long teamNo;
    private Long systemNo;
    private Long memberNo;
    private String memberName;
    private Long progress;
    private Long prjNo;
}
