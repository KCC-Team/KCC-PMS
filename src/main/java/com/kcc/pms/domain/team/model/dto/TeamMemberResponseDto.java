package com.kcc.pms.domain.team.model.dto;

import com.kcc.pms.domain.team.model.vo.Team;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class TeamMemberResponseDto implements Serializable {
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
    private String email;
    private String phoneNo;
    List<Team> connectTeams = new ArrayList<>();
}
