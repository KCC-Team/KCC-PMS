<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String type = request.getParameter("type");
    if ("register".equals(type)) {
%>
    <jsp:include page="../project/projectHeader.jsp" />
    <link rel="stylesheet" href="../../../resources/project/css/register.css">
<% } else { %>
    <jsp:include page="../common.jsp" />
    <link rel="stylesheet" href="../../../resources/project/css/info.css">
<% } %>

<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <% if (!"register".equals(type)) { %>
            <div class="project-content">
                <div class="project-info">프로젝트 정보</div>
            </div>
        <% } %>


        <form id="project_form" class="project-form" action="#" method="post">
<%--            <input type="hidden" id="reg_id" name="reg_id" value="hanhee">--%>
            <input type="hidden" id="type" name="type" value="">
            <input type="hidden" id="prj_no" name="prj_no" value="">
            <input type="hidden" id="mem_no" name="mem_no" value="">
            <input type="hidden" id="prj_auth_cd" name="prj_auth_cd" value="">
            <input type="hidden" id="pm_pre_start_dt" name="pm_pre_start_dt" value="">
            <input type="hidden" id="pm_pre_end_dt" name="pm_pre_end_dt" value="">
            <input type="hidden" id="pm_start_dt" name="pm_start_dt" value="">
            <input type="hidden" id="pm_end_dt" name="pm_end_dt" value="">
            <input type="hidden" id="use_yn" name="use_yn" value="Y">

            <table class="overview-table">
                <tr>
                    <td class="text-align-center">
                        <label for="prj_title">프로젝트 명 <span class="required-icon">*</span></label>
                    </td>
                    <td colspan="3" id="team-name">
                        <input type="text" id="prj_title" name="prj_title" value="" required>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-center">
                        <label for="stat_cd">상태 <span class="required-icon">*</span></label>
                    </td>
                    <td id="parent-team-name">
                        <select id="stat_cd" name="stat_cd" required onchange="handleStatusChange()">
                            <option value="">선택하세요.</option>
                        </select>
                    </td>
                    <td class="text-align-center">
                        <label for="prg">진척도 <span class="required-icon">*</span></label>
                    </td>
                    <td id="system-name">
                        <select id="prg" name="prg" required>
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
                    <td class="text-align-center">
                        <label for="org">주관기관 <span class="required-icon">*</span></label></td>
                    <td colspan="3" id="">
                        <input type="text" id="org" name="org" value="" required>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-center">
                        <label >프로젝트 예정 기간 <span class="required-icon">*</span></label>
                    </td>
                    <td colspan="3">
                        <input type="date" id="pre_st_dt" name="pre_st_dt" value="" required>
                        <span>~</span>
                        <input type="date" id="pre_end_dt" name="pre_end_dt" value="" required>
                        <span class="pre_days">(0일)</span>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-center">
                        <label>프로젝트 기간</label>
                    </td>
                    <td colspan="3">
                        <input type="date" id="st_dt" name="st_dt" value="">
                        <span>~</span>
                        <input type="date" id="end_dt" name="end_dt" value="">
                        <span class="days">(0일)</span>
                        <input type="checkbox" id="no_days_period" name="no_days_period">
                        <span class="no-period">기간없음</span>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-center">
                        <label for="mem_num">프로젝트 관리자(PM) <span class="required-icon">*</span></label>
                    </td>
                    <td colspan="3">
                        <input type="text" id="mem_num" name="mem_num" value="" required readonly>
                        <% if ("register".equals(type)) { %>
                            <span class="search-member-btn">선택</span>
                        <% } %>
                    </td>
                </tr>
                <tr>
                    <td class="text-align-center">
                        <label for="prj_cont">프로젝트 설명</label>
                    </td>
                    <td colspan="3">
                        <textarea id="prj_cont" name="prj_cont" required></textarea>
                        <span class="desc-count">
                            <span class="char-count">0</span> / 1000
                        </span>
                    </td>
                </tr>

            </table>

            <div class="form-actions">
                <% if ("register".equals(type)) { %>
                    <button type="submit" class="save-btn">
                        <i class="fa-solid fa-check"></i>&nbsp; 저장
                    </button>
                <% } %>
                <% if ("view".equals(type)) { %>
                    <button type="submit" class="modify-project">
                        <i class="fa-solid fa-check"></i>&nbsp; 저장
                    </button>
                <% } %>
                <button class="cancel-btn" onclick="history.back()">
                    취소
                </button>
                <% if ("view".equals(type)) { %>
<%--                    <button type="button" class="prj-del-btn">--%>
<%--                        <i class="fa-solid fa-arrow-right-to-bracket"></i>&nbsp; 삭제--%>
<%--                    </button>--%>
                <% } %>
            </div>
        </form>


    </div>
</main>

<script src="../../../resources/project/js/info.js"></script>

<% if ("view".equals(type)) { %>
    <%@ include file="../footer.jsp" %>
<% } %>
