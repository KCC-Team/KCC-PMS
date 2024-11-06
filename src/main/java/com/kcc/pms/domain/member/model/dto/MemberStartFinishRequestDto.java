package com.kcc.pms.domain.member.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberStartFinishRequestDto {
    private Long id;
    private String startDate;
    private String endDate;
}
