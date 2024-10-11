package com.kcc.pms.domain.project.service;

import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import com.kcc.pms.domain.project.model.vo.ProjectVO;

import java.util.List;

public interface ProjectService {
    int saveProject(ProjectRequestDto project);
    List<ProjectResponseDto> getProjects(String loginId);
}
