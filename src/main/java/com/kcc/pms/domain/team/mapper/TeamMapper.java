package com.kcc.pms.domain.team.mapper;

import com.kcc.pms.domain.team.model.dto.TeamMemberResponseDto;
import com.kcc.pms.domain.team.model.dto.TeamResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TeamMapper {
    List<TeamResponseDto> getTeamList(Long projectNo);
    List<TeamMemberResponseDto> getTeamMember(Long teamNo);
}
