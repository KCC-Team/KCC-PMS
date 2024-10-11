package com.kcc.pms.domain.project.model.dto;

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
public class ProjectDto {

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
    private Date pm_pre_start_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pm_pre_end_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date st_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date end_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pm_start_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pm_end_dt;

    private String use_yn;

    private String reg_id;

    private Date reg_dt;

    private String mod_id;

    private Date mod_dt;

    private Long tm_no;

    private String tm_nm;

    private String tm_cont;

    private Long par_tm_no;

    private Long sys_no;

    private Long mem_no;

    private String prj_auth_cd;
}
