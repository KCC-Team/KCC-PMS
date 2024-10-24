package com.kcc.pms.domain.feature.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class FeatureProgressResponseDto implements Serializable {
    private Double progress;
    private int total;
    private int complete;
    private int present;
    private int delay;
}
