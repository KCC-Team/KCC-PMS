package com.kcc.pms.domain.task.defect.domain.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DefectRequestDto {
    private String defect_ttl;
    private String defect_id;
    private String test_id;
    private String work_type;
    private String defect_cont;
    private String discover_nm;
    private String discover_dt;
    private String sche_work_dt;
    private String worker_nm;
    private String work_dt;
    private String work_cont;
    private String member_nm;
    private String order_select;
    private String status_select;
}
