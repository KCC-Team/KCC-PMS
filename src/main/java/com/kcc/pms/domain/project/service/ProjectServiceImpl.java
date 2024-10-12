package com.kcc.pms.domain.project.service;

import com.kcc.pms.domain.project.mapper.ProjectMapper;
import com.kcc.pms.domain.project.model.dto.Criteria;
import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
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
    public List<ProjectResponseDto> getProjects(ProjectRequestDto prjReqDto, Criteria cri) {
        List<ProjectResponseDto> projects = projectMapper.getProjects(prjReqDto, cri);

        for (ProjectResponseDto project : projects) {
            String startDate = project.getSt_dt();
            String endDate = project.getEnd_dt();
            if (startDate != null && startDate.length() >= 10) {
                project.setSt_dt(startDate.substring(0, 10));
            }
            if (endDate != null && endDate.length() >= 10) {
                project.setEnd_dt(endDate.substring(0, 10));
            }
        }

        return projects;
    }

    @Override
    public int getProjectCount(ProjectRequestDto prjReqDto) {
        return projectMapper.getProjectCount(prjReqDto);
    }

}
