package com.kcc.pms.domain.member.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class GroupMembersResponseDto implements Serializable {
    private Long id;
    private String memberName;
    private String phoneNo;
    private String email;
    private String position;
    private String tech;
    private String groupName;
}
