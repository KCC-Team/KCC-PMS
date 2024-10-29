<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KCC PMS</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">

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

<c:set var="discoverDate" value="${req.discoverDate}" />
<c:set var="scheduleDate" value="${req.scheduleWorkDate}" />
<c:set var="workDate" value="${req.workDate}" />

<%
    Object prjNo = session.getAttribute("prjNo");
    Long prjNoInt = null;
    if (prjNo instanceof Long) {
        prjNoInt = (Long) prjNo;
    }
%>

<script type="text/javascript">
    let prjNo = '<%= prjNoInt != null ? prjNoInt.toString() : "" %>';
</script>

    <div class="popup-header">
        <span class="popup-title">결함 정보</span>
    </div>
    <section style="height: 600px">
        <form id="defectForm">
            <input type="hidden" name="defectNumber" value="${req.defectNumber}" >
            <input type="hidden" id="fd_mem_no" name="foundMemberNo" value="${req.foundMemberNo}">
            <input type="hidden" id="work_mem_no" name="workMemberNo" value="${req.workMemberNo}">
            <div class="d-flex justify-content-left">
                <div class="me-3" style="width: 550px !important;">
                    <table class="defect-table w-100">
                        <tr>
                            <td class="td-title">결함 명&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td class="font-nowrap">
                                <input type="text" name="defectTitle" value="${req.defectTitle}" required >
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
                            <td class="td-title">결함 ID&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <input type="text" name="defectId" value="${req.defectId}" required >
                            </td>
                            <td class="td-title">테스트 ID</td>
                            <td>
                                <a href="#">${req.testId}</a>
                                <input type="hidden" name="testNumber" value="${req.testNumber}" >
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">결함 구분&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <select id="PMS008" name="typeSelect" class="type" required >
                                    <option value="" selected disabled>결함 분류 선택</option>
                                </select>
                            </td>
                            <td class="td-title">기능 ID</td>
                            <td>
                                <a href="#">${req.testId}</a>
                                <input type="hidden" name="testNumber" value="${req.testNumber}" >
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="td-title">결함 내용&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <textarea name="defectContent" required >${req.defectContent}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">우선순위&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <select id="PMS006" name="prioritySelect" class="type" required >
                                    <option value="" selected disabled>우선순위 선택</option>
                                </select>
                            </td>
                            <td class="td-title">상태&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <select id="PMS007" name="statusSelect" class="type" required >
                                    <option value="" selected disabled>상태 선택</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">발견자&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td class="d-flex justify-content-center align-items-center">
                                <input type="text" id="fd_mem_nm" name="foundMemberName" value="${req.foundMemberName}" readonly style="width: 90px">&nbsp;&nbsp;
                                <button type="button" class="btn-select-user" onclick="openTeamPopUp('defect1')">선택</button>
                            </td>
                            <td class="td-title">발견일자&nbsp;&nbsp;&nbsp;<span class="es-star">*</span></td>
                            <td>
                                <input type="text" name="discoverDate" value="${fn:substring(discoverDate,0,10) }" class="defect-date" placeholder="yyyy-mm-dd" required >
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">조치희망일</td>
                            <td colspan="3">
                                <div class="d-flex justify-content-left" style="width: 149px">
                                    <input type="text" name="scheduleWorkDate" value="${fn:substring(scheduleDate,0,10) }" class="defect-date" placeholder="yyyy-mm-dd" >
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-title">조치자</td>
                            <td class="d-flex justify-content-center align-items-center">
                                <input type="text" id="work_mem_nm" name="workMemberName" value="${req.workMemberName}" readonly style="width: 90px">&nbsp;&nbsp;
                                <button type="button" class="btn-select-user" onclick="openTeamPopUp('defect2')">선택</button>
                            </td>
                            <td class="td-title">조치일자</td>
                            <td>
                                <input type="text" name="workDate" value="${fn:substring(workDate,0,10) }" class="defect-date" placeholder="yyyy-mm-dd" >
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="td-title text-center">결함 조치 내용</td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <textarea name="workContent" >${req.workContent}</textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <section class="d-flex flex-column ps-3 pe-3" style="border: 1px solid #ccc;">
                    <div class="mt-3 file-zone_1" style="width: 500px">
                        <div class="file-section">
                            <div class="info-item d-flex flex-column align-items-start">
                                <div class="mb-2"><label>결함 발견 첨부파일</label></div>
                                <div id="df-insert-file-dropzone_1" class="dropzone"></div>
                                <jsp:include page="../output/file/file-task.jsp" />
                            </div>
                        </div>
                    </div>
                    <div class="file-zone_2 mt-3" style="width: 500px">
                        <div class="file-section mt-3">
                            <div class="info-item d-flex flex-column align-items-start">
                                <div class="mb-2"><label>결함 조치 첨부파일</label></div>
                                <div id="df-insert-file-dropzone_2" class="dropzone"></div>
                                <jsp:include page="../output/file/file-task.jsp" />
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <br>
            <section class="btn-sec d-flex justify-content-center">
                <button type="submit" class="save-btn me-3" id="save-df">&nbsp;<i class="fa-solid fa-check"></i>&nbsp;&nbsp;저장&nbsp;&nbsp;</button>
                <button class="del-btn me-3" style="display: none;">&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;</button>
                <button class="btn btn-secondary" id="can-df">&nbsp;&nbsp;&nbsp;닫기&nbsp;&nbsp;&nbsp;</button>
            </section>
        </form>
    </section>

<script src="../../../resources/common/js/common.js"></script>
<script type="text/javascript">
    let discoverFilesJson = '<c:out value="${discoverFilesJson}" escapeXml="false" />';
    let workFilesJson = '<c:out value="${workFilesJson}" escapeXml="false" />';
    let typeSelect = '<c:out value="${req.typeSelect}" escapeXml="false" />';
    let prioritySelect = '<c:out value="${req.prioritySelect}" escapeXml="false" />';
    let statusSelect = '<c:out value="${req.statusSelect}" escapeXml="false" />';
    let discoverFiles = discoverFilesJson && discoverFilesJson.trim() !== '' ? JSON.parse(discoverFilesJson) : [];
    let workFiles = workFilesJson && workFilesJson.trim() !== '' ? JSON.parse(workFilesJson) : [];
</script>

</body>
</html>
