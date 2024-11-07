package com.kcc.pms.domain.output.mapper;

import com.kcc.pms.domain.output.domain.dto.DeleteOutputResponseDto;
import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import com.kcc.pms.domain.output.domain.dto.OutputResponseDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface OutputMapper {
    List<FileStructResponseDto> findList(Long prjNo, String option);
    int deleteOutput(Long outputNo);
    int insertOutput(@Param(value = "output") FileStructResponseDto output, Long fileMasterNo);
    int updateOutput(FileStructResponseDto output);
    int updateOutputInfo(String title, String note, Long outputNo);
    Optional<OutputResponseDto> findOutput(Long outputNo);
    List<DeleteOutputResponseDto> findDeleteOutputs(Long outputNo);
}
