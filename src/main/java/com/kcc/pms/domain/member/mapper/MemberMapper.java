package com.kcc.pms.domain.member.mapper;

import com.kcc.pms.domain.member.model.dto.GroupMembersResponseDto;
import com.kcc.pms.domain.member.model.dto.GroupResponseDto;
import com.kcc.pms.domain.member.model.dto.MemberResponseDto;
import com.kcc.pms.domain.member.model.dto.ProjectMemberResponseDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MemberMapper {
    List<GroupResponseDto> getGroupList();
    List<GroupMembersResponseDto> getGroupMemberList(Long groupNo);
    List<ProjectMemberResponseDto> getProjectMemberList(Long projectNo);
    List<MemberResponseDto> getTeamMember(Long teamNo);
    MemberResponseDto getMemberDetail(Long memberNo);
    Integer memberAssignTeam(@Param("memberNo") Long memberNo, @Param("teamNo") Long teamNo, @Param("beforeTeamNo") Integer beforeTeamNo);
}
