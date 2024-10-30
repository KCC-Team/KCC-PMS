<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>
<link rel="stylesheet" type="text/css" href="../../../resources/common/css/ax5grid.css">
<link rel="stylesheet" type="text/css" href="../../../resources/defect/css/list.css">

<main class="content" id="content">
    <div class="main_content" style="height: 90%">
        <div class="div-section">
            <label class="div-info">
                결함 관리</label>
        </div>
        <div>
            <section>
                <div>
                    <div class="filter-section">
                        <div class="me-4 d-flex justify-content-left align-items-center">
                            <span class="text-nowrap">시스템 분류&nbsp;&nbsp;&nbsp;</span>
                            <input type="hidden" id="systemNo" name="systemNumber" value="${req.systemNumber}" >
                            <div class="system-select-wrapper w-75">
                                    <span class="system-select-button" id="system-select">
                                        <span>시스템/업무 선택</span>
                                    </span>
                                <ul class="mymenu" id="system-menu"></ul>
                            </div>
                        </div>
                        <div class="me-4 d-flex justify-content-left align-items-center">
                            결함 분류&nbsp;&nbsp;&nbsp;
                            <label>
                                <select id="PMS008" class="defect-opt" name="taskSelect">
                                    <option value="all" selected>전체</option>
                                </select>
                            </label>
                        </div>
                        <div class="me-4 d-flex justify-content-left align-items-center">
                            상태 분류&nbsp;&nbsp;&nbsp;
                            <label>
                                <select id="PMS007" class="defect-status" name="taskSelect">
                                    <option value="all" selected>전체</option>
                                </select>
                            </label>
                        </div>
                        <input type="text" class="form-control" id="searchDefect" placeholder="결함 검색하세요." style="height: 40px; width: 215px;">&nbsp;&nbsp;
                        <button id="defect-search-btn" class="save-btn-df d-flex align-items-center me-3 text-nowrap">&nbsp;&nbsp;&nbsp;&nbsp;검색&nbsp;&nbsp;&nbsp;&nbsp;</button>
                        <div class="action-buttons d-flex justify-content-end">
                            <a class="d-flex align-items-center text-nowrap">
                                <button class="add-item add-defect">
                                    <i class="fas fa-plus"></i>&nbsp;&nbsp;결함 등록</button>
                            </a>
                            <a href="#">
                                <button class="danger-export-excel"><i class="fa-solid fa-download"></i> 액셀받기</button>
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
                        }" style="height: 562.5px !important;">
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section class="button-list">
            </section>
        </div>
    </div>

    <script src="../../../resources/defect/js/list.js"></script>
</main>

<%@ include file="../footer.jsp" %>
