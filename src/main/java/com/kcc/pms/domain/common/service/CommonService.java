package com.kcc.pms.domain.common.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeSelectListResponseDto;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface CommonService {
    List<CommonCodeSelectListResponseDto> getCommonCodeSelectList(String commonCodeNo);
    Long fileUpload(List<MultipartFile> files, Long prjNo, String fl_cd);
}
