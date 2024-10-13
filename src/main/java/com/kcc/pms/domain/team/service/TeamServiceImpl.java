package com.kcc.pms.domain.team.service;

import com.kcc.pms.domain.team.mapper.TeamMapper;
import com.kcc.pms.domain.team.model.dto.TeamResponseDto;
import com.kcc.pms.domain.team.model.vo.Team;
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

    @Override
    public void updateOrder(Integer teamNo, Integer newParentNo, Integer newPosition) {
        System.out.println("teamNo = " + teamNo);
        System.out.println("newParentNo = " + newParentNo);
        System.out.println("newPosition = " + newPosition);

        Team movedTeam = mapper.getTeamByNo(teamNo);
        Integer oldParentId = movedTeam.getParentNo();

        List<Team> oldSiblings = mapper.getSiblings(oldParentId);


        List<Team> newSiblings = mapper.getSiblings(newParentNo);

        //부모가 동일한 경우 (같은 부모 하위에서 순서만 변경된 경우)
        if (oldParentId.equals(newParentNo)) {
            for (Team sibling : oldSiblings) {
                if (!sibling.getTeamNo().equals(teamNo)) {
                    if (movedTeam.getOrderNo() < newPosition && sibling.getOrderNo() > movedTeam.getOrderNo() && sibling.getOrderNo() <= newPosition) {
                        sibling.setOrderNo(sibling.getOrderNo() - 1);  // 한 칸씩 당김
                        mapper.updateTeamOrder(sibling.getTeamNo(), null, sibling.getOrderNo());
                    } else if (movedTeam.getOrderNo() > newPosition && sibling.getOrderNo() < movedTeam.getOrderNo() && sibling.getOrderNo() >= newPosition) {
                        sibling.setOrderNo(sibling.getOrderNo() + 1);  // 한 칸씩 밀어냄
                        mapper.updateTeamOrder(sibling.getTeamNo(), null, sibling.getOrderNo());
                    }
                }
            }
        }
        //부모가 다른 경우 (부모가 변경된 경우)
        else {
            // 기존 부모의 형제들의 순서 변경
            for (Team sibling : oldSiblings) {
                if (sibling.getOrderNo() > movedTeam.getOrderNo()) {
                    sibling.setOrderNo(sibling.getOrderNo() - 1);
                    mapper.updateTeamOrder(sibling.getTeamNo(), null, sibling.getOrderNo());
                }
            }

            // 새로운 부모의 형제들의 순서 변경
            for (Team sibling : newSiblings) {
                if (sibling.getOrderNo() >= newPosition) {
                    sibling.setOrderNo(sibling.getOrderNo() + 1);
                    mapper.updateTeamOrder(sibling.getTeamNo(), null, sibling.getOrderNo());
                }
            }

            movedTeam.setParentNo(newParentNo);
        }

        movedTeam.setOrderNo(newPosition);

        mapper.updateTeamOrder(movedTeam.getTeamNo(), newParentNo, newPosition);
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
