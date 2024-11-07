package com.kcc.pms.domain.team.service;

import com.kcc.pms.domain.team.model.dto.*;
import com.kcc.pms.domain.team.model.vo.Team;

import java.sql.SQLException;
import java.util.List;

public interface TeamService {
    List<TeamResponseDto> getTeamList(Long projectNo);
    void updateOrder(Integer teamNo, Integer newParentNo, Integer newPosition);
    List<Team> getTeamByProject(Long projectNo);
    Integer createTeam(TeamRequestDto teamRequestDto);
    int addMemberTeam(Long teamNo, Long prjNo, List<MemberAddRequestDto> addMembers) throws SQLException;
    List<TeamTreeResponseDto> getTeamTree(Long prjNo);
    List<TeamMemberResponseDto> getTeamMembers(Long teamNo);
}
