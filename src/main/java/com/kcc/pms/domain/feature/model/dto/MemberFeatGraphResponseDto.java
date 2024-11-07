package com.kcc.pms.domain.feature.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

@Getter
@Setter
public class MemberFeatGraphResponseDto implements Serializable {
    private String category;
    private List<GraphParams> graph;
}
