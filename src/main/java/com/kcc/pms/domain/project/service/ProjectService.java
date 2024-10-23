package com.kcc.pms.domain.project.service;

import com.kcc.pms.domain.project.model.dto.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProjectService {
    int saveProject(ProjectRequestDto project);
    int updateProject(ProjectRequestDto project);
    List<ProjectResponseDto> getProjects(ProjectRequestDto prjReqDto, Criteria cri);
    int getProjectCount(ProjectRequestDto prjReqDto);
    CombinedProjectResponseDto findByProject(Long prj_no);
    List<ProjectResponseDto> getCommonProjectList(String login_id);
    ProjectManagerResponseDto getAuthCode(Long prjNo, Long memNo);
}
