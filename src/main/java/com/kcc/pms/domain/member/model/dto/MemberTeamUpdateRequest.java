package com.kcc.pms.domain.member.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class MemberTeamUpdateRequest {
    private Long memberId;
    private Integer beforeTeamNo;

    public MemberTeamUpdateRequest(Long id, Integer beforeTeamNo) {
        this.memberId = id;
        this.beforeTeamNo = beforeTeamNo;
    }
}
