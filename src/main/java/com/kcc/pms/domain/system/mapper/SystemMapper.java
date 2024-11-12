package com.kcc.pms.domain.system.mapper;

import com.kcc.pms.domain.system.model.dto.SystemPageDto;
import com.kcc.pms.domain.system.model.dto.SystemResponseDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


import java.util.List;

@Mapper
public interface SystemMapper {
    List<SystemResponseDTO> getSystemsByProjectNo(Long projectNo);
    List<SystemPageDto> getParentSystems(@Param("startRow") int startRow,
                                         @Param("endRow") int endRow,
                                         @Param("prjNo") Long prjNo);
    String getSystemName(Long systemNo);
}
