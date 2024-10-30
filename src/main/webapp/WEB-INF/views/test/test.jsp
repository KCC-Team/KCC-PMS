<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="../common.jsp" %>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="../../../resources/test/css/test.css">

<main class="content" id="content">
    <div class="main_content">
        <br>
        <div class="ps-5 pe-5">
            <section>
                <div class="d-flex justify-content-between align-items-center">
                    <label class="ms-4 fw-bold fs-2 text-black">
                        테스트 상세</label>
                </div>
            </section>
            <hr>
            <section>
                <div class="me-4">
                    <label class="ms-4 fw-bold fs-4 text-black">
                        테스트 기본 정보</label>
                </div>
                <form id="test-form">
                    <input type="hidden" name="testNo" id="testNo" value="${testReq.testNumber}" >
                    <table class="test-table ms-4">
                        <tr>
                            <td class="td-title">테스트 명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <input type="text" name="testTitle" value="${testReq.testTitle}" required >
                            </td>
                            <td class="td-title">테스트 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <input id="test_id" type="text" name="testId" value="${testReq.testId}" required >
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title text-nowrap">테스트 시작일&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <input type="text" name="testStartDate" value="${fn:substring(scheduleDate,0,10) }" class="test-date" placeholder="yyyy-mm-dd" >
                            </td>
                            <td class="td-title">테스트 종료일</td>
                            <td>
                                <input type="text" name="testEndDate" value="${fn:substring(scheduleDate,0,10) }" class="test-date" placeholder="yyyy-mm-dd" >
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">테스트 구분&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <select name="testType" id="PMS012" required >
                                    <option value="" selected disabled>구분 선택</option>
                                </select>
                            </td>
                            <td class="td-title">상태&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <select name="testStatus" id="PMS013" required >
                                    <option value="" selected disabled>상태 선택</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">작성자</td>
                            <td>
                                <span>${memberName}</span>
                            </td>
                            <td class="td-title">시스템-업무 분류</td>
                            <td>
                                <input type="hidden" id="systemNo" name="systemNumber" value="${req.systemNumber}" >
                                <div class="system-select-wrapper w-100">
                                    <span class="system-select-button" id="system-select">
                                        <span>시스템/업무 선택</span>
                                    </span>
                                    <ul class="mymenu" id="system-menu"></ul>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">테스트 설명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td colspan="3">
                                <textarea id="test-txt" name="testCont" required >${testReq.testContent}</textarea>
                                <div class="word-count">0 / 500</div>
                            </td>
                        </tr>
                    </table>
                    <br>
                    <div id="dynamic-content"></div>
                    <div class="tc-area d-flex justify-content-center" style="display: none !important;">
                        <button type="button" class="custom-button tc-btn fs-5">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;테스트케이스 추가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </button>
                    </div>
                    <br><br>
                    <div class="d-flex justify-content-end pe-5">
                        <button type="submit" class="custom-button" style="background-color: #62ce66">
                            &nbsp;&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;
                        </button>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" class="custom-button cancel" style="background-color: #8B8B8B">
                            &nbsp;&nbsp;&nbsp;&nbsp;닫기&nbsp;&nbsp;&nbsp;&nbsp;
                        </button>
                    </div>
                </form>
            </section>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serializeJSON/3.2.1/jquery.serializejson.min.js"></script>
    <script src="../../../resources/test/js/test.js"></script>
</main>

<%@ include file="../footer.jsp" %>
