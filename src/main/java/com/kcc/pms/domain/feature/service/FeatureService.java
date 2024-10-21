package com.kcc.pms.domain.feature.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;

import java.util.List;

public interface FeatureService {
    List<CommonCodeOptions> getFeatureCommonCode();
}
