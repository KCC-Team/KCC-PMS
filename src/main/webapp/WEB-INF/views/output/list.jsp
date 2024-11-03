<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-formatter/master/dist/ax5formatter.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-mask/master/dist/ax5mask.css" />
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-mask/master/dist/ax5mask.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.css">
<link rel="stylesheet" type="text/css" href="../../../resources/common/css/ax5gridMin.css">

<link rel="stylesheet" type="text/css" href="../../../resources/output/css/list.css">

<main class="content" id="content">
    <div class="main_content" style="height: 87%">
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
                                <input type="text" class="form-control" id="search" placeholder="산출물을 검색하세요." style="width: 275px;">&nbsp;&nbsp;
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
                            <div class="output-btn-area">
                                <button id="output-delete-btn" class="custom-button me-2 text-nowrap" type="button">&nbsp;&nbsp;&nbsp;산출물 삭제&nbsp;&nbsp;&nbsp;</button>
                                <button id="output-save-btn" class="custom-button file-modify-btn text-nowrap" type="button">&nbsp;&nbsp;<i class="modify-icon"></i>&nbsp;&nbsp;저장&nbsp;&nbsp;</button>
                            </div>
                            <div>
                                <input type="hidden" id="outputNo"/>
                                <h5 class="text-black">&nbsp;&nbsp;&nbsp;산출물명</h5>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="outputTitle" name="outputTitle" class="input-area" value=""/>
                            </div>
                            <br>
                            <div class="output-task-area">
                                <h5 class="text-black text-nowrap">&nbsp;&nbsp;&nbsp;연결 작업</h5>
                                <div id="outputTask">
                                </div>
                            </div>
                            <div>
                                <h5 class="text-black">&nbsp;&nbsp;&nbsp;비고</h5>
                                <textarea id="outputNote" name="outputNote" class="ms-3 txt-area" rows="4" cols="50"></textarea>
                            </div>
                            <br>
                            <div class="file-opt-area">
                                <div class="d-flex align-items-center mb-1">
                                    <h5 class="text-black me-3">&nbsp;&nbsp;&nbsp;파일 목록</h5>
                                    <span class="label me-3">파일: &nbsp;<label id="detail-cnt">0</label></span>
                                    <button id="file-delete-his-btn" class="custom-button " type="button">&nbsp;&nbsp;삭제 기록&nbsp;&nbsp;</button>&nbsp;&nbsp;&nbsp;
                                        <button type="button" id="file-insert" class="custom-button me-2">&nbsp;&nbsp;파일 추가&nbsp;&nbsp;</button>
                                    <div class="ms-auto d-flex justify-content-end">
                                        <button type="button" class="ms-auto green-btn me-2 download-btn">&nbsp;&nbsp;&nbsp;선택 다운로드&nbsp;&nbsp;&nbsp;</button>
                                        <button type="button" id="file-delete-btn" class="red-btn">&nbsp;&nbsp;&nbsp;선택 삭제&nbsp;&nbsp;&nbsp;</button>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-center">
                                    <div class="ax5-ui" style="width: 100%;">
                                        <div data-ax5grid="my-grid" style="height: 300px;" data-ax5grid-config="{
                                            multipleSelect: true,
                                        }">
                                        </div>
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
