package com.kcc.pms.domain.risk.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.risk.mapper.RiskMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RiskServiceImpl implements RiskService {

    private final RiskMapper mapper;

    @Override
    public List<CommonCodeOptions> getRiskCommonCode() {
        return mapper.getRiskCommonCode();
    }
}
