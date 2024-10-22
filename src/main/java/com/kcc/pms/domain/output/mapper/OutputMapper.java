package com.kcc.pms.domain.output.mapper;

import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OutputMapper {
    FileStructResponseDto showOutputList();
}
