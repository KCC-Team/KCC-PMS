package com.kcc.pms.domain.risk.mapper;

import com.kcc.pms.domain.risk.model.dto.RiskCommonCodeOptions;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RiskMapper {
    List<RiskCommonCodeOptions> getRiskCommonCode();
}
