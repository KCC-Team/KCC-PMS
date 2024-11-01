package com.kcc.pms.domain.risk.model.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

import static lombok.AccessLevel.PROTECTED;

@Getter
@Setter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
@ToString
public class RiskFileRequestDto {
    List<MultipartFile> disFiles;
    List<MultipartFile> workFiles;
    List<MultipartFile> historyFiles;
    List<Long> deleteFiles;
}
