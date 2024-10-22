package com.kcc.pms.domain.team.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class TeamTreeResponseDto implements Serializable, TreeNode<TeamTreeResponseDto> {
    private Integer id;
    private String text;
    private Integer parentId;
    private Integer orderNo;
    private List<TeamTreeResponseDto> children = new ArrayList<>();

    @Override
    public Integer getKey() {
        return this.id;
    }

    @Override
    public Integer getOrderNo() {
        return this.orderNo;
    }

    @Override
    public Integer getParentId() {
        return this.parentId;
    }

    @Override
    public List<TeamTreeResponseDto> getChildren() {
        return this.children;
    }
}

