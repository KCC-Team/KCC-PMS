package com.kcc.pms.domain.project.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CombinedProjectResponseDto {

    private ProjectManagerResponseDto projectManager;
    private ProjectResponseDto project;

}
