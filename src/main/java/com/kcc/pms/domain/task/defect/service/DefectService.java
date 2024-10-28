package com.kcc.pms.domain.task.defect.service;

import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.member.model.vo.MemberVO;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectResponseDto;

import java.util.List;
import java.util.Optional;

public interface DefectService {
    Long saveDefect(Long prgNo, String memberName, DefectDto req, DefectFileRequestDto files, String priority, String status, String type);
    void deleteDefect(Long no);
    Optional<FileMasterNumbers> getFileMasterNumbers(Long no);
    DefectDto getDefect(Long no);
    void updateDefect(Long prgNo, String memberName, Long no, DefectDto req, DefectFileRequestDto files, String priority, String status, String type);
    List<DefectResponseDto> getDefectList(Long prgNo, Long workNo, String status, String search, int page);
}
