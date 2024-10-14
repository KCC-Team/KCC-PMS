package com.kcc.pms.domain.team.controller;

import com.kcc.pms.domain.team.model.dto.TeamOrderUpdateRequestDto;
import com.kcc.pms.domain.team.model.dto.TeamRequestDto;
import com.kcc.pms.domain.team.model.dto.TeamResponseDto;
import com.kcc.pms.domain.team.model.vo.Team;
import com.kcc.pms.domain.team.service.TeamService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class TeamController {
    private final TeamService teamService;

    @GetMapping("/teams")
    @ResponseBody
    public List<TeamResponseDto> getTeamList(@RequestParam("projectNo") Long projectNo) {
        return teamService.getTeamList(projectNo);
    }

    @PostMapping("/teams")
    @ResponseBody
    public Integer createTeam(@RequestBody TeamRequestDto teamRequestDto) {
        return teamService.createTeam(teamRequestDto);
    }


    @PostMapping("/teams/updateOrder")
    @ResponseBody
    public void updateOrder(@RequestBody TeamOrderUpdateRequestDto request){
        teamService.updateOrder(request.getTeamNo(), request.getNewParentNo(), request.getNewPosition() + 1);
    }

    @GetMapping("/teamsSelectOptions")
    @ResponseBody
    public List<Team> getTeamsByProjectNo(@RequestParam("projectNo") Long projectNo){
        return teamService.getTeamByProject(projectNo);
    }

}
