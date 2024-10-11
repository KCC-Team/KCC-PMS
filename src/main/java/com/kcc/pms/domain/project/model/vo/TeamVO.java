package com.kcc.pms.domain.project.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class TeamVO {
    private Long tm_no;

    private String tm_nm;

    private String tm_cont;

    private String use_yn;

    private Long par_tm_no;

    private Long prj_no;

    private Long sys_no;
}
