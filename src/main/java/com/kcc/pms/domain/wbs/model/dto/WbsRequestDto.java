package com.kcc.pms.domain.wbs.model.dto;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class WbsRequestDto {

    private Long tsk_no;

    private double order_no;

    private String tsk_ttl;

    private String tsk_stat_cd;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pre_st_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pre_end_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date st_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date end_dt;

    private String weight_val;

    private String prg;

    private String rel_out_nm;

    private String use_yn;

    private String par_task_no;

    private String ante_task_no;

    private Long prj_no;

    private Long sys_no;

    private String mem_no;

    private String tm_no;

    private Long memNo;

    private Long tmNo;

    private String reg_id;

    private Date reg_dt;

    private String mod_id;

    private Date mod_dt;
}
