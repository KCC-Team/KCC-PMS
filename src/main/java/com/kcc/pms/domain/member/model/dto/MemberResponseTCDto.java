package com.kcc.pms.domain.member.model.dto;

import com.kcc.pms.domain.team.model.vo.Team;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

@Getter
@Setter
@ToString
public class MemberResponseTCDto implements Serializable {
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
    private List<Team> connectTeam;

}
