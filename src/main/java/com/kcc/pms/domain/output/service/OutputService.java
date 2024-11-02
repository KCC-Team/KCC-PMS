package com.kcc.pms.domain.output.service;

import com.kcc.pms.domain.output.domain.dto.DeleteOutputResponseDto;
import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import com.kcc.pms.domain.output.domain.dto.OutputResponseDto;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface OutputService {
    List<FileStructResponseDto> findList(Long projectNo, String option);
    void insertOutput(Long projectNo, String memberName, String title, List<FileStructResponseDto> res, List<MultipartFile> files);
    void insertOutputFiles(Long projectNo, String memberName, Long outputNo, List<MultipartFile> files);
    Long updateOutput(Long projectNo, List<FileStructResponseDto> res, String option, Long fileMasterNo);
    void updateOutputInfo(String title, Long outputNo);
    void deleteOutput(Long outputNo);
    OutputResponseDto findOutput(Long projectNo, Long outputNo);
    List<DeleteOutputResponseDto> findDeleteOutputs(Long outputNo);
    void deleteOutputFiles(String memberName, List<Long> deleteOutputs);
}
