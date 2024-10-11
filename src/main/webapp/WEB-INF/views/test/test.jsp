<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>
<%--<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.css">--%>
<link rel="stylesheet" type="text/css" href="../../../resources/test/css/ax5grid.css">
<link rel="stylesheet" type="text/css" href="../../../resources/test/css/test.css">

<!-- 샘플 데이터 -->
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    // 데이터 목록 준비
    List<String> tasks = new ArrayList<>();
    tasks.add("");
    tasks.add("연결 작업 1");
    tasks.add("연결 작업 2");
    tasks.add("연결 작업 3");
    // JSP 페이지의 Attribute로 데이터 목록을 설정
    request.setAttribute("tasks", tasks);

    Map<Integer, String> testType = new HashMap<>();
    testType.put(0, "");
    testType.put(1, "단위 테스트");
    testType.put(2, "통합 테스트");
    request.setAttribute("testType", testType);
%>

<c:set var="type" value="${type}" />
<c:choose>
    <c:when test="${type eq 'register'}">
        <c:set var="titleName" value="테스트 등록" />
        <c:set var="disabled" value="" />
    </c:when>
    <c:when test="${type eq 'modify'}">
        <c:set var="titleName" value="테스트 수정" />
        <c:set var="disabled" value="" />
    </c:when>
    <c:otherwise>
        <c:set var="titleName" value="테스트 상세" />
        <c:set var="disabled" value="disabled" />
    </c:otherwise>
</c:choose>
<input type="hidden" id="disabled-val" value="${disabled}" />

<main class="content" id="content">
    <div class="main_content">
        <br>
        <div class="ps-5 pe-5">
            <section>
                <div class="d-flex justify-content-between align-items-center">
                    <label class="ms-4 fw-bold fs-2 text-black">
                       ${titleName}</label>
                </div>
            </section>
            <hr>
            <section>
                <div class="me-4">
                    <label class="ms-4 fw-bold fs-4 text-black">
                        테스트 정보</label>
                </div>
                <div class="info-item ms-5">
                    <div class="d-flex justify-content-start">
                        <div class="me-4">
                            <div class="d-flex justify-content-start"><label>테스트 명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                            <input type="text" value="" required ${disabled} >
                        </div>&nbsp;&nbsp;&nbsp;
                        <div class="ms-4">
                            <div class="d-flex justify-content-start"><label>테스트 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                            <input id="teat_id" type="text" value="" required ${disabled} >
                        </div>
                    </div>
                    <br>
                    <div class="d-flex justify-content-start">
                        <div class="me-3">
                            <div class="d-flex justify-content-start"><label> 테스트 기간&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                            <input type="date" id="due_dt" name="due_dt" value="" required ${disabled} >
                        </div><div><div class="fw-bold fs-1 d-flex justify-content-start"><label>&nbsp;</label></div>~</div>
                        <div class="ms-3">
                            <div class="d-flex justify-content-start"><label>&nbsp;&nbsp;&nbsp;</label></div>
                            <input type="date" id="compl_date" name="compl_date" value="" ${disabled} >
                        </div>
                    </div>
                    <br>
                    <div class="d-flex justify-content-start">
                        <div class="me-4">
                            <div class="d-flex justify-content-start"><label>테스트 구분&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                            <select name="test-type" id="test-type" required ${disabled}>
                                <c:forEach var="test" items="${testType}">
                                    <option value="${test.key}" ${test.key == 0 ? 'selected' : ''}>${test.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="ms-4 me-4">
                            <div class="d-flex justify-content-start"><label>상태&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                            <select name="test-status" required ${disabled} >
                                <c:forEach var="task" items="${tasks}">
                                    <option value="${task}">${task}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="ms-4">
                            <div class="d-flex justify-content-start"><label>작성자</label></div>
                            <span>홍길동</span>
                        </div>
                    </div>
                    <br>
                    <div class="d-flex justify-content-start">
                        <div class="me-4">
                            <div class="d-flex justify-content-start"><label>시스템 분류</label></div>
                            <select name="system-type" required ${disabled} >
                                <c:forEach var="task" items="${tasks}">
                                    <option value="${task}">${task}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="ms-4 me-4">
                            <div class="d-flex justify-content-start"><label>업무 구분</label></div>
                            <select name="work-type" required ${disabled} >
                                <c:forEach var="task" items="${tasks}">
                                    <option value="${task}">${task}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <br><br>
                    <div class="d-flex justify-content-start">
                        <div class="me-4">
                            <div class="d-flex justify-content-start"><label>테스트 설명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                            <textarea id="test-txt" name="test-status" required ${disabled} ></textarea>
                            <div class="word-count">0 / 500</div>
                        </div>
                    </div>
                    <br>
                    <div id="dynamic-content"></div>
                    <div class="d-flex justify-content-center" style="display: none;">
                        <button class="custom-button tc-btn">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            테스트케이스 추가
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
                </div>
            </section>

        </div>
    </div>



    <script src="../../../resources/test/js/test.js"></script>
</main>

<%@ include file="../footer.jsp" %>
