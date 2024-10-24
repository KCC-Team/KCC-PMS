package com.kcc.pms.domain.member.service;

import com.kcc.pms.domain.member.mapper.MemberMapper;
import com.kcc.pms.domain.member.model.dto.GroupMembersResponseDto;
import com.kcc.pms.domain.member.model.dto.GroupResponseDto;
import com.kcc.pms.domain.member.model.dto.MemberResponseDto;


import com.kcc.pms.domain.member.model.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final MemberMapper mapper;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public List<GroupResponseDto> getGroupList() {
        return buildTree(mapper.getGroupList());
    }

    @Override
    public List<GroupMembersResponseDto> getGroupMembers(Long groupNo) {
        return mapper.getGroupMemberList(groupNo);
    }

    @Override
    public List<MemberResponseDto> getProjectMemberList(Long projectNo) {
        return mapper.getProjectMemberList(projectNo);
    }

    @Override
    public List<MemberResponseDto> getTeamMember(Long teamNo) {
        return mapper.getTeamMember(teamNo);
    }

    @Override
    public MemberResponseDto getMemberDetail(Long projectNo, Long memberNo) {
        return mapper.getMemberDetail(projectNo, memberNo);
    }

    @Override
    public Integer memberAssignTeam(Long memberNo, Long teamNo, Integer beforeTeamNo) {
        return mapper.memberAssignTeam(memberNo, teamNo, beforeTeamNo);
    }

    @Override
    public int saveMember(MemberVO member) {
        String rawPassword = member.getPw();
        String encryptedPassword = bCryptPasswordEncoder.encode(rawPassword);
        member.setPw(encryptedPassword);
        return mapper.saveMember(member);
    }

    public List<GroupResponseDto> buildTree(List<GroupResponseDto> nodeList) {
        Map<Integer, GroupResponseDto> nodeMap = new HashMap<>();
        System.out.println(nodeList.toString());
        for (GroupResponseDto node : nodeList) {
            nodeMap.put(node.getId(), node);
        }

        // 트리 구조로 변환
        List<GroupResponseDto> rootNodes = new ArrayList<>();
        for (GroupResponseDto node : nodeMap.values()) {
            if (node.getParentId() == null) {
                rootNodes.add(node);
            } else {
                GroupResponseDto parent = nodeMap.get(node.getParentId()); //부모 존재 시 부모 노드에 자기자신 추가
                if (parent != null) {
                    parent.getChildren().add(node);
                }
            }
        }

        return rootNodes;
    }
}
