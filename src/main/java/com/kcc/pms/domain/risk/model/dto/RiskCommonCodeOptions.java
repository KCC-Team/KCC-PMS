package com.kcc.pms.domain.risk.model.dto;

import com.kcc.pms.domain.risk.model.vo.CommonCodeVO;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class RiskCommonCodeOptions {
    private String common_cd_no;
    List<CommonCodeVO> codes;
}
