<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="../common.jsp" %>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="../../../resources/test/css/test.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>


<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-toast/master/dist/ax5toast.css" />
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-toast/master/dist/ax5toast.min.js"></script>

<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<main class="content" id="content">
    <div class="main_content" style="width: 97%; height: 90%">
        <div class="div-section">
            <div class="d-flex justify-content-left">
                <label class="div-info">
                    테스트 정보</label>
                <div class="button-area">
                    <div class="d-flex justify-content-end me-5">
                        <button type="submit" id="excelUploadButton" class="excel-btn export-excel">
                            &nbsp;&nbsp;<i class="fa-solid fa-file-csv"></i>&nbsp;&nbsp;액셀받기&nbsp;&nbsp;&nbsp;&nbsp;
                        </button>
                        &nbsp;
                        <button type="submit" class="save-btn-test" id="save-test">
                            &nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;
                        </button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="submit" class="delete-btn-test">
                            &nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;&nbsp;
                        </button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" class="cancel-btn me-3">
                            &nbsp;&nbsp;&nbsp;닫기&nbsp;&nbsp;&nbsp;&nbsp;
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <br><br><br><br>
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
                                <input type="text" id="testStartDate" name="testStartDate" value="${fn:substring(scheduleDate,0,10) }" class="test-date" placeholder="yyyy-mm-dd" style="width: 100%;" readonly>
                            </td>
                            <td class="td-title">테스트 종료일</td>
                            <td>
                                <input type="text" id="testEndDate" name="testEndDate" value="${fn:substring(scheduleDate,0,10) }" class="test-date" placeholder="yyyy-mm-dd" style="width: 100%;" readonly>
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
            <section class="ms-2 test-rlt-area flex-column" id="chartArea">
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
                            <canvas id="defectChart" width="295px" height="198"></canvas>
                        </div>
                    </section>
                </div>
            </section>
        </section>
        <section>
            <div class="d-flex justify-content-left">
                <div class="feature-area">
                    <div class="feature-select-area">
                        <table>
                            <tr>
                                <td class="td-title text-nowrap">테스트케이스ID&nbsp;&nbsp;&nbsp;</td>
                                <td>
                                    <input type="text" id="testDetailId" name="testDetailId" value="${testReq.testDetailId}" style="width: 200px">
                                </td>
                                <td class="td-title text-nowrap">기능 ID 선택&nbsp;&nbsp;&nbsp;</td>
                                <td style="width: 200px !important;">
                                    <select id="feature" class="feature-select" name="taskSelect">
                                        <option value="" selected disabled>기능 선택</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="testCase-section">
                <table id="test-case-area">
                </table>
            </div>
        </section>
    </div>

    <div class="modal fade" id="excelUploadModal" tabindex="-1" aria-labelledby="excelUploadModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="excelUploadModalLabel"><i class="fa-solid fa-file-csv"></i> 액셀 파일 업로드</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex justify-content-left align-items-center">
                    <input type="file" id="excelFileInput" accept=".xlsx, .xls" style="width: 300px"/>
                    <label class="clear-btn" id="removeFileButton" style="display: none;">&times;</label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="cancel-btn" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="save-btn-test" id="uploadExcelButton">업로드</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serializeJSON/3.2.1/jquery.serializejson.min.js"></script>
    <script src="../../../resources/test/js/test.js"></script>
</main>

<%@ include file="../footer.jsp" %>
