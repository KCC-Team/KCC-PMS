package com.kcc.pms.domain.output.domain.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FileMasterVO {
    private Integer fl_ms_no;
    private String fl_cd;
    private String use_yn;

    public FileMasterVO(String fl_cd, String use_yn) {
        this.fl_cd = fl_cd;
        this.use_yn = use_yn;
    }
}
