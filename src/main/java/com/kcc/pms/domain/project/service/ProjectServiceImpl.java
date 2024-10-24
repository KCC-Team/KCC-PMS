package com.kcc.pms.domain.project.service;

import com.kcc.pms.domain.project.mapper.ProjectMapper;
import com.kcc.pms.domain.project.model.dto.*;
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
    public int updateProject(ProjectRequestDto project) {
        int resultProject = projectMapper.updateProject(project);
        if (resultProject > 0) {
            int resultTeam = projectMapper.updateTeam(project);
        }
        return resultProject;
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

    @Override
    public CombinedProjectResponseDto findByProject(Long prj_no) {
        ProjectManagerResponseDto projectManager = projectMapper.getProjectManager(prj_no);
        ProjectResponseDto project = projectMapper.findByProject(prj_no);

        project.setPre_st_dt(project.getPre_st_dt().substring(0, 10));
        project.setPre_end_dt(project.getPre_end_dt().substring(0, 10));

        if (project.getSt_dt() != null) {
            project.setSt_dt(project.getSt_dt().substring(0, 10));
        }
        if (project.getEnd_dt() != null) {
            project.setEnd_dt(project.getEnd_dt().substring(0, 10));
        }

        CombinedProjectResponseDto combinedProject = new CombinedProjectResponseDto();
        combinedProject.setProjectManager(projectManager);
        combinedProject.setProject(project);

        return combinedProject;
    }

    @Override
    public List<ProjectResponseDto> getCommonProjectList(String login_id) {
        return projectMapper.getCommonProjectList(login_id);
    }

    @Override
    public ProjectManagerResponseDto getAuthCode(Long prjNo, Long memNo) {
        return projectMapper.getAuthCode(prjNo, memNo);
    }

    @Override
    public int updateRecentProject(Long prjNo, Long memNo) {
        return projectMapper.updateRecentProject(prjNo, memNo);
    }

    @Override
    public RecentProjectDto getRecentProject(Long memNo) {
        return projectMapper.getRecentProject(memNo);
    }

    @Override
    public int updateProjectProgress(Long prjNo, Integer progress) {
        return projectMapper.updateProjectProgress(prjNo, progress);
    }

}
