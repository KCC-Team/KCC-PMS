package com.kcc.pms.domain.task.defect.mapper;

import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectResponseDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Mapper
public interface DefectMapper {
    int saveDefect(Long projectNumber, DefectDto defect,
                   @Param(value = "fileMasterFoundNumber") Long fileMasterFoundNumber, @Param(value = "fileMasterWorkNumber") Long fileMasterWorkNumber,
                   String priority, String status, String type);
    int deleteDefect(Long no);
    int updateDefect(Long no, DefectDto defect, String priority, String status, String type);
    Optional<DefectDto> getDefect(Long no);
    Optional<FileMasterNumbers> getFileMasterNumbers(Long no);
    List<DefectResponseDto> getDefectList(Long projectNumber, Long workNo, String status, String search, int page, int limit);
}
