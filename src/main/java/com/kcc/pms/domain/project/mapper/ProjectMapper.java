package com.kcc.pms.domain.project.mapper;

import com.kcc.pms.domain.project.model.dto.Criteria;
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
    List<ProjectResponseDto> getProjects(@Param("prjReqDto") ProjectRequestDto prjReqDto, @Param("cri") Criteria cri);
    int getProjectCount(@Param("prjReqDto") ProjectRequestDto prjReqDto);
}
