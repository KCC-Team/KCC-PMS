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
public class ProjectVO {
    private Long prj_no;

    private String prj_title;

    private String prj_cont;

    private String stat_cd;

    private Integer prg;

    private String org;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pre_st_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pre_end_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date st_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date end_dt;

    private String use_yn;

    private String reg_id;

    private Date reg_dt;

    private String mod_id;

    private Date mod_dt;
}
