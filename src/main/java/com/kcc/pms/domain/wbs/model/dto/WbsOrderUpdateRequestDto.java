package com.kcc.pms.domain.wbs.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WbsOrderUpdateRequestDto {
    private Integer wbsNo;
    private Integer newParentNo;
    private Integer newPosition;
}
