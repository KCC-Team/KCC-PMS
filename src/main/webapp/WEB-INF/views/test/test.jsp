<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="../common.jsp" %>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="../../../resources/test/css/test.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

<main class="content" id="content">
    <div class="main_content" style="width: 97%; height: 90%">
        <div class="div-section">
            <label class="div-info">
                테스트 정보</label>
            <div class="button-area">
                <div class="d-flex justify-content-end me-5">
                    <button type="submit" class="excel-btn export-excel">
                        &nbsp;&nbsp;&nbsp;&nbsp;엑셀받기&nbsp;&nbsp;&nbsp;&nbsp;
                    </button>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="submit" class="save-btn-test">
                        &nbsp;&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;
                    </button>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="button" class="cancel-btn me-3">
                        &nbsp;&nbsp;&nbsp;&nbsp;닫기&nbsp;&nbsp;&nbsp;&nbsp;
                    </button>
                </div>
            </div>
        </div>
        <section class="test-content ms-3 d-flex justify-content-left">
            <section class="test-info-area">
                <form id="test-form">
                    <input type="hidden" name="testNo" id="testNo" value="${testReq.testNumber}" >
                    <table class="test-table">
                        <tr>
                            <td class="td-title">테스트 명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td colspan="3">
                                <input type="text" id="testTitle" name="testTitle" value="${testReq.testTitle}" required style="width: 100%;">
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">테스트 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <input type="text" id="testId" name="testId" value="${testReq.testId}" required style="width: 100%;">
                            </td>
                            <td class="td-title">테스트 구분&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <select name="testType" id="PMS012" required style="width: 100%;">
                                    <option value="" selected disabled>구분 선택</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">상태&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <select name="testStatus" id="PMS013" required style="width: 100%;">
                                    <option value="" selected disabled>상태 선택</option>
                                </select>
                            </td>
                            <td class="td-title">시스템-업무 분류</td>
                            <td>
                                <input type="hidden" id="systemNo" name="systemNumber" value="${req.systemNumber}">
                                <div class="system-select-wrapper w-100">
                                <span class="system-select-button" id="system-select">
                                    <span>시스템/업무 선택</span>
                                </span>
                                    <ul class="mymenu" id="system-menu"></ul>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title text-nowrap">테스트 시작일&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <input type="text" id="testStartDate" name="testStartDate" value="${fn:substring(scheduleDate,0,10) }" class="test-date" placeholder="yyyy-mm-dd" style="width: 100%;">
                            </td>
                            <td class="td-title">테스트 종료일</td>
                            <td>
                                <input type="text" id="testEndDate" name="testEndDate" value="${fn:substring(scheduleDate,0,10) }" class="test-date" placeholder="yyyy-mm-dd" style="width: 100%;">
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">테스트 설명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td colspan="3">
                                <textarea id="testContent" name="testContent" required style="width: 100%;">${testReq.testContent}</textarea>
                            </td>
                        </tr>
                    </table>
                </form>
            </section>
            <section class="ms-2 test-rlt-area flex-column">
                <div class="test-rlt-title fw-bold">테스트 개요</div>
                <section class="d-flex justify-content-between">
                    <div class="test-rlt-title w-100">테스트 케이스 상태</div>
                    <div class="test-rlt-title w-100">결함 상태</div>
                </section>
                <div>
                    <section class="d-flex justify-content-left" style="width: 98%; height: 98%">
                        <div class="border pt-1 pb-1" style="height: 208px;">
                            <canvas id="testCaseChart" width="295px"></canvas>
                        </div>
                        <div class="border pt-1 pb-1" style="height: 208px;">
                            <canvas id="defectChart"></canvas>
                        </div>
                    </section>
                </div>
            </section>
        </section>
        <section>
            <section>
                <div class="d-flex justify-content-left">
                    <div class="feature-area">
                        <div class="feature-select-area d-flex justify-content-left">
                            <label class="text-nowrap">테스트케이스ID&nbsp;&nbsp;&nbsp;</label>
                            <input type="text" id="testDetailId" name="testDetailId" value="${testReq.testDetailId}" style="width: 200px">
                            &nbsp;&nbsp;&nbsp;<label class="text-nowrap">기능 ID 선택&nbsp;&nbsp;&nbsp;</label>
                            <select id="feature" class="feature-select" name="taskSelect">
                                <option value="" selected disabled>기능 선택</option>
                            </select>
                        </div>

                    </div>
                    <div class="excel-area">
                        <button type="button">&nbsp;&nbsp;&nbsp;테스트케이스 엑셀 업로드&nbsp;&nbsp;&nbsp;</button>
                    </div>
                </div>

                <div class="testCase-section">
                    <table id="test-case-area">
                    </table>
                </div>
            </section>
        </section>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serializeJSON/3.2.1/jquery.serializejson.min.js"></script>
    <script src="../../../resources/test/js/test.js"></script>
</main>

<%@ include file="../footer.jsp" %>
