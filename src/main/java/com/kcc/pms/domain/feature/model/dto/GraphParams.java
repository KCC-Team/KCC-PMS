package com.kcc.pms.domain.feature.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class GraphParams implements Serializable {
    private String label;
    private int memberCount;
    private double avgCount;
}
