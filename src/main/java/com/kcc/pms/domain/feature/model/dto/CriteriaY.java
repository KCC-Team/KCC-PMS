package com.kcc.pms.domain.feature.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CriteriaY {
    private int pageNum;
    private int amount;
    private int startRow;
    private int endRow;

    private String type;
    private String keyword;

    public CriteriaY() {
        this(1, 10);
    }

    public CriteriaY(int pageNum, int amount) {
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

    public String[] getTypeArr() {
        return type == null ? new String[] {} : type.split("");
    }
}
