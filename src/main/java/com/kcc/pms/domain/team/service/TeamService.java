package com.kcc.pms.domain.team.service;

import com.kcc.pms.domain.team.model.dto.TeamResponseDto;

import java.util.List;

public interface TeamService {
    List<TeamResponseDto> getTeamList(Long projectNo);
    void updateOrder(Integer teamNo, Integer newParentNo, Integer newPosition);
}
