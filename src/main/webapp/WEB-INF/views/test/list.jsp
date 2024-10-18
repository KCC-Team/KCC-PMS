<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>
<%--<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.css">--%>
<link rel="stylesheet" type="text/css" href="../../../resources/common/css/ax5grid.css">
<link rel="stylesheet" type="text/css" href="../../../resources/test/css/list.css">

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
        <div class="test ps-5 pe-5">
            <section>
                <div class="d-flex justify-content-between align-items-center">
                    <label class="ms-4 fw-bold text-black" style="font-size: 20px">
                        테스트 관리</label>
                    <div class="d-flex justify-content-center">
                        <button type="button" class="test-add-btn btn btn-primary d-flex justify-content-end align-items-center me-4 text-nowrap">
                            <i class="fas fa-plus"></i>&nbsp;&nbsp;테스트 등록</button>
                        <input type="text" class="form-control" id="searchTest" placeholder="테스트를 검색하세요." style="height: 40px;">
                        &nbsp;&nbsp;
                        <button id="test-search-btn" class="custom-button d-flex align-items-center me-3 text-nowrap">&nbsp;&nbsp;&nbsp;&nbsp;검색&nbsp;&nbsp;&nbsp;&nbsp;</button>
                    </div>
                </div>
            </section>
            <hr>
            <section>
                <div class="d-flex justify-content-end align-items-center me-5">
                    <div class="me-4">
                        <label>시스템 분류</label>&nbsp;&nbsp;&nbsp;
                        <label>
                            <select name="taskSelect" class="form-select">
                                <c:forEach var="task" items="${tasks}">
                                    <option value="${task}">${task}</option>
                                </c:forEach>
                            </select>
                        </label>
                    </div>
                    <div class="me-4">
                        <label>업무 구분</label>&nbsp;&nbsp;&nbsp;
                        <label>
                            <select name="taskSelect" class="form-select">
                                <c:forEach var="task" items="${tasks}">
                                    <option value="${task}">${task}</option>
                                </c:forEach>
                            </select>
                        </label>
                    </div>
                    <div class="me-4">
                        <label>테스트 구분</label>&nbsp;&nbsp;&nbsp;
                        <label>
                            <select name="taskSelect" class="form-select">
                                <c:forEach var="task" items="${tasks}">
                                    <option value="${task}">${task}</option>
                                </c:forEach>
                            </select>
                        </label>
                    </div>
                    <div class="me-4">
                        <label>상태</label>&nbsp;&nbsp;&nbsp;
                        <label>
                            <select name="taskSelect" class="form-select">
                                <c:forEach var="task" items="${tasks}">
                                    <option value="${task}">${task}</option>
                                </c:forEach>
                            </select>
                        </label>
                    </div>
                </div>
            </section>
            <section>
                <div class="d-flex justify-content-center">
                    <div style="width: 90%;">
                        <div style="position: relative;height:100%;" id="test-grid-parent">
                            <div class="list_table" data-ax5grid="first-grid"  data-ax5grid-config="{
                                header: {
                                    columnHeight: 50,
                                },
                                body: {
                                    columnHeight: 50
                                }
                                }" style="height: 575px;">
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
