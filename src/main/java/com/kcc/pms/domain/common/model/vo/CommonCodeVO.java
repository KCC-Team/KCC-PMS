package com.kcc.pms.domain.common.model.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class CommonCodeVO implements Serializable {
    private String cd_dtl_no;
    private String cd_dtl_nm;
    private Long order_no;
}
