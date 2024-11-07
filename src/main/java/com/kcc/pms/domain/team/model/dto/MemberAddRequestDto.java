package com.kcc.pms.domain.team.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

@Data
public class MemberAddRequestDto {
    private Long id;
    private String auth;
    private String pre_st_dt;
    private String pre_end_dt;
    private String st_dt;
    private String end_dt;
    private Integer beforeTeamNo;
    private String type;

    public void formatDates() {
        this.pre_st_dt = formatDate(this.pre_st_dt);
        this.pre_end_dt = formatDate(this.pre_end_dt);
        this.st_dt = formatDate(this.st_dt);
        this.end_dt = formatDate(this.end_dt);
    }

    private String formatDate(String dateStr) {
        if (dateStr != null && !dateStr.isEmpty()) {
            try {
                // 날짜 형식이 yyyy-MM-dd HH:mm:ss 일 경우
                if (dateStr.length() > 10) {
                    LocalDateTime dateTime = LocalDateTime.parse(dateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                    return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                } else {
                    // 날짜 형식이 yyyy-MM-dd 일 경우
                    LocalDate date = LocalDate.parse(dateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    return date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                }
            } catch (DateTimeParseException e) {
                e.printStackTrace();
            }
        }
        return null;  // 날짜가 null이거나 빈 문자열일 경우 그대로 null 반환
    }
}
