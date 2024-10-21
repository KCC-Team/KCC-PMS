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
        <div class="div-section">
            <label class="div-info">
                결함 관리</label>
        </div>
        <div>
            <section>
                <div>
                    <div class="filter-section">
                        <div class="d-flex align-items-center" style="width: 100%">
                            <div class="me-4 d-flex justify-content-left align-items-center">
                                시스템 분류&nbsp;&nbsp;&nbsp;
                                <label>
                                    <select name="taskSelect" class="form-select">
                                        <c:forEach var="task" items="${tasks}">
                                            <option value="${task}">${task}</option>
                                        </c:forEach>
                                    </select>
                                </label>
                            </div>
                            <div class="me-4 d-flex justify-content-left align-items-center">
                                결함 분류&nbsp;&nbsp;&nbsp;
                                <label>
                                    <select name="taskSelect" class="form-select">
                                        <c:forEach var="task" items="${tasks}">
                                            <option value="${task}">${task}</option>
                                        </c:forEach>
                                    </select>
                                </label>
                            </div>
                            <input type="text" class="form-control" id="searchTest" placeholder="결함 검색하세요." style="height: 40px; width: 215px;">&nbsp;&nbsp;
                            <button id="test-search-btn" class="custom-button d-flex align-items-center me-3 text-nowrap">&nbsp;&nbsp;&nbsp;&nbsp;검색&nbsp;&nbsp;&nbsp;&nbsp;</button>
                            <div class="action-buttons d-flex justify-content-end">
                                <a class="d-flex align-items-center text-nowrap">
                                    <button class="add-item">
                                        <i class="fas fa-plus"></i>&nbsp;&nbsp;결함 등록</button>
                                </a>
                                <a href="#">
                                    <button class="danger-export-excel"><i class="fa-solid fa-download"></i> 액셀받기</button>
                                </a>
                            </div>
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
                        }" style="height: 557px;">
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
