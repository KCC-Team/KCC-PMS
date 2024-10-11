<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<link rel="stylesheet" href="../../../resources/wbs/css/wbsList.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js"></script>
<link rel="stylesheet" href="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css">


<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <div class="filter-section">
            <div class="action-buttons">
                <button class="btn-modify-wbs">편집</button>
                <button class="btn-save-wbs-sort">저장</button>
                <button id="toggle-grid">간트 차트 크게 보기</button>
            </div>
        </div>

        <div id="gantt_here"></div>

        <button type="button" class="action-btn add-wbs-info" data-bs-toggle="modal" data-bs-target="#wbsInfoModal">등록</button>

        <!-- wbs Modal -->
        <div class="modal fade" id="wbsInfoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title fs-5" id="exampleModalLabel">WBS 등록 정보</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">

                        <form id="wbs_form" action="#" method="post">
                            <table class="form-table">
                                <tr>
                                    <th>작업명 <span class="required-icon">*</span></th>
                                    <td><input type="text" id="name" name="" value="홍길동"></td>
                                    <th>상태 <span class="required-icon">*</span></th>
                                    <td>
                                        <select id="" name="">
                                            <option>진행중</option>
                                            <option>..</option>
                                        </select>
                                    </td>
                                    <th>시스템/업무 <span class="required-icon">*</span></th>
                                    <td>
                                        <select id="" name="">
                                            <option>진행중</option>
                                            <option>..</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>예정 시작일 <span class="required-icon">*</span></th>
                                    <td><input type="date" id="" name="" value="2024-03-17"></td>
                                    <th>예정 종료일 <span class="required-icon">*</span></th>
                                    <td><input type="date" id="" name="" value="2024-03-17"></td>
                                    <th>상위작업</th>
                                    <td><input type="text" id="" name="" value="홍길동" readonly></td>
                                </tr>
                                <tr>
                                    <th>시작일</th>
                                    <td><input type="date" id="" name="" value="2024-03-17"></td>
                                    <th>종료일</th>
                                    <td><input type="date" id="" name="" value="2024-03-17"></td>
                                    <th>선행작업</th>
                                    <td><input type="text" id="" name="" value="홍길동"></td>
                                </tr>
                                <tr>
                                    <th>진척도 <span class="required-icon">*</span></th>
                                    <td>
                                        <select id="" name="">
                                            <option>10%</option>
                                            <option>..</option>
                                        </select>
                                    </td>
                                    <th>가중치</th>
                                    <td>
                                        <select id="" name="">
                                            <option>10%</option>
                                            <option>..</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>담당자</th>
                                    <td colspan="3">
                                        <input type="text" id="mem_no" name="mem_no" value="" readonly>
                                        <button type="button" class="btn-select-user">사용자 선택</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th>산출물</th>
                                    <td>
                                        <button type="button" class="btn-select-output">산출물 등록</button>
                                    </td>
                                    <th>관련 산출물</th>
                                    <td>
                                        <input type="text" id="" name="" value="">
                                    </td>
                                </tr>

                            </table>

                            <div class="modal-footer">
                                <button type="submit" class="btn-save-wbs">저장</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>

    </div>
</main>

<script src="../../../resources/wbs/js/wbsList.js"></script>
<script src="../../../resources/wbs/js/wbsInfo.js"></script>

<%@ include file="../footer.jsp" %>