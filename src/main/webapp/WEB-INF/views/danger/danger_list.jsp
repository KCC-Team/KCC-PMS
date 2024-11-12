<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>
<link rel="stylesheet" href="../../../resources/danger/css/danger.css">
<link rel="stylesheet" href="../../../resources/common/css/ax5grid.css">

<main class="content" id="content">
    <div class="main_content">
        <div class="danger-content">
            <div class="danger-info">위험현황</div>
            <div class="action-buttons">
                <a href="/projects/dangerInfo?type=register">
                    <button class="add-project">+ 위험등록</button>
                </a>
                <a href="#">
                    <button class="danger-export-excel"><i class="fa-solid fa-download"></i> 액셀받기</button>
                </a>
            </div>
        </div>

        <div class="filter-section">
            <form action="#" method="post" class="search_form">
                <input type="hidden" name="systemNo" id="systemNo">
                시스템 분류&nbsp;&nbsp;
                <div class="system-select-wrapper">
                    <span class="system-select-button" id="system-select">
                        <span>시스템/업무 선택</span>
                    </span>
                    <!-- 메뉴 리스트 -->
                    <ul class="mymenu" id="system-menu"></ul>
                </div>
                위험분류
                <select id="PMS005" name="classCode" required>
                    <option value="">전체분류</option>
                </select>

                상태
                <select id="PMS004" name="statusCode" required>
                    <option value="">전체분류</option>
                </select>

                우선순위
                <select id="PMS006" name="priorCode" required>
                    <option value="">전체분류</option>
                </select>

                <span class="search-area">
                    <input id="riskSearchName" type="text" name="title" class="search-text" placeholder="위험명을 검색하세요">
                    <button id="riskSearchBtn" type="submit" class="search" value="">검색</button>
                </span>
            </form>
        </div>

        <div style="position: relative;height:100%; width: 94%;" id="grid-parent">
            <!-- 위험 목록 테이블 -->
            <div class="list_table" data-ax5grid="first-grid"  data-ax5grid-config="{
                header: {
                    columnHeight: 34
                },
                body: {
                    columnHeight: 34
                }
            }" style="height: 570px; width: 100%">
            </div>
        </div>
    </div>
</main>

<script src="../../../resources/danger/js/danger.js"></script>
<%@ include file="../footer.jsp" %>