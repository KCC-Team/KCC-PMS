package com.kcc.pms.domain.project.model.dto;

import com.kcc.pms.domain.project.model.vo.ProjectVO;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class ProjectResponseDto {

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

    private String mem_no;

    private String mem_nm;

    private String project_status;

    private Long prjNo;

    private List<ProjectManagerResponseDto> projectManager;

}
