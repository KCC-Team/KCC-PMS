package com.kcc.pms.domain.project.mapper;

import com.kcc.pms.domain.project.model.dto.ProjectDto;
import com.kcc.pms.domain.project.model.vo.ProjectMemberVO;
import com.kcc.pms.domain.project.model.vo.ProjectVO;
import com.kcc.pms.domain.project.model.vo.TeamVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProjectMapper {
    int saveProject(ProjectDto project);
    int saveTeam(ProjectDto team);
    int saveProjectMember(ProjectDto projectMember);
    ProjectVO getProject();
}
