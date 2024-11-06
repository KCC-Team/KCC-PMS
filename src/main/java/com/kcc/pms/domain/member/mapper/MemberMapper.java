package com.kcc.pms.domain.member.mapper;

import com.kcc.pms.domain.member.model.dto.*;
import com.kcc.pms.domain.member.model.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;
import java.util.List;

@Mapper
public interface MemberMapper {
    List<GroupResponseDto> getGroupList();
    List<GroupMembersResponseDto> getGroupMemberList(Long groupNo);
    List<MemberResponseDto> getProjectMemberList(Long projectNo);
    List<MemberResponseDto> getTeamMember(@Param("teamNo") Long teamNo);
    MemberResponseTCDto getMemberDetail(@Param("projectNo") Long projectNo, @Param("memberNo") Long memberNo);
    Integer memberAssignTeam(@Param("memberNo") Long memberNo, @Param("teamNo") Long teamNo, @Param("beforeTeamNo") Integer beforeTeamNo);
    Integer updateTaskMember(@Param("memberNo") Long memberNo, @Param("teamNo") Long teamNo, @Param("beforeTeamNo") Integer beforeTeamNo);
    int saveMember(MemberVO member);
    MemberVO findById(String username);
    void disableTaskMemberConstraint();
    void enableTaskMemberConstraint();
    Integer updateFeatureMember(@Param("memberNo") Long memberNo, @Param("teamNo") Long teamNo, @Param("beforeTeamNo") Integer beforeTeamNo);
    void disableFeatureMemberConstraint();
    void enableFeatureMemberConstraint();
    void bulkUpsertDate(@Param("type") String type, @Param("memberList") List<MemberStartFinishRequestDto> memberList);
    void updateMembers(@Param("members") List<MemberUpdateRequestDto> members);
}
