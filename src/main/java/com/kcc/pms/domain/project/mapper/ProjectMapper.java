package com.kcc.pms.domain.project.mapper;

import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import com.kcc.pms.domain.project.model.vo.ProjectVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ProjectMapper {
    int saveProject(ProjectRequestDto project);
    int saveTeam(ProjectRequestDto team);
    int saveProjectMember(ProjectRequestDto projectMember);
    List<ProjectResponseDto> getProjects(String loginId);
}
