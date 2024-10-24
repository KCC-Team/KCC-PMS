package com.kcc.pms.domain.team.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TeamRequestDto {
    private String teamName;
    private Integer parentNo;
    private Integer systemNo;
    private String teamContent;
    private Long projectNo;
}
