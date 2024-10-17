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
        </div>

        <form class="project-form" action="#" method="post" enctype="multipart/form-data">
            <input type="hidden" name="type_cd" value="PMS00302">

            <table class="overview-table">
                <tr>
                    <td class="text-align-left">
                        <label for="risk_ttl">제목 <span class="required-icon">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="risk_ttl" name="risk_ttl" value="" required>
                    </td>
                    <td class="text-align-left">
                        <label for="PMS005">위험분류 <span class="required-icon">*</span></label>
                    </td>
                    <td>
                        <select id="PMS005" name="class_cd" required>
                            <option value="">선택하세요.</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-left">
                        <label for="risk_id">위험 ID <span class="required-icon">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="risk_id" name="risk_id" value="" required>
                    </td>
                    <td class="text-align-left">
                        <label for="PMS006">우선순위 <span class="required-icon">*</span></label>
                    </td>
                    <td>
                        <select id="PMS006" name="pri_cd" required>
                            <option value="">선택하세요.</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-left">
                        <label for="rick_cont">위험내용 <span class="required-icon">*</span></label>
                    </td>
                    <td colspan="4">
                        <textarea id="rick_cont" name="rick_cont" required></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-left">
                        <label for="risk_plan">위험완화계획 </label>
                    </td>
                    <td colspan="4">
                        <textarea id="risk_plan" name="risk_plan"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-left">
                        <label for="due_dt">조치희망일 <span class="required-icon">*</span></label>
                    </td>
                    <td>
                        <input type="date" id="due_dt" name="due_dt" value="" required>
                    </td>
                    <td class="text-align-left">
                        <label for="compl_date">조치완료일</label>
                    </td>
                    <td>
                        <input type="date" id="compl_date" name="compl_date" value="">
                    </td>
                </tr>
                <tr>
                    <td class="text-align-left">
                        <label for="PMS004">위험상태 <span class="required-icon">*</span></label>
                    </td>
                    <td>
                        <select id="PMS004" name="stat_cd" required>
                            <option value="">선택하세요.</option>
                        </select>
                    </td>
                    <td class="text-align-left">
                        <label for="mem_no">발견자 <span class="required-icon">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="mem_no" name="mem_no" value="" required>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-left">
                        <label>시스템/업무</label>
                    </td>
                    <td colspan="4">
                        <div class="system-select-wrapper">
                            <button class="system-select-button" id="system-select">
                                <span>시스템/업무 선택</span>

                            </button>
                            <!-- 메뉴 리스트 -->
                            <ul class="mymenu" id="system-menu"></ul>
                        </div>
<%--                        <select id="sys_no" name="sys_no">--%>
<%--                            <option value="">선택하세요.</option>--%>
<%--                            <option value="001">A업무시스템</option>--%>
<%--                            <option value="002">B업무시스템</option>--%>
<%--                            <option value="003">C업무시스템</option>--%>
<%--                        </select>--%>
                    </td>
                </tr>
            </table>


            <div class="file-zone_1 w-100">
                <div class="file-section mt-3">
                    <div class="info-item d-flex flex-column align-items-start">
                        <div class="mb-2"><label>위험 발견 첨부파일</label></div>
                        <div id="df-insert-file-dropzone_1" class="dropzone"></div>
                        <jsp:include page="../output/file/file.jsp" />
                    </div>
                </div>
            </div>

            <div class="file-zone_2 w-100">
                <div class="file-section mt-3">
                    <div class="info-item d-flex flex-column align-items-start">
                        <div class="mb-2"><label>위험 조치 첨부파일</label></div>
                        <div id="df-insert-file-dropzone_2" class="dropzone"></div>
                        <jsp:include page="../output/file/file.jsp" />
                    </div>
                </div>
            </div>

            <div class="btn-actions">
                <% if (type == null) { %>
                <button type="button" class="action-btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    <i class="fa-solid fa-check"></i>&nbsp; 위험조치
                </button>
                <% } %>
                <button type="submit" class="save-btn">
                    <i class="fa-solid fa-check"></i>&nbsp; 저장
                </button>
                <% if (type == null) { %>
                <button class="del-btn">
                    삭제
                </button>
                <% } %>
                <button class="cancel-btn" onclick="history.back()">
                    취소
                </button>
            </div>
        </form>


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

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                    <input type="date" id="record_dt" name="record_dt" class="form-control">
                                </div>
                                <label for="record_cont" class="form-label">조치내용</label>
                                <textarea id="record_cont" name="record_cont" class="form-control" rows="4" placeholder="조치 내용을 입력하세요"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">등록</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

    </div>
</main>

<script src="../../../resources/danger/js/info.js"></script>

<%@ include file="../footer.jsp" %>