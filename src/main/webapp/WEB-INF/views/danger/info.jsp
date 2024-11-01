<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<%
    String type = request.getParameter("type");
    String titleName = "위험 상세 정보";
    if ("register".equals(type)) {
        titleName = "위험 등록";
    }
%>

<link rel="stylesheet" href="../../../resources/issue/css/info.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.css" />

<main class="content" id="content">
    <div class="main_content">

        <div class="project-content">
            <div class="project-info"><%=titleName%></div>
            <div class="btn-actions">
                <% if (type == null) { %>
                <button type="button" class="action-btn" data-bs-toggle="modal" data-bs-target="#historyModal">
                    <i class="fa-solid fa-check"></i>&nbsp; 위험조치
                </button>
                <% } %>
                <button id="saveRisk" type="submit" class="save-btn">
                    <i class="fa-solid fa-check"></i>&nbsp; 저장
                </button>
                <% if (type == null) { %>
                <button class="del-btn">
                    삭제
                </button>
                <% } %>
                <button class="cancel-btn"  onclick="window.location.href='/projects/dangers'">
                    <i class="fa-solid fa-arrow-left-long"></i> 뒤로가기
                </button>
            </div>
        </div>

            <form id="riskForm" class="project-form" action="#" method="post" enctype="multipart/form-data">
                <input type="hidden" name="issueRiskType" value="PMS00302">
                <input type="hidden" id="riskNumber" name="riskNumber" value="" >
                <div class="all-section">

                    <div class="left-section">

                        <table class="overview-table">
                            <tr>
                                <td class="text-align-left">
                                    <label for="riskTitle">제목 <span class="required-icon">*</span></label>
                                </td>
                                <td colspan="5">
                                    <input type="text" id="riskTitle" name="riskTitle" value="" required>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-align-left">
                                    <label for="riskId">위험 ID <span class="required-icon">*</span></label>
                                </td>
                                <td class="td-row">
                                    <input type="text" id="riskId" name="riskId" value="" required>
                                </td>
                                <td class="text-align-left">
                                    <label>위험분류 <span class="required-icon">*</span></label>
                                </td>
                                <td class="td-row">
                                    <select id="PMS005" name="classCode" required>
                                        <option value="">선택하세요.</option>
                                    </select>
                                </td>
                                <td class="text-align-left">
                                    <label>우선순위 <span class="required-icon">*</span></label>
                                </td>
                                <td class="td-row">
                                    <select id="PMS006" name="priorCode" required>
                                        <option value="">선택하세요.</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-align-left">
                                    <label>시스템/업무</label>
                                </td>
                                <td colspan="3">
                                    <input type="hidden" name="systemNo" id="systemNo">
                                    <div class="system-select-wrapper">
                                        <span class="system-select-button" id="system-select">
                                            <span>시스템/업무 선택</span>
                                        </span>
                                        <!-- 메뉴 리스트 -->
                                        <ul class="mymenu" id="system-menu"></ul>
                                    </div>
                                </td>
                                <td class="text-align-left">
                                    <label>위험상태 <span class="required-icon">*</span></label>
                                </td>
                                <td>
                                    <select id="PMS004" name="statusCode" required>
                                        <option value="">선택하세요.</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-align-left">
                                    <label for="riskContent">위험내용 <span class="required-icon">*</span></label>
                                </td>
                                <td colspan="5">
                                    <textarea id="riskContent" name="riskContent" required></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-align-left">
                                    <label for="riskPlan">위험완화계획 </label>
                                </td>
                                <td colspan="5">
                                    <textarea id="riskPlan" name="riskPlan"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-align-left">
                                    <label for="dueDate">조치희망일 <span class="required-icon">*</span></label>
                                </td>
                                <td>
                                    <input type="date" id="dueDate" name="dueDate" value="" required>
                                </td>
                                <td class="text-align-left">
                                    <label for="completeDate">조치완료일</label>
                                </td>
                                <td>
                                    <input type="date" id="completeDate" name="completeDate" value="">
                                </td>
                                <td class="text-align-left">
                                    <label for="memberNo">발견자 <span class="required-icon">*</span></label>
                                </td>
                                <td>
                                    <input type="hidden" id="memberNo" name="memberNo" value="" required>
                                    <input type="text" id="memberName" name="memberName" value="" readonly>
                                </td>
                            </tr>
                        </table>


                        <div class="file-area">
                            <div class="mt-3 file-zone_1" style="width: 99%">
                                <div class="file-section">
                                    <div class="info-item d-flex flex-column align-items-start">
                                        <div><label class="file-find-title">위험 발견 첨부파일</label></div>
                                        <div id="risk-insert-file-dropzone_1" class="dropzone"></div>
                                        <jsp:include page="../output/file/file-task.jsp" />
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div> <!-- left_section END -->

                    <div class="right-section">

                        <% if (type == null) { %>
                        <div class="history-section">
                            <div class="history-title">이력</div>

                            <div class="history-item">
                                <div class="history-header">
                                    <div class="history-name">홍길동</div>
                                    <div class="history-date">2022-05-17</div>
                                </div>
                                <div class="history-content">
                                    위험조치내용위험조치내용위험조치내용위험조치내용위험조치내용위험조치내용위험조치내용
                                </div>
                            </div>

                            <div class="history-item">
                                <div class="history-header">
                                    <div class="history-name">홍길동</div>
                                    <div class="history-date">2022-05-17</div>
                                </div>
                                <div class="history-content">
                                    위험조치내용위험조치내용위험조치내용위험조치내용위험조치내용위험조치내용위험조치내용
                                </div>
                            </div>
                        </div>
                        <% } %>

                    </div> <!-- right_section END -->

                </div> <!-- all_section END -->

            </form>

        <input type="hidden" id="historyNo" name="historyNo">
        <!-- Modal -->
        <div class="modal fade" id="historyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">위험 조치</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <form id="historyForm" action="#" method="post">
                        <div class="modal-body">
                            <div>

                                <div>
                                    <label for="record_dt">조치일자</label>
                                    <input type="date" id="record_dt" name="record_dt" class="form-control" required>
                                </div>
                                <label for="record_cont" class="form-label">조치내용</label>
                                <textarea id="record_cont" name="record_cont" class="form-control" rows="4" placeholder="조치 내용을 입력하세요"></textarea>
                                <!-- 조치 첨부파일 Dropzone 추가 -->
                                <div id="historyZone" class="file-zone_3 mt-3" style="width: 99%">
                                    <div class="file-section mt-3">
                                        <div class="info-item d-flex flex-column align-items-start">
                                            <div><label class="file-find-title">위험 조치 첨부파일</label></div>
                                            <div id="history-insert-file-dropzone" class="dropzone"></div>
                                            <jsp:include page="../output/file/file-task.jsp" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="addHistoryBtn" type="submit" class="btn btn-primary">등록</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

    </div>
</main>

<script src="../../../resources/danger/js/info.js"></script>
<script type="text/javascript">
    let registerMember = JSON.parse('${registerMemberJson}');
</script>

<%@ include file="../footer.jsp" %>