<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Object prjNo = session.getAttribute("prjNo");
    Long prjNoInt = null;
    if (prjNo instanceof Long) {
        prjNoInt = (Long) prjNo;
    }
%>

<script type="text/javascript">
    var prjNo = '<%= prjNoInt != null ? prjNoInt.toString() : "" %>';
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../../../resources/wbs/css/wbsInfo.css">

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WBS 정보</title>
</head>
<body>
    <!-- WBS Modal -->
    <div class="modal fade" id="wbsInfoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <span class="modal-title">WBS 등록 정보</span>
                </div>

                <div class="modal-body">

                    <form id="wbs_form" action="#" method="post">
                        <input type="hidden" id="tsk_no" name="tsk_no" value="">
                        <input type="hidden" id="mem_no" name="mem_no" value="">
                        <input type="hidden" id="tm_no" name="tm_no" value="">
                        <input type="hidden" id="max_order_id" name="max_order_id" value="">

                        <table class="form-table">
                            <tr>
                                <th><label for="tsk_ttl">작업명 <span class="required-icon">*</span></label></th>
                                <td><input type="text" id="tsk_ttl" name="tsk_ttl" value="" required></td>
                                <th><label for="tsk_stat_cd">상태 <span class="required-icon">*</span></label></th>
                                <td>
                                    <select id="tsk_stat_cd" name="tsk_stat_cd" required>
                                        <option value="">선택하세요.</option>
                                        <option value="PMS00101">대기</option>
                                        <option value="PMS00102">진행중</option>
                                        <option value="PMS00103">완료</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th><label for="pre_st_dt">예정 시작일 <span class="required-icon">*</span></label></th>
                                <td><input type="text" id="pre_st_dt" name="pre_st_dt" placeholder="yyyy-mm-dd" required></td>
                                <th><label for="pre_end_dt">예정 종료일 <span class="required-icon">*</span></label></th>
                                <td><input type="text" id="pre_end_dt" name="pre_end_dt" placeholder="yyyy-mm-dd" required></td>
                            </tr>
                            <tr>
                                <th>시작일</th>
                                <td><input type="text" id="st_dt" name="st_dt" placeholder="yyyy-mm-dd"></td>
                                <th>종료일</th>
                                <td><input type="text" id="end_dt" name="end_dt" placeholder="yyyy-mm-dd"></td>
                            </tr>
                            <tr>
                                <th><label for="prg">진척도 <span class="required-icon">*</span></label></th>
                                <td>
                                    <select id="prg" name="prg">
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
                                <th>가중치</th>
                                <td>
                                    <select id="weight_val" name="weight_val">
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
                            <tr id="par_task_nm_row">
                                <th>상위작업</th>
                                <td colspan="3"><input type="text" id="par_task_nm" name="par_task_nm" value="" readonly></td>
                            </tr>
                            <tr>
                                <th>담당자</th>
                                <td colspan="3">
                                    <input type="text" id="mem_nm" name="mem_nm" value="" readonly>
                                    <button type="button" class="btn-select-user">사용자 선택</button>
                                </td>
                            </tr>
                            <tr>
                                <th>산출물</th>
                                <td colspan="3">
                                    <input type="text" id="output_nm" name="output_nm" value="" readonly>
                                    <button type="button" class="btn-select-output">산출물 연결</button>
                                </td>
                            </tr>
                            <tr>
                                <th>관련 산출물명</th>
                                <td>
                                    <input type="text" id="rel_out_nm" name="rel_out_nm" value="">
                                </td>
                                <th>시스템/업무</th>
                                <td>
                                    <select id="sys_no" name="sys_no">
                                        <option value="">선택하세요.</option>
                                    </select>
                                </td>
                            </tr>

                        </table>

                        <div class="modal-footer">
                            <button type="submit" class="btn-save-wbs">저장</button>
                            <button onclick="window.close();" class="btn-close-wbs">닫기</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
    <!-- wbs Info Modal -->

    <script src="../../../resources/wbs/js/wbsInfo.js"></script>
</body>
</html>

