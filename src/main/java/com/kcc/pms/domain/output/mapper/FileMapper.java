package com.kcc.pms.domain.output.mapper;

import com.kcc.pms.domain.common.model.dto.FileResponseDto;
import com.kcc.pms.domain.output.domain.vo.FileMasterVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface FileMapper {
    Integer saveFileMaster(FileMasterVO fileMasterVO);
    void saveFileDetails(String originalTitle, String fileType, Long fileSize, Long fileMasterNumber, String registerId, String filePath);
    List<String> findFilesDetails(Long fileMasterNumber);
    int deleteFileDetails(Long fileMasterNumber);
    List<FileResponseDto> getFileDetailsRes(Long fileMasterNumber);
}
