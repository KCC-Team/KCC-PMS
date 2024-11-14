package com.kcc.pms.domain.feature.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class FeatureTestResponseDto  implements Serializable {
    private Long testNo;
    private String testId;
}
