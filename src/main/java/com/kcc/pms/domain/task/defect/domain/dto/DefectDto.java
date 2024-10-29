package com.kcc.pms.domain.task.defect.domain.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DefectDto {
    private Long defectNumber;
    private String defectTitle;
    private String defectId;
    private Long testNumber;
    private String testId;
    private Long systemNumber;
    private String defectContent;
    private Long foundMemberNo;
    private String foundMemberName;
    private String discoverDate;
    private String scheduleWorkDate;
    private Long workMemberNo;
    private String workMemberName;
    private String workDate;
    private String workContent;
    private String prioritySelect;
    private String statusSelect;
    private String typeSelect;
}
