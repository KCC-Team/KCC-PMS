package com.kcc.pms.domain.member.controller;

import com.kcc.pms.domain.member.model.dto.*;
import com.kcc.pms.domain.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
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
        List<MemberResponseDto> projectMemberList = memberService.getProjectMemberList(projectNo);
        System.out.println(projectMemberList);
        return memberService.getProjectMemberList(projectNo);
    }

    @GetMapping("/{projectNo}/members/{memberNo}")
    @ResponseBody
    public ResponseEntity<MemberResponseTCDto> memberDetail(@PathVariable("projectNo") Long projectNo, @PathVariable("memberNo") Long memberNo) {
        System.out.println("MemberController.memberDetail");
        System.out.println("projectNo = " + projectNo);
        System.out.println("memberNo = " + memberNo);
        MemberResponseTCDto memberDetail = memberService.getMemberDetail(projectNo, memberNo);
        System.out.println("memberDetail = " + memberDetail);
        return ResponseEntity.ok(memberDetail);
    }

    @PostMapping("/members/team/{teamNo}")
    @ResponseBody
    public ResponseEntity<String> memberAssignTeam(@PathVariable Long teamNo, @RequestBody List<MemberTeamUpdateRequest> members) {
        System.out.println("MemberController.memberAssignTeam");
        System.out.println("teamNo = " + teamNo);
        System.out.println("members = " + members);
        try {
            for (MemberTeamUpdateRequest member : members) {
                memberService.memberAssignTeam(member.getMemberId(), teamNo, member.getBeforeTeamNo());
            }
            return ResponseEntity.ok("팀 배정에 성공하였습니다.");
        } catch (DataIntegrityViolationException e) {
            System.err.println("무결성 제약 조건 위반: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.CONFLICT).body("해당 팀에 이미 배정된 인원이 있습니다.");
        } catch (Exception e) {
            System.err.println("예상치 못한 오류: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("팀 배정 중 예상치 못한 오류가 발생했습니다.");
        }
    }

    @PostMapping("/members/date")
    public ResponseEntity<?> updateOrInsertDate(@RequestParam String type,
                                                    @RequestBody List<MemberStartFinishRequestDto> memberList) {
        System.out.println("MemberController.updateOrInsertDate");
        System.out.println("memberList = " + memberList);
        System.out.println("type = " + type);
        try {
            memberService.updateOrInsertDate(type, memberList);
            return ResponseEntity.ok(type + " dates processed successfully");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(500).body("Error processing " + type + " dates: " + e.getMessage());
        }
    }

    @PostMapping("/members")
    public ResponseEntity<?> updateMembers(@RequestBody List<MemberUpdateRequestDto> members) {
        System.out.println("members = " + members);
        try {
            memberService.updateMembers(members);
            return ResponseEntity.ok("변경 사항이 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업데이트 중 오류 발생: " + e.getMessage());
        }
    }
}
