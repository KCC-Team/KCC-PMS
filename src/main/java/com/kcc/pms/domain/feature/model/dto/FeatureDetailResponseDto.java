package com.kcc.pms.domain.feature.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

@Data
public class FeatureDetailResponseDto implements Serializable {
    private Long featNo;
    private String featId;
    private String featTitle;
    private String featDescription;
    private Date preStartDate;
    private Date preEndDate;
    private Date startDate;
    private Date endDate;
    private String statusCode;
    private String priorCode;
    private Integer progress;
    private String diffCode;
    private String classCode;
    private Long systemNo;
    private Long memberNo;
    private Long teamNo;
    private Long prjNo;
    private String systemTitle;
    private String memberName;
    private String status;
    private String priority;
    private String difficulty;
    private String className;

    private String preStartDateStr;
    private String preEndDateStr;
    private String startDateStr;
    private String endDateStr;
}