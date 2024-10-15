package com.kcc.pms.domain.system.mapper;

import com.kcc.pms.domain.system.model.dto.SystemResponseDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SystemMapper {
    List<SystemResponseDTO> getSystemsByProjectNo(Long projectNo);
}
