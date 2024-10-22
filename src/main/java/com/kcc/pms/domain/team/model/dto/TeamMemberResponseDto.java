package com.kcc.pms.domain.team.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TeamMemberResponseDto {
    private Long id;
    private String memberName;
    private String auth;
    private String groupName;
    private String position;
    private String tech;
    private String email;
    private Long teamNo;
}
