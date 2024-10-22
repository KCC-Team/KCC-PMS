package com.kcc.pms.domain.output.service;

import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import com.kcc.pms.domain.output.mapper.OutputMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OutputServiceImpl implements OutputService {
    private final OutputMapper outputMapper;

    @Override
    public FileStructResponseDto showOutputList() {
        return outputMapper.showOutputList();
    }
}
