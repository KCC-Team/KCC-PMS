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
<link rel="stylesheet" type="text/css" href="../../../resources/common/css/ax5gridMin.css">

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
        <div class="div-section">
            <label class="div-info">
                프로젝트 산출물 관리</label>
        </div>
        <div class="d-flex justify-content-center">
            <div style="width: 95%;">
                <section class="d-flex justify-content-between" style="margin-left: 11px;">
                    <section class="first-component">
                        <div class="table-body p-1 ms-2 d-flex justify-content-end align-items-center" style="width: 100%">
                            <span class="ms-auto d-flex justify-content-left">
                                <input type="text" class="form-control" id="search" placeholder="산출물을 검색하세요." style="width: 270px;">&nbsp;&nbsp;
                                <button id="newFolder" class="custom-button me-2 text-nowrap" type="button">&nbsp;<i class="fa-regular fa-folder"></i>&nbsp;새 폴더 생성&nbsp;</button>
                                <button class="custom-button file-insert-btn me-2 text-nowrap" type="button">&nbsp;산출물 등록&nbsp;</button>
                                <button class="custom-button modify-btn me-2 text-nowrap" type="button">&nbsp;순서 편집&nbsp;</button>
                            </span>
                        </div>
                        <div class="fir-com-header fw-bold d-flex justify-content-center align-items-center">
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
                                <button id="file-delete-his-btn" class="custom-button me-2" type="button">&nbsp;&nbsp;삭제 기록&nbsp;&nbsp;</button>
                                <button class="custom-button file-modify-btn" type="button">&nbsp;&nbsp;<i class="modify-icon"></i>&nbsp;&nbsp;저장&nbsp;&nbsp;</button>
                            </div>
                            <div>
                                <h5 class="text-black">&nbsp;&nbsp;&nbsp;산출물명</h5>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="input-area" value="A 업무 시스템 요구사항 정의서"/>
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
            </div>
        </div>
    </div>

    <!-- 동적 모달 -->
    <jsp:include page="modal/folder-modal.jsp" />
    <jsp:include page="modal/output-file-insert.jsp" />
    <jsp:include page="modal/file-insert-modal.jsp" />
    <jsp:include page="modal/file-history-modal.jsp" />
    <script src="../../../resources/output/js/list.js"></script>
</main>

<%@ include file="../footer.jsp" %>
