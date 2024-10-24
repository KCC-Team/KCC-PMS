package com.kcc.pms.domain.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class GroupResponseDto implements Serializable {
    private Integer id;
    private String text;
    private Integer parentId;
    private List<GroupResponseDto> children = new ArrayList<GroupResponseDto>();
}
