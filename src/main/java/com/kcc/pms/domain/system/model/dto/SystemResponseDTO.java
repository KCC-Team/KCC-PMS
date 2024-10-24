package com.kcc.pms.domain.system.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class SystemResponseDTO implements Serializable {
    private Integer systemNo;
    private String systemTitle;
    private String systemContent;
    private Integer projectNo;
    private Integer parentSystemNo;
    private List<SystemResponseDTO> subSystems = new ArrayList<>();
}
