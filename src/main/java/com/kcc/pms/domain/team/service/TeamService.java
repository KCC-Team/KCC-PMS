package com.kcc.pms.domain.team.service;

import com.kcc.pms.domain.team.model.dto.TeamMemberResponseDto;
import com.kcc.pms.domain.team.model.dto.TeamResponseDto;

import java.util.List;

public interface TeamService {
    List<TeamResponseDto> getTeamList(Long projectNo);
    List<TeamMemberResponseDto> getTeamMember(Long teamNo);
}