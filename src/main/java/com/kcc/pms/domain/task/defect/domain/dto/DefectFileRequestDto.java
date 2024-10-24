package com.kcc.pms.domain.task.defect.domain.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

import static lombok.AccessLevel.*;

@Getter
@Setter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class DefectFileRequestDto {
    List<MultipartFile> disFiles;
    List<MultipartFile> workFiles;
    List<Long> deleteFiles;
}
