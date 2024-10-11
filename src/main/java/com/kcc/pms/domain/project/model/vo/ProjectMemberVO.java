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
public class ProjectMemberVO {
    private Long mem_no;

    private Long tm_nm;

    private Long prj_no;

    private String prj_auth_cd;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pre_start_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date pre_end_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date start_dt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date end_dt;

    private String use_yn;
}
