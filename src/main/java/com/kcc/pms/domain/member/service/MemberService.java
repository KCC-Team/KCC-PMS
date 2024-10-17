package com.kcc.pms.domain.member.service;

import com.kcc.pms.domain.member.model.dto.GroupMembersResponseDto;
import com.kcc.pms.domain.member.model.dto.GroupResponseDto;
import com.kcc.pms.domain.member.model.dto.MemberResponseDto;
import com.kcc.pms.domain.member.model.dto.ProjectMemberResponseDto;

import java.util.List;

public interface MemberService {
    List<GroupResponseDto> getGroupList();
    List<GroupMembersResponseDto> getGroupMembers(Long groupNo);
    List<MemberResponseDto> getProjectMemberList(Long projectNo);
    List<MemberResponseDto> getTeamMember(Long projectNo, Long teamNo);
    MemberResponseDto getMemberDetail(Long projectNo, Long memberNo);
    Integer memberAssignTeam(Long memberNo, Long teamNo, Integer beforeTeamNo);
}
