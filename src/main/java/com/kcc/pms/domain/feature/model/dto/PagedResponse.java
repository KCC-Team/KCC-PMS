package com.kcc.pms.domain.feature.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class PagedResponse<T> {
    private List<T> items;
    private PageYDto pageInfo;

    public PagedResponse(List<T> items, PageYDto pageInfo) {
        this.items = items;
        this.pageInfo = pageInfo;
    }
}
