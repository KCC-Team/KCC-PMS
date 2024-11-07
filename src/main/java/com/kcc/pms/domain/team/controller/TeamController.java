package com.kcc.pms.domain.team.controller;

import com.amazonaws.Response;
import com.kcc.pms.domain.team.model.dto.*;
import com.kcc.pms.domain.team.model.vo.Team;
import com.kcc.pms.domain.team.service.TeamService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    @PostMapping("/team/{teamNo}/members")
    @ResponseBody
    public ResponseEntity<String> addMemberTeam(@PathVariable("teamNo") Long teamNo, HttpSession session,
                              @RequestBody List<MemberAddRequestDto> addMembers){
        Long prjNo = (Long) session.getAttribute("prjNo");

        for (MemberAddRequestDto addMember : addMembers) {
            System.out.println("addMember = " + addMember);
        }
        try {
            int insertedCount = teamService.addMemberTeam(teamNo, prjNo, addMembers);
            if (insertedCount > 0) {
                return ResponseEntity.ok("팀원 등록이 성공적으로 완료되었습니다." + insertedCount);
            } else {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body("등록된 팀원이 없습니다.");
            }
        } catch (Exception e) {
            System.out.println("!!!!!");
            System.out.println(e.getMessage());
            // 예외 발생 시, 상태 코드 500과 함께 에러 메시지 반환
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("팀원 등록 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    @GetMapping("/team/{teamNo}/members")
    @ResponseBody
    public ResponseEntity<List<TeamMemberResponseDto>> getTeamMembers(@PathVariable("teamNo") Long teamNo){
        return ResponseEntity.ok().body(teamService.getTeamMembers(teamNo));
    }

    @GetMapping("/teams/tree")
    @ResponseBody
    public ResponseEntity<List<TeamTreeResponseDto>> getTeamTree(HttpSession session){
        Long prjNo = (Long) session.getAttribute("prjNo");
        return ResponseEntity.ok(teamService.getTeamTree(prjNo));
    }

}
