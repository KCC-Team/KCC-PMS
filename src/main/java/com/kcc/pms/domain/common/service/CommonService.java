package com.kcc.pms.domain.common.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeSelectListResponseDto;
import com.kcc.pms.domain.common.model.dto.FileResponseDto;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.member.model.vo.MemberVO;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface CommonService {
    List<CommonCodeSelectListResponseDto> getCommonCodeSelectList(String commonCodeNo);
    Long fileUpload(List<MultipartFile> files, String memberName, Long projectNumber, String fileCode);
    Long fileUploadToOutput(List<MultipartFile> files, String memberName, Long projectNumber, Long fileMasterNumber);
    void generateFiles(Long projectNumber, String memberName, List<MultipartFile> files, Long fileMasterNumber);
    List<FileResponseDto> getFileList(Long fileMasterNumber);
    void deleteFiles(FileMasterNumbers numbers);
    void deleteFileDetails(String deleteName, Long fileMasterNumber);
    void deleteFile(Long fileMasterNumber);
    void deleteFileDetail(String deleteName, Long fileDetailNumber);
}
