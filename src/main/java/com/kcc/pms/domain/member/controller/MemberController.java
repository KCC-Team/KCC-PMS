package com.kcc.pms.domain.member.controller;

import com.kcc.pms.domain.member.model.dto.GroupMembersResponseDto;
import com.kcc.pms.domain.member.model.dto.GroupResponseDto;
import com.kcc.pms.domain.member.model.dto.ProjectMemberResponseDto;
import com.kcc.pms.domain.member.service.MemberService;
import com.kcc.pms.domain.member.model.dto.MemberResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

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

    @GetMapping("/members/team")
    @ResponseBody
    public List<MemberResponseDto> teamMembers(@RequestParam Long teamNo) {
        return memberService.getTeamMember(teamNo);
    }

    @GetMapping("/projectmembers")
    @ResponseBody
    public List<ProjectMemberResponseDto> projectMembers(@RequestParam Long projectNo) {
        return memberService.getProjectMemberList(projectNo);
    }

    @GetMapping("/members/detail")
    @ResponseBody
    public MemberResponseDto memberDetail(@RequestParam Long memberNo) {
        return memberService.getMemberDetail(memberNo);
    }
}
