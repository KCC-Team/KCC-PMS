package com.kcc.pms.domain.project.service;

import com.kcc.pms.domain.project.model.dto.Criteria;
import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;

import java.util.List;

public interface ProjectService {
    int saveProject(ProjectRequestDto project);
    List<ProjectResponseDto> getProjects(ProjectRequestDto prjReqDto, Criteria cri);
    int getProjectCount(ProjectRequestDto prjReqDto);
}
