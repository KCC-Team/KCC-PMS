package com.kcc.pms.domain.risk.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class RiskCeateRequestDto {
    private String riskTtl;         // 위험 제목
    private String classCd;         // 위험 분류 코드
    private String riskId;          // 위험 ID
    private String priCd;           // 우선순위 코드
    private String rickCont;        // 위험 내용
    private String riskPlan;        // 위험 완화 계획
    private String dueDt;           // 조치 희망일
    private String complDate;       // 조치 완료일
    private String statCd;          // 위험 상태 코드
    private String memNo;           // 발견자 번호
    private Long systemNo;          // 시스템번호

}
