package com.kcc.pms.domain.member.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberUpdateRequestDto {
    private Long id;
    private String auth;
    private String startDate;
    private String endDate;
    private String preStartDate;
    private String preEndDate;
}
