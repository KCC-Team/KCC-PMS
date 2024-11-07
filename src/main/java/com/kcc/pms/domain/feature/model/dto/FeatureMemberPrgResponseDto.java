package com.kcc.pms.domain.feature.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class FeatureMemberPrgResponseDto implements Serializable {
    private Long memberNo;
    private String memberName;
    private String teamName;
    private int totalFeatureCount;
    private int inProgressCount;
    private int delayedCount;
    private int completedCount;
    private Double avgProgress;
}
