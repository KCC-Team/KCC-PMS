package com.kcc.pms.domain.project.service;

import com.kcc.pms.domain.project.mapper.ProjectMapper;
import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import com.kcc.pms.domain.project.model.vo.ProjectVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProjectServiceImpl implements ProjectService {

    private final ProjectMapper projectMapper;

    @Override
    public int saveProject(ProjectRequestDto project) {
        int resultProject = projectMapper.saveProject(project);
        int resultTeam = projectMapper.saveTeam(project);
        int resultProjectMember = projectMapper.saveProjectMember(project);

        return (resultProject > 0 && resultTeam > 0 && resultProjectMember > 0) ? 1 : 0;
    }

    @Override
    public List<ProjectResponseDto> getProjects(String loginId) {
        return projectMapper.getProjects(loginId);
    }

}
