package com.kcc.pms.domain.system.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class SystemPageDto implements Serializable {
    private Long systemNo;
    private String systemTitle;
}
