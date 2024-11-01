package com.kcc.pms.domain.risk.mapper;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.risk.model.dto.RiskDto;
import com.kcc.pms.domain.risk.model.dto.RiskHistoryDto;
import com.kcc.pms.domain.risk.model.dto.RiskSummaryResponseDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
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
    List<RiskSummaryResponseDto> getRiskList(Map<String, Object> params);
    int countRisks(Map<String, Object> params);
    int createHistory(RiskHistoryDto req);
    List<RiskHistoryDto> getHistories(Long riskNo);
    RiskHistoryDto getHistoryByNo(Long historyNo);
    int updateHistory(RiskHistoryDto req);
}
