package com.kcc.pms.domain.task.defect.domain.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DefectFileRequestDto {
    List<MultipartFile> dis_files;
    List<MultipartFile> work_files;
}
