package com.kcc.pms.domain.risk.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class PagedRiskResponse<T> {
    private List<T> items;
    private PageRiskDto pageInfo;

    public PagedRiskResponse(List<T> items, PageRiskDto pageInfo) {
        this.items = items;
        this.pageInfo = pageInfo;
    }
}
