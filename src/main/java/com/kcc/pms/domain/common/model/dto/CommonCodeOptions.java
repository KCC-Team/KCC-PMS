package com.kcc.pms.domain.common.model.dto;

import com.kcc.pms.domain.common.model.vo.CommonCodeVO;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

@Getter
@Setter
public class CommonCodeOptions implements Serializable {
    private String common_cd_no;
    List<CommonCodeVO> codes;
}
