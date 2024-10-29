package com.kcc.pms.domain.task.defect.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
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
    List<CommonCodeOptions> getDefectCommonCodeOptions();
    int saveDefect(Long projectNumber, DefectDto defect,
                   @Param(value = "fileMasterFoundNumber") Long fileMasterFoundNumber,
                   @Param(value = "fileMasterWorkNumber") Long fileMasterWorkNumber);
    int deleteDefect(Long no);
    int updateDefect(Long no, DefectDto defect);
    Optional<DefectDto> getDefect(Long no);
    Optional<FileMasterNumbers> getFileMasterNumbers(Long no);
    List<DefectResponseDto> getDefectList(Long projectNumber, Long workNo, String type, String status, String search, int page, int limit);
    int getDefectTotalCount(Long projectNumber, Long workNo, String status, String search);
    int updateFileMasterNumbers(Long no, Long fileMasterFoundNumber, Long fileMasterWorkNumber);
}
