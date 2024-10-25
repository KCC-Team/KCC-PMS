package com.kcc.pms.domain.output.mapper;

import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OutputMapper {
    List<FileStructResponseDto> findList(Long prjNo, String option);
}
