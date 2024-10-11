<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>
<%--<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.css">--%>

<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-formatter/master/dist/ax5formatter.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.css">
<link rel="stylesheet" type="text/css" href="../../../resources/output/css/ax5grid.css">

<link rel="stylesheet" type="text/css" href="../../../resources/output/css/list.css">

<!-- 샘플 데이터 -->
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    // 데이터 목록 준비
    List<String> tasks = new ArrayList<>();
    tasks.add("연결 작업 1");
    tasks.add("연결 작업 2");
    tasks.add("연결 작업 3");
    // JSP 페이지의 Attribute로 데이터 목록을 설정
    request.setAttribute("tasks", tasks);
%>

<main class="content" id="content">
    <div class="main_content">
        <br>
        <div class="ps-5 pe-5">
            <label class="ms-4 fw-bold fs-2 text-black">
                프로젝트 산출물</label>
            <hr>
            <div class="d-flex justify-content-center">
                <div style="width: 95%;">
                    <div class="d-flex justify-content-end align-items-center">
                        <input type="text" class="form-control w-25" id="search" placeholder="산출물 이름을 입력해주세요.">
                        &nbsp;&nbsp;
                        <button id="search-btn" class="custom-button d-flex align-items-center me-3">&nbsp;&nbsp;&nbsp;&nbsp;검색&nbsp;&nbsp;&nbsp;&nbsp;</button>
                    </div>
                    <section class="output-figure mt-3">
                        <div class="table-header d-flex justify-content-end align-items-center border-bottom mb-3">
                            <div class="me-5">
                                <button id="newFolder" class="btn btn-link" type="button"><i class="fa-regular fa-folder"></i>&nbsp;&nbsp;&nbsp;새 폴더 만들기</button>
                            </div>
                        </div>
                        <div class="table-body p-1 ms-4 d-flex align-items-center" style="width: 38%">
                            <span class="me-3">폴더: <label class="folder-cnt fw-normal">2</label></span>
                            <span>문서: <label class="docs-cnt fw-normal">3</label></span>
                            <span class="ms-auto d-flex justify-content-end">
                                <button class="custom-button file-insert-btn" type="button">&nbsp;산출물 등록하기&nbsp;</button>&nbsp;&nbsp;&nbsp;
                                <button class="custom-button modify-btn me-2" type="button">&nbsp;<i class="fa-regular fa-folder"></i>&nbsp;&nbsp;위치 편집&nbsp;</button>
                            </span>
                        </div>
                        <section class="d-flex justify-content-between" style="height: 70%; margin-left: 11px;">
                            <section class="first-component">
                                <div class="fir-com-header d-flex justify-content-center align-items-center">
                                    파일명
                                </div>
                                <div class="jstree-section">
                                    <jsp:include page="jstree.jsp" />
                                </div>
                            </section>
                            <section class="second-component p-3">
                                <div>
                                    <label class=" fw-bold fs-5 text-black">
                                        산출물 상세</label>
                                    <hr style="margin-top: 7px; margin-bottom: 7px;">
                                    <div class="d-flex justify-content-end pe-3">
                                        <button class="custom-button file-modify-btn" type="button">&nbsp;&nbsp;<i class="modify-icon"></i>&nbsp;&nbsp;수정&nbsp;&nbsp;</button>
                                    </div>
                                    <div>
                                        <h5 class="text-black">&nbsp;&nbsp;&nbsp;산출물명</h5>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="input-area" value="A 업무 시스템 요구사항 정의서" disabled/>
                                    </div>
                                    <br>
                                    <div>
                                        <h5 class="text-black">&nbsp;&nbsp;&nbsp;연결 작업</h5>
                                        <c:forEach var="task" items="${tasks}">
                                            <a href="#" class="task ms-4">${task}</a>
                                            <br>
                                        </c:forEach>
                                    </div>
                                    <br>
                                    <div class="d-flex align-items-center mb-1">
                                        <h5 class="text-black me-3">&nbsp;&nbsp;&nbsp;파일 목록</h5>
                                        <span class="label me-5">파일: &nbsp;<label id="detail-cnt">0</label></span>
                                        <button type="button" class="green-btn me-2">&nbsp;&nbsp;&nbsp;선택 다운로드&nbsp;&nbsp;&nbsp;</button>
                                        <button type="button" class="red-btn">&nbsp;&nbsp;&nbsp;선택 삭제&nbsp;&nbsp;&nbsp;</button>
                                        <button type="button" id="file-insert" class="custom-button ms-auto me-3 d-flex justify-content-end">&nbsp;&nbsp;파일 추가&nbsp;&nbsp;</button>
                                    </div>
                                    <div class="d-flex justify-content-center">
                                        <div class="ax5-ui" style="width: 97%;">
                                            <div data-ax5grid="my-grid" style="height: 300px;">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </section>
                    </section>
                </div>
            </div>
        </div>
    </div>

    <!-- 산출물 정보 수정 모달 -->
    <div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="fileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" style="color: #070606; font-weight: bold">산출물 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <section class="info-section">
                        <div class="d-flex justify-content-between">
                            <div class="info-item">
                                <div class="info-item d-flex align-items-start ms-3">
                                    <div class="d-flex justify-content-start">
                                        <div><label class="text-nowrap">제목&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                        <span><textarea class="txt-area"></textarea></span>
                                    </div>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-item d-flex flex-column align-items-start">
                                    <div class="d-flex justify-content-start">
                                        <div><label class="text-nowrap">연결 작업 선택&nbsp;&nbsp;&nbsp;</label></div>
                                        <select class="form-select" aria-label="Multiple select example" id="task-select-list">
                                            <option value="" selected disabled>작업 선택하기</option>
                                            <option value="1">현행 업무분석</option>
                                            <option value="2">업무 프로세스 분석</option>
                                        </select>
                                    </div>
                                    <div class="select-box-list">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
                <div class="modal-footer">
                    <button type="button" class="save-button" data-bs-dismiss="modal">&nbsp;&nbsp;저장하기&nbsp;&nbsp;</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 동적 모달 -->
    <jsp:include page="modal/file-detail-modal.jsp" />
    <jsp:include page="modal/folder-modal.jsp" />
    <jsp:include page="modal/file-insert-modal.jsp" />
    <jsp:include page="modal/output-file-insert.jsp" />
    <jsp:include page="modal/output-file-reinsert.jsp" />
    <script src="../../../resources/output/js/list.js"></script>
</main>

<%@ include file="../footer.jsp" %>