package com.kcc.pms.domain.team.model.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

@Getter
@Setter
@ToString
public class Team implements Serializable {
    private Integer teamNo;
    private Integer parentNo;
    private String teamName;
    private int orderNo;
    private Integer systemNo;
    private String teamContent;
    private Long projectNo;
}
