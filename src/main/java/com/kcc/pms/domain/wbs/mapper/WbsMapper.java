package com.kcc.pms.domain.wbs.mapper;

import com.kcc.pms.domain.project.model.dto.Criteria;
import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import com.kcc.pms.domain.wbs.model.dto.WbsRequestDto;
import com.kcc.pms.domain.wbs.model.dto.WbsResponseDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WbsMapper {
    int saveWbs(WbsRequestDto wbs);
    int saveWbsMember(WbsRequestDto wbs);
    List<WbsResponseDto> getWbsList(Long prj_no);
}
