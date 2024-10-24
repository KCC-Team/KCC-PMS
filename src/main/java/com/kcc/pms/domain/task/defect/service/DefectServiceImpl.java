package com.kcc.pms.domain.task.defect.service;

import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectResponseDto;
import com.kcc.pms.domain.task.defect.mapper.DefectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DefectServiceImpl implements DefectService {
    private final DefectMapper defectMapper;
    private final CommonService commonService;

    private static final int LIMIT = 10;

    @Transactional
    @Override
    public Long saveDefect(Long projectNumber, DefectDto defect, DefectFileRequestDto files, String priority, String status) {
        Long[] numbers = generateFiles(projectNumber, files);
        int isPassed = defectMapper.saveDefect(projectNumber, defect, numbers[0], numbers[1], priority, status);
        if (isPassed != 1) {
            throw new RuntimeException("Defect 저장 중 오류가 발생했습니다.");
        }

        return defect.getDefectNumber();
    }

    @Transactional
    @Override
    public void updateDefect(Long prgNo, Long no, DefectDto defect, DefectFileRequestDto files, String priority, String status) {
        Optional<FileMasterNumbers> numbers = defectMapper.getFileMasterNumbers(no);
        if (numbers.isPresent()) {
            if (numbers.get().getFileMasterFoundNumber() != null && files.getDisFiles() != null) {
                commonService.generateFiles(prgNo, files.getDisFiles(), numbers.get().getFileMasterFoundNumber());
            }
            if (numbers.get().getFileMasterWorkNumber() != null && files.getWorkFiles() != null) {
                commonService.generateFiles(prgNo, files.getWorkFiles(), numbers.get().getFileMasterWorkNumber());
            }
        }

        Optional.ofNullable(files.getDeleteFiles())
                .ifPresent(deleteFiles -> deleteFiles.forEach(commonService::deleteFileDetails));
        int isPassed = defectMapper.updateDefect(no, defect, priority, status);
        if (isPassed != 1) {
            throw new RuntimeException("Defect 수정 중 오류가 발생했습니다.");
        }
    }

    @Override
    public List<DefectResponseDto> getDefectList(Long projectNumber, Long workNo, String status, String search, int page) {
        return defectMapper.getDefectList(projectNumber, workNo, status, search, page, LIMIT);
    }

    @Transactional
    @Override
    public void deleteDefect(Long no) {
        Optional<FileMasterNumbers> fileMasterNumbers = defectMapper.getFileMasterNumbers(no);
        fileMasterNumbers.ifPresent(commonService::deleteFiles);

        int isPassed = defectMapper.deleteDefect(no);
        if (isPassed != 1) {
            throw new RuntimeException("Defect 삭제 중 오류가 발생했습니다.");
        }
    }

    @Override
    public Optional<FileMasterNumbers> getFileMasterNumbers(Long no) {
        return defectMapper.getFileMasterNumbers(no);
    }

    @Override
    public DefectDto getDefect(Long no) {
        return defectMapper.getDefect(no).orElseThrow(() -> new RuntimeException("해당하는 Defect가 없습니다."));
    }

    private Long[] generateFiles(Long projectNumber, DefectFileRequestDto files) {
        Long[] numbers = new Long[2];

        if (files.getDisFiles() != null) {
            numbers[0] = commonService.fileUpload(files.getDisFiles(), projectNumber, null);
        }
        if (files.getWorkFiles() != null) {
            numbers[1] = commonService.fileUpload(files.getWorkFiles(), projectNumber, null);
        }

        return numbers;
    }
}
