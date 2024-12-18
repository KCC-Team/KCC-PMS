package com.kcc.pms.domain.project.mapper;

import com.kcc.pms.domain.project.model.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Mapper
public interface ProjectMapper {
    int saveProject(ProjectRequestDto project);
    int saveTeam(ProjectRequestDto team);
    int saveProjectMember(ProjectRequestDto projectMember);
    int updateProject(ProjectRequestDto project);
    int updateTeam(ProjectRequestDto project);
    List<ProjectResponseDto> getProjects(@Param("prjReqDto") ProjectRequestDto prjReqDto, @Param("cri") Criteria cri);
    int getProjectCount(@Param("prjReqDto") ProjectRequestDto prjReqDto);
    ProjectManagerResponseDto getProjectManager(@Param("prj_no") Long prj_no);
    ProjectResponseDto findByProject(@Param("prj_no") Long prj_no);
    List<ProjectResponseDto> getCommonProjectList(@Param("login_id") String login_id);
    ProjectManagerResponseDto getAuthCode(@Param("prjNo") Long prjNo, @Param("memNo") Long memNo);
    int updateRecentProject(@Param("prjNo") Long prjNo, @Param("memNo") Long memNo);
    RecentProjectDto getRecentProject(Long memNo);
    int updateProjectProgress(@Param("prjNo") Long prjNo, @Param("progress") Integer progress);
    Map<String, BigDecimal> getCountsByProject(@Param("prjNo") Long prjNo);
    Map<String, BigDecimal> getCountsByDashboard(@Param("prjNo") Long prjNo);
}
