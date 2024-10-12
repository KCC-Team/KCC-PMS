package com.kcc.pms.domain.project.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
public class PageDto {
    private int startPage;
    private int endPage;
    private boolean prev, next;

    private int total;
    private Criteria cri;

    public PageDto(Criteria cri, int total) {

        this.cri = cri;
        this.total = total;

        // 1. endPage 계산: 5개의 페이지 단위로 표시
        this.endPage = (int) (Math.ceil(cri.getPageNum() / 5.0)) * 5;

        // 2. startPage 계산
        this.startPage = this.endPage - 4;

        // 3. realEnd 계산: 실제 마지막 페이지 번호
        int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));

        // 4. 실제 endPage가 realEnd보다 큰 경우 조정
        if (realEnd <= this.endPage) {
            this.endPage = realEnd;
        }

        // 5. prev, next 계산
        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }
}
