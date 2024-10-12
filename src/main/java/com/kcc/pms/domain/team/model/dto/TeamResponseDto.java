package com.kcc.pms.domain.team.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class TeamResponseDto implements Serializable {
    private Integer key; //fancytree는 key로 고유값 구별
    private String title; //fancytree는 title로 텍스트 표시
    private String teamDescription;
    private String parentTeamName;
    private Integer totalCount;
    private String systemName;
    private Integer parentId;
    private List<TeamResponseDto> children = new ArrayList<>();
}