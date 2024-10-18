package com.kcc.pms.domain.risk.service;

import com.kcc.pms.domain.risk.mapper.RiskMapper;
import com.kcc.pms.domain.risk.model.dto.RiskCommonCodeOptions;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RiskServiceImpl implements RiskService {

    private final RiskMapper mapper;

    @Override
    public List<RiskCommonCodeOptions> getRiskCommonCode() {
        return mapper.getRiskCommonCode();
    }
}
