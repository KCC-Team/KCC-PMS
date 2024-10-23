package com.kcc.pms.domain.wbs.mapper;

import com.kcc.pms.domain.project.model.dto.Criteria;
import com.kcc.pms.domain.project.model.dto.ProjectRequestDto;
import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import com.kcc.pms.domain.team.model.vo.Team;
import com.kcc.pms.domain.wbs.model.dto.WbsRequestDto;
import com.kcc.pms.domain.wbs.model.dto.WbsResponseDto;
import com.kcc.pms.domain.wbs.model.vo.Wbs;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WbsMapper {
    int saveWbs(WbsRequestDto wbs);
    int saveWbsMember(WbsRequestDto wbs);
    List<WbsResponseDto> getWbsList(@Param("prj_no") Long prj_no, @Param("tsk_no") Long tsk_no);
    List<WbsResponseDto> getTopTaskList(@Param("prj_no") Long prj_no, @Param("tsk_no") Long tsk_no);
    Integer getMaxOrderNo(Long parentNo);
    List<Wbs> getSiblings(Integer parentNo);
    Wbs getWbsByNo(Integer wbsNo);
    void updateWbsOrder(@Param("wbsNo") Integer wbsNo, @Param("parentNo") Integer parentNo, @Param("orderNo") Integer orderNo);
    int updateWbs(WbsRequestDto wbs);
    int deleteWbsMember(@Param("prj_no") Long prj_no, @Param("tsk_no") Long tsk_no);
    int deleteWbs(@Param("prj_no") Long prj_no, @Param("tsk_no") Long tsk_no);
}
