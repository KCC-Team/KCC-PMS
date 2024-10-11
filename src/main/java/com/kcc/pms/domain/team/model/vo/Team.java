package com.kcc.pms.domain.team.model.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class Team implements Serializable {
    private Long teamNo;
    private String teamName;
}
