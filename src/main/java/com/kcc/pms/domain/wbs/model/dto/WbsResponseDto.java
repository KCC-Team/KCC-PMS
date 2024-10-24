package com.kcc.pms.domain.wbs.model.dto;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class WbsResponseDto {

    private Long tsk_no;

    private double order_no;

    private String tsk_ttl;

    private String tsk_stat_cd;

    private String pre_st_dt;

    private String pre_end_dt;

    private String st_dt;

    private String end_dt;

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

    private String members;

    private String mem_nms;

    private String tm_numbers;

    private String mem_numbers;

    private String wbs_status;
}
