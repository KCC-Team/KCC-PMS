package com.kcc.pms.domain.member.controller;

import com.kcc.pms.domain.member.model.dto.GroupMembersResponseDto;
import com.kcc.pms.domain.member.model.dto.GroupResponseDto;
import com.kcc.pms.domain.member.model.dto.ProjectMemberResponseDto;
import com.kcc.pms.domain.member.service.MemberService;
import com.kcc.pms.domain.member.model.dto.MemberResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projects")
public class MemberController {

    private final MemberService memberService;

    @GetMapping("/members")
    public String members() {
        return "member/list";
    }

    @GetMapping("/addMember")
    public String addMember() {
        return "member/memberRegister";
    }

    @GetMapping("/addTeamMember")
    public String addTeamMember(){
        return "member/teamMemberRegister";
    }

    @GetMapping("/getGroupList")
    @ResponseBody
    public List<GroupResponseDto> groupList() {
        return memberService.getGroupList();
    }

    @GetMapping("/members/groups")
    @ResponseBody
    public List<GroupMembersResponseDto> groupMembers(@RequestParam Long groupNo) {
        return memberService.getGroupMembers(groupNo);
    }

    @GetMapping("/{projectNo}/members/team/{teamNo}")
    @ResponseBody
    public List<MemberResponseDto> teamMembers(@PathVariable("projectNo") Long projectNo, @PathVariable("teamNo") Long teamNo) {
        return memberService.getTeamMember(teamNo);
    }

    @GetMapping("/projectmembers")
    @ResponseBody
    public List<MemberResponseDto> projectMembers(@RequestParam Long projectNo) {
        return memberService.getProjectMemberList(projectNo);
    }

    @GetMapping("/{projectNo}/members/{memberNo}")
    @ResponseBody
    public ResponseEntity<MemberResponseDto> memberDetail(@PathVariable("projectNo") Long projectNo, @PathVariable("memberNo") Long memberNo) {
        System.out.println("MemberController.memberDetail");
        System.out.println("projectNo = " + projectNo);
        System.out.println("memberNo = " + memberNo);
        MemberResponseDto memberDetail = memberService.getMemberDetail(projectNo, memberNo);
        System.out.println("memberDetail = " + memberDetail);
        return ResponseEntity.ok(memberDetail);
    }

    @PatchMapping("/members/{memberNo}/team/{teamNo}")
    @ResponseBody
    public ResponseEntity<String> memberAssignTeam(@PathVariable Long memberNo, @PathVariable Long teamNo, @RequestBody Map<String, Object> payload) {
        Integer beforeTeamNo = (Integer) payload.get("beforeTeamNo");
        System.out.println("beforeTeamNo = " + beforeTeamNo);
        System.out.println("memberNo = " + memberNo);
        System.out.println("teamNo = " + teamNo);
        try{
            Integer result = memberService.memberAssignTeam(memberNo, teamNo, beforeTeamNo);
            if(result != null) {
                return ResponseEntity.ok("success assigning team");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail assigning team");
            }
        } catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error: " + e.getMessage());
        }
    }
}
