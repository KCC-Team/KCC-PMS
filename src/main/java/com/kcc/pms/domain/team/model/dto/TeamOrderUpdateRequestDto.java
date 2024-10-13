package com.kcc.pms.domain.team.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TeamOrderUpdateRequestDto {
    private Integer teamNo;
    private Integer newParentNo;
    private Integer newPosition;
}
