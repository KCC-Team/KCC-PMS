package com.kcc.pms.domain.team.service;

import com.kcc.pms.domain.member.model.dto.GroupResponseDto;
import com.kcc.pms.domain.team.mapper.TeamMapper;
import com.kcc.pms.domain.team.model.dto.TeamMemberResponseDto;
import com.kcc.pms.domain.team.model.dto.TeamResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class TeamServiceImpl implements TeamService{
    private final TeamMapper mapper;

    @Override
    public List<TeamResponseDto> getTeamList(Long projectNo) {
        return buildTree(mapper.getTeamList(projectNo));
    }

    @Override
    public List<TeamMemberResponseDto> getTeamMember(Long teamNo) {
        return mapper.getTeamMember(teamNo);
    }

    public List<TeamResponseDto> buildTree(List<TeamResponseDto> nodeList) {
        Map<Integer, TeamResponseDto> nodeMap = new HashMap<>();

        for (TeamResponseDto node : nodeList) {
            nodeMap.put(node.getKey(), node);
        }

        // 트리 구조로 변환
        List<TeamResponseDto> rootNodes = new ArrayList<>();
        for (TeamResponseDto node : nodeMap.values()) {
            if (node.getParentId() == null) {
                rootNodes.add(node);
            } else {
                TeamResponseDto parent = nodeMap.get(node.getParentId()); //부모 존재 시 부모 노드에 자기자신 추가
                if (parent != null) {
                    parent.getChildren().add(node);
                }
            }
        }

        return rootNodes;
    }
}
