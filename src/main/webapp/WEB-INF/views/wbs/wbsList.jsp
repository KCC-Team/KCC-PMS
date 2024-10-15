<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<link rel="stylesheet" href="../../../resources/wbs/css/wbsList.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js"></script>
<link rel="stylesheet" href="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css">


<main class="content" id="content">
    <div class="main_content">

        <div class="filter-section">
            <div class="action-buttons">
                <button class="btn-modify-wbs">순서 변경</button>
                <button class="btn-save-wbs-sort">저장</button>
                <button id="toggle-grid">간트 차트 크게 보기</button>
            </div>
        </div>

        <div id="gantt_here"></div>

    </div>
</main>

<script src="../../../resources/wbs/js/wbsList.js"></script>
<script src="../../../resources/wbs/js/wbsInfo.js"></script>

<%@ include file="../footer.jsp" %>