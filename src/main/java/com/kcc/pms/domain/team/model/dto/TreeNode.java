package com.kcc.pms.domain.team.model.dto;

import java.util.List;

public interface TreeNode<T> {
    Integer getKey();
    Integer getParentId();
    Integer getOrderNo();
    List<T> getChildren();
}
