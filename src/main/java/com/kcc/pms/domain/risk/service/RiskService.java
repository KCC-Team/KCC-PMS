package com.kcc.pms.domain.risk.service;

import com.kcc.pms.domain.common.model.dto.CommonCodeOptions;
import com.kcc.pms.domain.common.model.vo.FileMasterNumbers;
import com.kcc.pms.domain.risk.model.dto.*;

import java.util.List;
import java.util.Optional;

public interface RiskService {
    List<CommonCodeOptions> getRiskCommonCode();
    Long saveRisk(RiskDto req, RiskFileRequestDto files, String memberName);
    Optional<FileMasterNumbers> getFileMasterNumbers(Long no);
    RiskDto getRiskByNo(Long riskNo);
    void updateRisk(RiskDto req, RiskFileRequestDto files, String memberName);
    List<RiskSummaryResponseDto> getRiskList(CriteriaRisk cri);
    int countRisks(CriteriaRisk cri);
    int createHistory(RiskHistoryDto req);
    List<RiskHistoryDto> getHistories(Long riskNo);
}
