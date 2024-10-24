package com.kcc.pms.domain.risk.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RiskMapper {
    List<CommonCodeOptions> getRiskCommonCode();
}
