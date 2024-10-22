package com.kcc.pms.domain.team.service;

import com.kcc.pms.domain.team.model.dto.MemberAddRequestDto;
import com.kcc.pms.domain.team.model.dto.TeamRequestDto;
import com.kcc.pms.domain.team.model.dto.TeamResponseDto;
import com.kcc.pms.domain.team.model.dto.TeamTreeResponseDto;
import com.kcc.pms.domain.team.model.vo.Team;

import java.util.List;

public interface TeamService {
    List<TeamResponseDto> getTeamList(Long projectNo);
    void updateOrder(Integer teamNo, Integer newParentNo, Integer newPosition);
    List<Team> getTeamByProject(Long projectNo);
    Integer createTeam(TeamRequestDto teamRequestDto);
    int addMemberTeam(Long teamNo, Long prjNo, List<MemberAddRequestDto> addMembers);
    List<TeamTreeResponseDto> getTeamTree(Long prjNo);
}
