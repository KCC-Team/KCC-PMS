package com.kcc.pms.domain.risk.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
public class CriteriaRisk {
    private int pageNum;
    private int amount;
    private int startRow;
    private int endRow;
    private String keyword;
    private Long prjNo;
    private String typeCode;
    private Map<String, String> filters = new HashMap<>();

    public CriteriaRisk() {
        this(1, 15);
    }

    public CriteriaRisk(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
        calculateLimits();
    }

    private void calculateLimits() {
        this.startRow = (pageNum - 1) * amount + 1;
        this.endRow = pageNum * amount;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
        calculateLimits();
    }

    public void setAmount(int amount) {
        this.amount = amount;
        calculateLimits();
    }
}
