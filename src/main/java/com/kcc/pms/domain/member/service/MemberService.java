package com.kcc.pms.domain.member.service;

import com.kcc.pms.domain.member.model.dto.*;
import com.kcc.pms.domain.member.model.vo.MemberVO;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

public interface MemberService {
    List<GroupResponseDto> getGroupList();
    List<GroupMembersResponseDto> getGroupMembers(Long groupNo);
    List<MemberResponseDto> getProjectMemberList(Long projectNo);
    List<MemberResponseDto> getTeamMember(Long teamNo);
    MemberResponseTCDto getMemberDetail(Long projectNo, Long memberNo);
    Integer memberAssignTeam(Long teamNo, List<MemberTeamUpdateRequest> teamUpdateMembers);
    void updateOrInsertDate(String type, List<MemberStartFinishRequestDto> updateList) throws SQLException;
    void updateMembers(List<MemberUpdateRequestDto> members);
    int saveMember(MemberVO member);
}
