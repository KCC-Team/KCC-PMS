package com.kcc.pms.domain.project.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ProjectResponseDto {

    private String mem_nm;

    private String project_status;

    private Long prj_no;

    private String prj_title;

    private String prj_cont;

    private String stat_cd;

    private Integer prg;

    private String org;

    private String pre_st_dt;

    private String pre_end_dt;

    private String st_dt;

    private String end_dt;

    private String use_yn;

    private String reg_id;

    private String reg_dt;

    private String mod_id;

    private String mod_dt;

    private List<ProjectManagerResponseDto> projectManager;

}
