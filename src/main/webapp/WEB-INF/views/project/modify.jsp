<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<link rel="stylesheet" href="../../../resources/project/css/modify.css">

<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <div class="project-content">
            <div class="project-info">프로젝트 수정</div>
            <div class="project-back"><a href="#" onclick="history.back();"><i class="fa-solid fa-arrow-left"></i> back</a></div>
        </div>

        <form class="project-form" action="#" method="post">
            <!-- 프로젝트 명 -->
            <div class="form-group full-width">
                <label>프로젝트 명 <span class="required-icon">*</span></label>
                <input type="text" id="title" name="title" value="차세대 프로그램 구축">
            </div>

            <!-- 상태 -->
            <div class="form-row">
                <div class="form-group">
                    <label for="status">상태 <span class="required-icon">*</span></label>
                    <select id="status" name="status">
                        <option value="01">선택하세요.</option>
                        <option value="02" selected>진행중</option>
                        <option value="03">종료</option>
                    </select>
                </div>
            </div>

            <!-- 주관기관 -->
            <div class="form-group full-width">
                <label>주관기관 <span class="required-icon">*</span></label>
                <input type="text" id="organization" name="organization" value="병무청">
            </div>

            <!-- 프로젝트 예정 기간 -->
            <div class="form-group period-group">
                <label>프로젝트 예정 기간 <span class="required-icon">*</span></label>
                <div class="period-inputs">
                    <input type="date" id="pre_start_date" name="pre_start_date" value="2024-09-12">
                    <span>~</span>
                    <input type="date" id="pre_end_date" name="pre_end_date" value="2024-09-20">
                    <span class="pre_days">(8일)</span>
                </div>
            </div>

            <!-- 프로젝트 기간 -->
            <div class="form-group period-group">
                <label>프로젝트 기간</label>
                <div class="period-inputs">
                    <input type="date" id="start_date" name="start_date" value="2024-09-12">
                    <span>~</span>
                    <input type="date" id="end_date" name="end_date" value="2024-09-20">
                    <span class="days">(8일)</span>
                    <input type="checkbox" id="no_days_period" name="no_days_period">
                    <label class="no-period">기간없음</label>
                </div>
            </div>

            <!-- 프로젝트 관리자 -->
            <div class="form-group">
                <label>프로젝트 관리자(PM) <span class="required-icon">*</span></label>
                <div class="pm-input">
                    <input type="text" id="pm_id" name="pm_id" value="PMO01">
                    <button type="button" class="pm-search" onclick="#">찾기</button>
                </div>
            </div>

            <!-- 프로젝트 설명 -->
            <div class="form-group full-width">
                <label for="description">프로젝트 설명</label>
                <textarea id="description" name="description" maxlength="500">차세대 프로그램 구축 프로젝트입니다.</textarea>
            </div>

            <span class="desc-count">
                <span class="char-count">0</span> / 500
            </span>

            <div class="form-actions">
                <button type="submit" class="modify-btn">
                    <i class="fa-solid fa-check"></i>&nbsp; 저장
                </button>
                <button type="button" class="cancel-btn" onclick="history.back()">
                    <i class="fa-solid fa-arrow-right-to-bracket"></i>&nbsp; 취소
                </button>
            </div>
        </form>

    </div>
</main>

<script src="../../../resources/project/js/modify.js"></script>

<%@ include file="../footer.jsp" %>