package com.kcc.pms.domain.project.service;

import com.kcc.pms.domain.project.model.dto.*;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface ProjectService {
    int saveProject(ProjectRequestDto project);
    int updateProject(ProjectRequestDto project);
    List<ProjectResponseDto> getProjects(ProjectRequestDto prjReqDto, Criteria cri);
    int getProjectCount(ProjectRequestDto prjReqDto);
    CombinedProjectResponseDto findByProject(Long prj_no);
    List<ProjectResponseDto> getCommonProjectList(String login_id);
    ProjectManagerResponseDto getAuthCode(Long prjNo, Long memNo);
    int updateRecentProject(Long prjNo, Long memNo);
    RecentProjectDto getRecentProject(Long memNo);
    int updateProjectProgress(Long prjNo, Integer progress);
    Map<String, BigDecimal> getCountsByProject(Long prjNo);
    Map<String, BigDecimal> getCountsByDashboard(Long prjNo);
}
