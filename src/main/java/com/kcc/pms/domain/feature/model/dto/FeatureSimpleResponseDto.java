package com.kcc.pms.domain.feature.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static lombok.AccessLevel.PROTECTED;

@Getter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class FeatureSimpleResponseDto {
    private Long featureNo;
    private String featureName;
}
