package com.kcc.pms.domain.risk.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.risk.model.dto.RiskDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface RiskMapper {
    List<CommonCodeOptions> getRiskCommonCode();
    int saveRisk(RiskDto req,
                 @Param(value = "fileMasterFoundNumber") Long fileMasterFoundNumber,
                 @Param(value = "fileMasterWorkNumber") Long fileMasterWorkNumber);
    Optional<FileMasterNumbers> getFileMasterNumbers(Long riskNo);
    RiskDto getRiskByNo(Long riskNo);
    int updateRiskInfo(RiskDto req);
}
