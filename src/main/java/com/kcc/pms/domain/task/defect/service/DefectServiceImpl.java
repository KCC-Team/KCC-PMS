package com.kcc.pms.domain.task.defect.service;

import com.kcc.pms.domain.task.defect.mapper.DefectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DefectServiceImpl implements DefectService {
    private final DefectMapper defectMapper;



}
