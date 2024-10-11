package com.kcc.pms.domain.project.service;

import com.kcc.pms.domain.project.model.dto.ProjectDto;
import com.kcc.pms.domain.project.model.vo.ProjectMemberVO;
import com.kcc.pms.domain.project.model.vo.ProjectVO;
import com.kcc.pms.domain.project.model.vo.TeamVO;

public interface ProjectService {
    int saveProject(ProjectDto project);
    ProjectVO getProject();
}
