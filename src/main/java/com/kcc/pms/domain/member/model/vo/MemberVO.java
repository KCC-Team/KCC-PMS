package com.kcc.pms.domain.member.model.vo;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
public class MemberVO implements Serializable {
    private Long memNo;
    private Integer groupNumber;
    private String id;
    private String pw;
    private String memberName;
    private String phoneNumber;
    private String email;
    private String authCode;
    private String positionCode;
    private String birthDate;
    private String techGradeCode;
    private String organization;
    private String use;
    private Long recentProjectNumber;
}
