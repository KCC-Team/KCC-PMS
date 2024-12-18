package com.kcc.pms.domain.task.defect.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.task.defect.domain.dto.DefectDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectFileRequestDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectPageResponseDto;
import com.kcc.pms.domain.task.defect.domain.dto.DefectResponseDto;
import com.kcc.pms.domain.task.defect.mapper.DefectMapper;
import com.kcc.pms.domain.test.mapper.TestMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DefectServiceImpl implements DefectService {
    private final DefectMapper defectMapper;
    private final TestMapper testMapper;

    private final CommonService commonService;

    private static final int LIMIT = 15;

    @Override
    public List<CommonCodeOptions> getDefectCommonCodeOptions() {
        return defectMapper.getDefectCommonCodeOptions();
    }

    @Transactional
    @Override
    public Long saveDefect(Long projectNumber, String memberName, DefectDto defect, DefectFileRequestDto files) {
        Long[] numbers = generateFiles(projectNumber, memberName, files);
        if (numbers[0] == null && numbers[1] == null) {
            int isPassed = defectMapper.saveDefect(projectNumber, defect, null, null);
            if (isPassed != 1) {
                throw new RuntimeException("Defect 저장 중 오류가 발생했습니다.");
            }
        } else {
            int isPassed = defectMapper.saveDefect(projectNumber, defect, numbers[0], numbers[1]);
            if (isPassed != 1) {
                throw new RuntimeException("Defect 저장 중 오류가 발생했습니다.");
            }
        }

        return defect.getDefectNumber();
    }

    @Transactional
    @Override
    public void updateDefect(Long prgNo, String MemberName, Long no, DefectDto defect, DefectFileRequestDto files) {
        Optional<FileMasterNumbers> numbers = defectMapper.getFileMasterNumbers(no);
        if (numbers.isPresent()) {
            if (numbers.get().getFileMasterFoundNumber() != null && files.getDisFiles() != null) {
                commonService.generateFiles(prgNo, MemberName, files.getDisFiles(), numbers.get().getFileMasterFoundNumber());
            } else if (numbers.get().getFileMasterFoundNumber() == null && files.getDisFiles() != null) {
                Long Number = generateFile(prgNo, MemberName, files.getDisFiles());
                int isPassed = defectMapper.updateFileMasterNumbers(no, Number, null);
            }
            if (numbers.get().getFileMasterWorkNumber() != null && files.getWorkFiles() != null) {
                commonService.generateFiles(prgNo, MemberName, files.getWorkFiles(), numbers.get().getFileMasterWorkNumber());
            } else if (numbers.get().getFileMasterWorkNumber() == null && files.getWorkFiles() != null) {
                Long Number = generateFile(prgNo, MemberName, files.getWorkFiles());
                int isPassed = defectMapper.updateFileMasterNumbers(no, null, Number);
            }
        } else {
            Long[] filesMasterNos = generateFiles(prgNo, MemberName, files);
            if (!(filesMasterNos[0] == null && filesMasterNos[1] == null)) {
                int isPassed = defectMapper.updateFileMasterNumbers(no, filesMasterNos[0], filesMasterNos[1]);
                if (isPassed != 1) {
                    throw new RuntimeException("Defect 수정 중 오류가 발생했습니다.");
                }
            }
        }

        Optional.ofNullable(files.getDeleteFiles())
                .ifPresent(deleteFiles -> deleteFiles.forEach(file -> {
                    commonService.deleteFileDetail(MemberName, file);
                }));
        int isPassed = defectMapper.updateDefect(no, defect);
        testMapper.updateStatus(no, defect.getStatusSelect());
        if (isPassed != 1) {
            throw new RuntimeException("Defect 수정 중 오류가 발생했습니다.");
        }
    }

    @Override
    public DefectPageResponseDto getDefectList(Long projectNumber, Long workNo, String type, String status, String search, int page) {
        List<DefectResponseDto> defects = defectMapper.getDefectList(projectNumber, workNo, type, status, search, page, LIMIT);
        int defectListCount = defectMapper.getDefectTotalCount(projectNumber, workNo, status, search);
        int totalPage = (int) Math.ceil((double) defectListCount / LIMIT);

        return new DefectPageResponseDto(defects, totalPage, defectListCount);
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

    private Long[]  generateFiles(Long projectNumber, String memberName, DefectFileRequestDto files) {
        Long[] numbers = new Long[2];

        if (files.getDisFiles() != null) {
            numbers[0] = commonService.fileUpload(files.getDisFiles(), memberName, projectNumber, null);
        }
        if (files.getWorkFiles() != null) {
            numbers[1] = commonService.fileUpload(files.getWorkFiles(), memberName, projectNumber, null);
        }

        return numbers;
    }

    private Long generateFile(Long projectNumber, String memberName, List<MultipartFile> files) {
        return commonService.fileUpload(files, memberName, projectNumber, null);
    }
}
