package com.kcc.pms.domain.wbs.service;

import com.kcc.pms.domain.wbs.model.dto.WbsRequestDto;
import com.kcc.pms.domain.wbs.model.dto.WbsResponseDto;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WbsService {
    int saveWbs(WbsRequestDto wbs);
    List<WbsResponseDto> getWbsList(Long prj_no, Long tsk_no);
    List<WbsResponseDto> getTopTaskList(Long prj_no, Long tsk_no);
    List<WbsResponseDto> getWbsOutputList(Long tsk_no);
    void updateOrder(Integer wbsNo, Integer newParentNo, Integer newPosition);
    int updateWbs(WbsRequestDto wbs);
    int deleteWbs(Long prj_no, Long tsk_no);
}
