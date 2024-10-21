<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KCC PMS</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.css" />

    <link rel="stylesheet" href="../../../resources/defect/css/defect.css">
    <script src="../../../resources/defect/js/defect.js"></script>
</head>

<style>
    .popup-header {
        margin-bottom: 10px;
    }

    .popup-title {
        display: block;
        color: #000;
        font-weight: bold;
        font-size: 18px;
        margin-bottom: 10px;
        width: 100%;
        border-bottom: 1px solid #000;
    }
</style>
<body>
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

    Map<Integer, String> sys_type = new HashMap<>();
    sys_type.put(0, "선택");
    sys_type.put(1, "단위 테스트");
    sys_type.put(2, "통합 테스트");
    request.setAttribute("sys_type", sys_type);
%>

<c:set var="type" value="${type}" />
<c:choose>
    <c:when test="${type eq 'register'}">
        <c:set var="titleName" value="결함 등록" />
        <c:set var="save" value="저장" />
    </c:when>
    <c:otherwise>
        <c:set var="titleName" value="결함 상세" />
        <c:set var="work" value="조치" />
        <c:set var="save" value="저장" />
    </c:otherwise>
</c:choose>

<c:set var="type" value="${type}" />
<c:choose>
    <c:when test="${type eq 'register'}">
        <c:set var="titleName" value="결함 등록" />
    </c:when>
    <c:otherwise>
        <c:set var="titleName" value="결함 상세" />
    </c:otherwise>
</c:choose>
    <div class="popup-header">
        <span class="popup-title">결함 정보</span>
    </div>
    <section style="height: 600px">
        <div class="d-flex justify-content-left">
            <div class="me-4" style="width: 550px !important;">
                <table class="defect-table w-100">
                    <tr>
                        <td class="td-title">결함 명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                        <td class="font-nowrap">
                            <input type="text" class="defect-name" value="요구사항정의서 ID미부여 항목 발견" required >
                        </td>
                        <td class="td-title">시스템 분류</td>
                        <td>
                            <select name="sys-type" class="type" required >
                                <c:forEach var="sys" items="${sys_type}">
                                    <option value="${sys.key}" ${sys.key == 0 ? 'selected' : ''}>${sys.value}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-title">결함 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                        <td>
                            <input type="text" class="defect-id" value="TT-123-asd-1-df_1" required >
                        </td>
                        <td class="td-title">테스트 ID</td>
                        <td>
                            <input type="text" class="defect-id" value="TT-123-asd-1" required >
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="td-title">결함 설명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <textarea class="defect-desc" required ></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-title">우선순위&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                        <td>
                            <select name="sys-type" class="type" required >
                                <c:forEach var="sys" items="${sys_type}">
                                    <option value="${sys.key}" ${sys.key == 0 ? 'selected' : ''}>${sys.value}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td class="td-title">상태&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                        <td>
                            <select name="sys-type" class="type" required >
                                <c:forEach var="sys" items="${sys_type}">
                                    <option value="${sys.key}" ${sys.key == 0 ? 'selected' : ''}>${sys.value}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-title">발견자&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                        <td>
                            <span>홍길동</span>
                        </td>
                        <td class="td-title">발견일자&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                        <td>
                            <input type="date" class="date" name="date" value="" required >
                        </td>
                    </tr>
                    <tr>

                        <td class="td-title">조치희망일</td>
                        <td>
                            <input type="date" class="date" name="date" value="" required >
                        </td>
                        <td class="td-title">조치일자</td>
                        <td>
                            <input type="date" class="date" name="date" value="" required >
                        </td>
                    </tr>
                </table>
            </div>
            <div class="file-zone_1" style="width: 500px">
                <div class="file-section">
                    <div class="info-item d-flex flex-column align-items-start">
                        <div class="mb-2"><label>결함 발견 첨부파일</label></div>
                        <div id="df-insert-file-dropzone_1" class="dropzone"></div>
                        <jsp:include page="../output/file/file-task.jsp" />
                    </div>
                </div>
            </div>
        </div>
        <br>
        <c:if test="${not empty defectAct and defectAct != ''}">
            <section class="defect-table work-info">
                <table>
                    <tr>
                        <td colspan="4" class="td-title text-center">결함 조치 내용</td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <textarea class="defect-desc" required >${defectAct}</textarea>
                        </td>ss
                    </tr>
                </table>
                <div class="file-zone_2">
                    <div class="file-section mt-3">
                        <div class="info-item d-flex flex-column align-items-start">
                            <div class="mb-2"><label>결함 발견 첨부파일</label></div>
                            <div id="df-insert-file-dropzone_2" class="dropzone"></div>
                            <jsp:include page="../output/file/file.jsp" />
                        </div>
                    </div>
                </div>
            </section>
        </c:if>
        <section class="btn-sec d-flex justify-content-center">
            <c:choose>
                <c:when test="${isAction != null}">
                    <button class="btn btn-secondary me-3" id="modify">&nbsp;&nbsp;&nbsp;${save}&nbsp;&nbsp;&nbsp;</button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-primary" id="work">&nbsp&nbsp;&nbsp;${work}&nbsp;&nbsp;&nbsp;</button>&nbsp;&nbsp;&nbsp;
                    <button class="btn btn-secondary me-3" id="modify">&nbsp;&nbsp;&nbsp;${save}&nbsp;&nbsp;&nbsp;</button>
                </c:otherwise>
            </c:choose>
        </section>
    </section>
</body>
</html>