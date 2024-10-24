package com.kcc.pms.domain.common.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class CommonCodeSelectListResponseDto implements Serializable {
    private String codeDetailNo;
    private String codeDetailName;
}
