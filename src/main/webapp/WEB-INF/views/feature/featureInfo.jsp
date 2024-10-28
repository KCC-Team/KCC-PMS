<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../../../resources/feature/css/featureInfo.css">

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기능 정보</title>
    <script type="text/javascript">
        var prjNo = "${prjNo}";
        var featureNo = "${featureNo}";
    </script>
</head>
<body>

<div class="modal fade" id="wbsInfoModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <span class="modal-title">기능 등록 정보</span>
            </div>

            <div class="modal-body">

                <form id="feat_form" action="#" method="post">
                    <input type="hidden" id="mem_no" name="memberNo">
                    <input type="hidden" id="tm_no" name="teamNo">
                    <input type="hidden" id="systemNo" name="systemNo">
                    <input type="hidden" id="featNo" name="featNo">
                    <table class="form-table">
                        <tr>
                            <th><label for="feat_title">기능명 <span class="required-icon">*</span></label></th>
                            <td><input type="text" id="feat_title" name="featTitle" value="" required></td>
                            <th><label for="feat_id">기능ID <span class="required-icon">*</span></label></th>
                            <td><input type="text" id="feat_id" name="featId" value="" required></td>
                        </tr>
                        <tr>
                            <th><label>기능분류 <span class="required-icon">*</span></label></th>
                            <td>
                                <select id="PMS010" name="classCode">
                                    <option value="" selected>선택</option>
                                </select>
                            </td>
                            <th><label>우선순위 <span class="required-icon">*</span></label></th>
                            <td>
                                <select id="PMS006" name="priorCode">
                                    <option value="0" selected>선택</option>

                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><label>시스템/업무분류</label></th>
                            <td>
                                <div class="system-select-wrapper">
                                    <span class="system-select-button" id="system-select">
                                        <span>시스템/업무 선택</span>
                                    </span>
                                    <!-- 메뉴 리스트 -->
                                    <ul class="mymenu" id="system-menu"></ul>
                                </div>
                            </td>

                            <th><label>난이도<span class="required-icon">*</span></label></th>
                            <td>
                                <select id="PMS011" name="diffCode">
                                    <option value="" selected>선택</option>

                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="pre_st_dt">예정 시작일 <span class="required-icon">*</span></label></th>
                            <td><input type="text" id="pre_st_dt" name="preStartDateStr" placeholder="yyyy-mm-dd" required></td>
                            <th><label for="pre_end_dt">예정 종료일 <span class="required-icon">*</span></label></th>
                            <td><input type="text" id="pre_end_dt" name="preEndDateStr" placeholder="yyyy-mm-dd" required></td>
                        </tr>
                        <tr>
                            <th>시작일</th>
                            <td><input type="text" id="st_dt" name="startDateStr" placeholder="yyyy-mm-dd"></td>
                            <th>종료일</th>
                            <td><input type="text" id="end_dt" name="endDateStr" placeholder="yyyy-mm-dd"></td>
                        </tr>
                        <tr>
                            <th><label>상태 <span class="required-icon">*</span></label></th>
                            <td>
                                <select id="PMS009" name="statusCode" required>
                                    <option value="">선택하세요.</option>

                                </select>
                            </td>
                            <th><label for="prg">진척도 <span class="required-icon">*</span></label></th>
                            <td>
                                <select id="prg" name="progress">
                                    <option value="0" selected>0%</option>
                                    <option value="10">10%</option>
                                    <option value="20">20%</option>
                                    <option value="30">30%</option>
                                    <option value="40">40%</option>
                                    <option value="50">50%</option>
                                    <option value="60">60%</option>
                                    <option value="70">70%</option>
                                    <option value="80">80%</option>
                                    <option value="90">90%</option>
                                    <option value="100">100%</option>
                                </select>
                            </td>

                        </tr>
                        <tr>
                            <th>작업자</th>
                            <td colspan="3">
                                <input type="text" id="mem_nm" name="memberName" value="" readonly>
                                <button type="button" class="btn-select-user" onclick="openTeamPopUp('feature')">사용자 선택</button>
                            </td>
                        </tr>
                        <tr>
                            <th>기능설명</th>
                            <td colspan="3">
                                <textarea id="feat_cont" name="featDescription"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>테스트ID</th>
                            <td colspan="3">
                                <a href="#">테스트아이디1</a>
                            </td>
                        </tr>

                    </table>

                    <div class="modal-footer">
                        <button type="submit" class="btn-save-feature">저장</button>
                        <button onclick="window.close();" class="btn-close-feature">닫기</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
<!-- wbs Info Modal -->
<script src="../../../resources/common/js/common.js"></script>
<script src="../../../resources/feature/js/featureInfo.js"></script>
</body>
</html>

