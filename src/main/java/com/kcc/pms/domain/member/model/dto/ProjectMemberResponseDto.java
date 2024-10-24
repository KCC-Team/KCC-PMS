package com.kcc.pms.domain.member.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
//사용X
@Getter
@Setter
public class ProjectMemberResponseDto implements Serializable {
    private Long id;
    private String memberName;
    private String auth;
    private String groupName;
    private String position;
    private String preStartDate;
    private String preEndDate;
    private String startDate;
    private String endDate;
    private String tech;
    private String teamName;
    private Integer teamNo;
}
