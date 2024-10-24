package com.kcc.pms.domain.task.defect.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

import static lombok.AccessLevel.PROTECTED;

@Getter
@Setter
@NoArgsConstructor(access = PROTECTED)
@AllArgsConstructor
public class DefectResponseDto implements Serializable {
    private DefectItem defectItem;
    private String defectTitle;
    private String priority;
    private String status;
    private String discoverName;
    private String workName;
    private String discoverDate;
    private String scheduleWorkDate;
    private String workDate;

    @Getter
    @Setter
    @NoArgsConstructor(access = PROTECTED)
    @AllArgsConstructor
    private static class DefectItem implements Serializable {
        private Integer defectNumber;
        private String defectId;
    }
}
