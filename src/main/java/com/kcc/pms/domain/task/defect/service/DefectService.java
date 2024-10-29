package com.kcc.pms.domain.task.defect.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectPageResponseDto;

import java.util.List;
import java.util.Optional;

public interface DefectService {
    List<CommonCodeOptions> getDefectCommonCodeOptions();
    Long saveDefect(Long prgNo, String memberName, DefectDto req, DefectFileRequestDto files);
    void deleteDefect(Long no);
    Optional<FileMasterNumbers> getFileMasterNumbers(Long no);
    DefectDto getDefect(Long no);
    void updateDefect(Long prgNo, String memberName, Long no, DefectDto req, DefectFileRequestDto files);
    DefectPageResponseDto getDefectList(Long prgNo, Long workNo, String type, String status, String search, int page);
}
