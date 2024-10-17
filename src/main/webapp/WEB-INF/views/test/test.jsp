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

<%--<%--%>
<%--    // 데이터 목록 준비--%>
<%--    List<String> tasks = new ArrayList<>();--%>
<%--    tasks.add("");--%>
<%--    tasks.add("연결 작업 1");--%>
<%--    tasks.add("연결 작업 2");--%>
<%--    tasks.add("연결 작업 3");--%>
<%--    // JSP 페이지의 Attribute로 데이터 목록을 설정--%>
<%--    request.setAttribute("tasks", tasks);--%>

<%--    Map<Integer, String> testType = new HashMap<>();--%>
<%--    testType.put(0, "");--%>
<%--    testType.put(1, "단위 테스트");--%>
<%--    testType.put(2, "통합 테스트");--%>
<%--    request.setAttribute("testType", testType);--%>
<%--%>--%>

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
<input type="hidden"  class="disabled-val" value="${disabled}" />

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
                <form id="test-form">
                    <div class="info-item ms-5">
                        <div class="d-flex justify-content-start">
                            <div class="me-4">
                                <input type="hidden" name="testNo" id="testNo" value="${testReq.testNo}" >
                                <div class="d-flex justify-content-start"><label>테스트 명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                <input type="text" name="testTitle" value="${testReq.testTitle}" required ${disabled} >
                            </div>&nbsp;&nbsp;&nbsp;
                            <div class="ms-3">
                                <div class="d-flex justify-content-start"><label>테스트 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                <input id="test_id" type="text" name="testId" value="${testReq.testId}" required ${disabled} >
                            </div>
                        </div>
                        <br>
                        <div class="d-flex justify-content-start">
                            <div class="me-3">
                                <div class="d-flex justify-content-start"><label> 테스트 기간&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                <input type="date" id="due_dt" name="testStartDate" value="${testReq.testStartDate}" required ${disabled} >
                            </div><div><div class="fw-bold fs-1 d-flex justify-content-start"><label>&nbsp;</label></div>~</div>&nbsp;&nbsp;&nbsp;
                            <div class="ms-3">
                                <div class="d-flex justify-content-start"><label>&nbsp;&nbsp;&nbsp;</label></div>
                                <input type="date" id="compl_date" name="testEndDate" value="${testReq.testEndDate}" ${disabled} >
                            </div>
                        </div>
                        <br>
                        <div class="d-flex justify-content-start">
                            <div class="me-4">
                                <div class="d-flex justify-content-start"><label>테스트 구분&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                <select name="testType" id="testType" required ${disabled}>
                                    <option value="0"
                                            <c:if test="${empty testReq.testType}">
                                                selected disabled
                                            </c:if>
                                    >선택</option>
                                    <option value="PMS01201"
                                            <c:if test="${testReq.testType == '단위'}">
                                                selected
                                            </c:if>
                                    >단위 테스트</option>
                                    <option value="PMS01202"
                                            <c:if test="${testReq.testType == '통합'}">
                                                selected
                                            </c:if>
                                    >통합 테스트</option>
                                </select>
                            </div>
                            <div class="ms-4 me-4">
                                <div class="d-flex justify-content-start"><label>상태&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                <select name="testStatus" id="testStatus" required ${disabled}>
                                    <c:forEach var="stat" items="${testStatus}" varStatus="loop">
                                        <c:choose>
                                            <c:when test="${stat.value == testReq.testStatus}">
                                                <option value="${stat.key}" selected disabled>${stat.value}</option>
                                            </c:when>
                                            <c:when test="${stat.key == 0}">
                                                <option value="${stat.key}" selected disabled>${stat.value}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${stat.key}">${stat.value}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="ms-4">
                                <div class="d-flex justify-content-start"><label>작성자</label></div>
                                <span>홍길동</span>
                                <%--                                <span>${writer}</span>--%>
                            </div>
                        </div>
                        <br>
                        <div class="d-flex justify-content-start">
<%--                            <div class="me-4">--%>
<%--                                <div class="d-flex justify-content-start"><label>시스템 분류</label></div>--%>
<%--                                <select name="systemType" id="systemType" required ${disabled}>--%>
<%--                                    <c:forEach var="type" items="${systemType}">--%>
<%--                                        <c:choose>--%>
<%--                                            <c:when test="${type.value == testReq.systemType}">--%>
<%--                                                <option value="${type.key}" selected>${type.value}</option>--%>
<%--                                            </c:when>--%>
<%--                                            <c:when test="${type.key == 0}">--%>
<%--                                                <option value="${type.key}" selected disabled>${type.value}</option>--%>
<%--                                            </c:when>--%>
<%--                                            <c:otherwise>--%>
<%--                                                <option value="${type.key}">${type.value}</option>--%>
<%--                                            </c:otherwise>--%>
<%--                                        </c:choose>--%>
<%--                                    </c:forEach>--%>
<%--                                </select>--%>
<%--                            </div>--%>
                            <div class="ms-4 me-4">
                                <div class="d-flex justify-content-start"><label>시스템-업무 구분</label></div>
                                <select name="workType" id="workType" required ${disabled}>
                                    <c:forEach var="type" items="${workType}">
                                        <c:choose>
                                            <c:when test="${type.value == testReq.workType}">
                                                <option value="${type.key}" selected>${type.value}</option>
                                            </c:when>
                                            <c:when test="${type.key == 0}">
                                                <option value="${type.key}" selected disabled>${type.value}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${type.key}">${type.value}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <br><br>
                        <div class="d-flex justify-content-start">
                            <div class="me-4">
                                <div class="d-flex justify-content-start"><label>테스트 설명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></label></div>
                                <textarea id="test-txt" name="testCont" required ${disabled} >${testReq.testCont}</textarea>
                                <div class="word-count">0 / 500</div>
                            </div>
                        </div>
                        <br>
                        <div id="dynamic-content"></div>
                        <div class="tc-area d-flex justify-content-center" style="display: none !important;">
                            <button type="button" class="custom-button tc-btn fs-5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                테스트케이스 추가
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
                        </div>
                    </div>
                    <br><br>
                    <div class="d-flex justify-content-end pe-5">
                        <c:choose>
                            <c:when test="${type eq 'register' || type eq 'modify'}">
                                <button type="submit" class="custom-button" style="background-color: #62ce66">&nbsp;&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;&nbsp;</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <button type="button" class="custom-button cancel" style="background-color: #8B8B8B">&nbsp;&nbsp;&nbsp;&nbsp;취소&nbsp;&nbsp;&nbsp;&nbsp;</button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="custom-button modify-btn" style="background-color: #1c9aef">&nbsp;&nbsp;&nbsp;&nbsp;수정&nbsp;&nbsp;&nbsp;&nbsp;</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <button type="button" class="custom-button delete-btn" style="background-color: #f13737">&nbsp;&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;&nbsp;</button>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </form>
            </section>
        </div>
    </div>

    <script type="text/javascript">
        let isViewMode = <% out.print(request.getParameter("type") == null ? "true" : "false"); %>;
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serializeJSON/3.2.1/jquery.serializejson.min.js"></script>
    <script src="../../../resources/test/js/test.js"></script>
</main>

<%@ include file="../footer.jsp" %>
