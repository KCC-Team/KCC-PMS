package com.kcc.pms.domain.project.mapper;

import com.kcc.pms.domain.project.model.dto.Criteria;
import com.kcc.pms.domain.project.model.dto.ProjectManagerResponseDto;
import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProjectMapper {
    int saveProject(ProjectRequestDto project);
    int saveTeam(ProjectRequestDto team);
    int saveProjectMember(ProjectRequestDto projectMember);
    int updateProject(ProjectRequestDto project);
    int updateTeam(ProjectRequestDto project);
    List<ProjectResponseDto> getProjects(@Param("prjReqDto") ProjectRequestDto prjReqDto, @Param("cri") Criteria cri);
    int getProjectCount(@Param("prjReqDto") ProjectRequestDto prjReqDto);
    ProjectManagerResponseDto getProjectManager(@Param("prj_no") int prj_no);
    ProjectResponseDto findByProject(@Param("prj_no") int prj_no);
    List<ProjectResponseDto> getCommonProjectList(@Param("login_id") String login_id);
}
