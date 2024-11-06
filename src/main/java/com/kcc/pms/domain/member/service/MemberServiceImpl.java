package com.kcc.pms.domain.member.service;

import com.kcc.pms.domain.member.mapper.MemberMapper;
import com.kcc.pms.domain.member.model.dto.*;


import com.kcc.pms.domain.member.model.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    public List<MemberResponseTCDto> getTeamMember(Long teamNo) {
        return mapper.getTeamMember(teamNo);
    }

    @Override
    public MemberResponseTCDto getMemberDetail(Long projectNo, Long memberNo) {
        return mapper.getMemberDetail(projectNo, memberNo);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Integer memberAssignTeam(Long memberNo, Long teamNo, Integer beforeTeamNo)  {
        mapper.disableTaskMemberConstraint();
        mapper.disableFeatureMemberConstraint();
        try {
            Integer result = mapper.memberAssignTeam(memberNo, teamNo, beforeTeamNo);
            mapper.updateTaskMember(memberNo, teamNo, beforeTeamNo);
            mapper.updateFeatureMember(memberNo, teamNo, beforeTeamNo);
            return result;
        } finally {
            mapper.enableTaskMemberConstraint();
            mapper.enableFeatureMemberConstraint();
        }
    }

    @Override
    public void updateOrInsertDate(String type, List<MemberStartFinishRequestDto> updateList){
        mapper.bulkUpsertDate(type, updateList);
    }

    @Override
    public void updateMembers(List<MemberUpdateRequestDto> members) {
        for (MemberUpdateRequestDto member : members) {
            if (member.getStartDate() != null) {
                member.setStartDate(member.getStartDate().replace(" 00:00:00", ""));
            }
            if (member.getEndDate() != null) {
                member.setEndDate(member.getEndDate().replace(" 00:00:00", ""));
            }
            if (member.getPreStartDate() != null) {
                member.setPreStartDate(member.getPreStartDate().replace(" 00:00:00", ""));
            }
            if (member.getPreEndDate() != null) {
                member.setPreEndDate(member.getPreEndDate().replace(" 00:00:00", ""));
            }
            switch (member.getAuth().trim()) {
                case "PM":
                    member.setAuth("PMS00201");
                    break;
                case "PL":
                    member.setAuth("PMS00202");
                    break;
                case "팀원":
                    member.setAuth("PMS00203");
                    break;
                case "사업관리자":
                    member.setAuth("PMS00204");
                    break;
                case "고객":
                    member.setAuth("PMS00205");
                    break;
            }
        }
        System.out.println("members = " + members);
        mapper.updateMembers(members);
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
