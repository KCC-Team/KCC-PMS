package com.kcc.pms.domain.team.service;

import com.kcc.pms.domain.team.mapper.TeamMapper;
import com.kcc.pms.domain.team.model.dto.TeamResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class TeamServiceImpl implements TeamService{
    private final TeamMapper mapper;

    @Override
    public List<TeamResponseDto> getTeamList(Long projectNo) {
        return buildTree(mapper.getTeamList(projectNo));
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
                TeamResponseDto parent = nodeMap.get(node.getParentId());
                // 부모가 존재할 경우 자식으로 추가하고 정렬
                if (parent != null) {
                    parent.getChildren().add(node);
                    parent.getChildren().sort(Comparator.comparing(TeamResponseDto::getOrderNo));
                }
            }
        }

        rootNodes.sort(Comparator.comparing(TeamResponseDto::getOrderNo));
        return rootNodes;
    }
}
