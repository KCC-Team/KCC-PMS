package com.kcc.pms.domain.team.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class TeamResponseDto implements TreeNode<TeamResponseDto> {
    private Integer key; //fancytree는 key로 고유값 구별
    private String title; //fancytree는 title로 텍스트 표시
    private String teamDescription;
    private String parentTeamName;
    private Integer totalCount;
    private String systemName;
    private Integer parentId;
    private int orderNo;
    private List<TeamResponseDto> children = new ArrayList<>();

    @Override
    public Integer getKey() {
        return key;
    }

    @Override
    public Integer getParentId() {
        return parentId;
    }

    @Override
    public Integer getOrderNo() {
        return orderNo;
    }

    @Override
    public List<TeamResponseDto> getChildren(){
        return children;
    }
}
