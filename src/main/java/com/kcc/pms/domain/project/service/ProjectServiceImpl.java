package com.kcc.pms.domain.project.service;

import com.kcc.pms.domain.project.mapper.ProjectMapper;
import com.kcc.pms.domain.project.model.dto.ProjectDto;
import com.kcc.pms.domain.project.model.vo.ProjectMemberVO;
import com.kcc.pms.domain.project.model.vo.ProjectVO;
import com.kcc.pms.domain.project.model.vo.TeamVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ProjectServiceImpl implements ProjectService {

    private final ProjectMapper projectMapper;

    @Override
    public int saveProject(ProjectDto project) {
        if (projectMapper.saveProject(project) > 0) {
            if (projectMapper.saveTeam(project) > 0) {
                if (projectMapper.saveProjectMember(project) > 0) {
                    return 1;
                }
            }
        }
        return 0;
    }

    @Override
    public ProjectVO getProject() {
        return projectMapper.getProject();
    }
}
