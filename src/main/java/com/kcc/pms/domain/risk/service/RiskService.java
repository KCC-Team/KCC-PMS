package com.kcc.pms.domain.risk.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.risk.model.dto.*;
import com.kcc.pms.domain.risk.model.excel.ExcelRiskDto;

import java.util.List;
import java.util.Optional;

public interface RiskService {
    List<CommonCodeOptions> getRiskCommonCode(String typeCode);
    Long saveRisk(RiskDto req, RiskFileRequestDto files, String memberName);
    Optional<FileMasterNumbers> getFileMasterNumbers(Long no);
    RiskDto getRiskByNo(Long riskNo);
    void updateRisk(RiskDto req, RiskFileRequestDto files, String memberName);
    List<RiskSummaryResponseDto> getRiskList(CriteriaRisk cri);
    int countRisks(CriteriaRisk cri);
    int createHistory(RiskHistoryDto req, RiskFileRequestDto files, Long prjNo);
    List<RiskHistoryDto> getHistories(Long riskNo);
    RiskHistoryDto getHistoryByNo(Long historyNo);
    int updateHistory(RiskHistoryDto req,
                      RiskFileRequestDto files, Long prjNo);
    int deleteHistory(Long historyNo);
    List<ExcelRiskDto> getRiskWithHistoriesAndFiles(Long prjNo, String typeCode);
}
