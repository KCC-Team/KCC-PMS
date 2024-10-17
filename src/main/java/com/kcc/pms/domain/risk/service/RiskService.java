package com.kcc.pms.domain.risk.service;

import com.kcc.pms.domain.risk.model.dto.RiskCommonCodeOptions;

import java.util.List;

public interface RiskService {
    List<RiskCommonCodeOptions> getRiskCommonCode();
}
