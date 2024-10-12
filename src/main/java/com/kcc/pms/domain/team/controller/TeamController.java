package com.kcc.pms.domain.team.controller;

import com.kcc.pms.domain.team.model.dto.TeamMemberResponseDto;
import com.kcc.pms.domain.team.model.dto.TeamResponseDto;
import com.kcc.pms.domain.team.service.TeamService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @GetMapping("/members")
    @ResponseBody
    public List<TeamMemberResponseDto> getMemberList(@RequestParam("teamNo") Long teamNo) {
        return teamService.getTeamMember(teamNo);
    }
}
