<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>
<link rel="stylesheet" type="text/css" href="../../../resources/common/css/ax5grid.css">
<link rel="stylesheet" type="text/css" href="../../../resources/test/css/list.css">

<main class="content" id="content">
    <div class="main_content" style="height: 85%">
        <div class="div-section">
            <label class="div-info">
                테스트 관리</label>
        </div>
        <div class="test">
            <section>
                <div class="filter-section">
                    <div class="d-flex align-items-center" style="width: 100%">
                        <div class="me-4 d-flex justify-content-left align-items-center text-nowrap">
                            <span class="text-nowrap">시스템 분류&nbsp;&nbsp;&nbsp;</span>
                            <input type="hidden" id="systemNo" name="systemNumber" value="${req.systemNumber}" >
                            <div class="system-select-wrapper w-75">
                                    <span class="system-select-button" id="system-select">
                                        <span>시스템/업무 선택</span>
                                    </span>
                                <ul class="mymenu" id="system-menu"></ul>
                            </div>
                        </div>
                        <div class="me-4 d-flex justify-content-left align-items-center text-nowrap">
                            테스트 구분&nbsp;&nbsp;&nbsp;
                            <label>
                                <select id="PMS012" name="taskSelect" class="test-opt form-select">
                                    <option value="all" selected disabled>구분 선택</option>
                                </select>
                            </label>
                        </div>
                        <div class="me-4 d-flex justify-content-left align-items-center text-nowrap">
                            상태&nbsp;&nbsp;&nbsp;
                            <label>
                                <select id="PMS013" name="taskSelect" class="test-status form-select">
                                    <option value="all" selected disabled>상태 선택</option>
                                </select>
                            </label>
                        </div>
                        <input type="text" class="form-control" id="searchTest" placeholder="테스트를 검색하세요." style="height: 40px; width: 215px;">&nbsp;&nbsp;
                        &nbsp;&nbsp;
                        <button id="test-search-btn" class="custom-button d-flex align-items-center me-3 text-nowrap">&nbsp;&nbsp;&nbsp;&nbsp;검색&nbsp;&nbsp;&nbsp;&nbsp;</button>
                        <div class="action-buttons d-flex justify-content-end">
                            <a class="d-flex align-items-center text-nowrap">
                                <button class="add-item add-test">
                                    <i class="fas fa-plus"></i>&nbsp;&nbsp;테스트 등록</button>
                            </a>
                        </div>
                    </div>
                </div>
            </section>
            <section>
                <div class="d-flex justify-content-center">
                    <div style="width: 94%;">
                        <div style="position: relative;height:100%;" id="test-grid-parent">
                            <div class="list_table" data-ax5grid="first-grid"  data-ax5grid-config="{
                                sortable: true,
                                header: {
                                    columnHeight: 50,
                                },
                                body: {
                                    columnHeight: 48
                                }
                                }" style="height: 562px;">
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <script src="../../../resources/test/js/list.js"></script>
</main>

<%@ include file="../footer.jsp" %>
