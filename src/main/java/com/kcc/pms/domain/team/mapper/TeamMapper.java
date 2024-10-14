package com.kcc.pms.domain.team.mapper;

import com.kcc.pms.domain.team.model.dto.TeamResponseDto;
import com.kcc.pms.domain.team.model.vo.Team;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TeamMapper {
    List<TeamResponseDto> getTeamList(Long projectNo);
    Team getTeamByNo(Integer teamNo);
    List<Team> getSiblings(Integer parentNo);
    void updateTeamOrder(@Param("teamNo") Integer teamNo, @Param("parentNo") Integer parentNo, @Param("orderNo") Integer orderNo);
    List<Team> getTeamByProject(Long projectNo);
    Integer getMaxOrderNo(Long parentNo);
    Integer createTeam(Team team);
}
