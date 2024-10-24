<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<link rel="stylesheet" href="../../../resources/wbs/css/wbsList.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js"></script>
<link rel="stylesheet" href="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css">


<main class="content" id="content">
    <div class="main_content">

        <div class="project-content">
            <div class="project-info">프로젝트 WBS</div>
        </div>

        <div class="filter-section">
            <div class="action-buttons">
                <button class="add-save-wbs" onclick="wbsInfoPopup('new');">작업 추가</button>
                <button class="btn-modify-wbs">순서 변경</button>
                <button class="btn-save-wbs-sort">저장</button>
                <button id="toggle-grid">간트 차트 크게 보기</button>
            </div>
        </div>

        <div id="gantt_no_data">
            등록된 작업이 없습니다. 작업을 추가해주세요.
        </div>

        <div id="gantt_here"></div>

    </div>
</main>

<script src="../../../resources/wbs/js/wbsList.js"></script>
<script src="../../../resources/wbs/js/wbsInfo.js"></script>

<%@ include file="../footer.jsp" %>