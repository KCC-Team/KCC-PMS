package com.kcc.pms.domain.project.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria {
    private int pageNum;
    private int amount; // 갯수 출력

    private String type;
    private String keyword;

    public Criteria() {
        this(1, 10);
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public String[] getTypeArr() {

        return type == null? new String[] {}: type.split("");
    }
}
