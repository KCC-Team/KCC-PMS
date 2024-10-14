<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>
<!-- ax5ui -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%--<script src="https://code.jquery.com/jquery-latest.min.js"></script>--%>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-formatter/master/dist/ax5formatter.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>

<%--<link href="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.38.1/skin-win8/ui.fancytree.min.css" rel="stylesheet">--%>
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.38.1/jquery.fancytree-all-deps.min.js"></script>--%>
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.38.1/modules/jquery.fancytree.table.min.js"></script>--%>
<%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>--%>
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.38.1/modules/jquery.fancytree.filter.min.js"></script>--%>

<link href="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.38.1/skin-win8/ui.fancytree.min.css" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.38.1/jquery.fancytree-all-deps.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.38.1/modules/jquery.fancytree.table.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.38.1/modules/jquery.fancytree.filter.min.js"></script>


<link rel="stylesheet" href="../../../resources/member/css/list.css">
<link rel="stylesheet" href="../../../resources/member/css/ax5grid.css">


<main class="content" id="content">
    <div class="main_content">

        <div class="member-content">
            <div class="member-info"> 투입인력 관리</div>
        </div>

        <div class="container1">
            <div class="left-section">
                <button id="btnResetSearch" style="font-size: 16px; padding: 0px; display: none">&times;</button>
                <!-- 검색 바-->
                <div style="position: sticky; bottom: 0; background-color: #f5f5f5; padding: 3px; display: flex; justify-content: space-between; align-items: center;">
                    <input type="text" name="search" placeholder="팀명 겸색..." style="font-size: 12px; padding: 5px; width: 40%;">
                    <div class="btn-group" style="display: flex; align-items: center;">
                        <span id="matches" style="font-size: 12px; margin-right: 10px;"></span>
                        <button id="btnEdit" style="font-size: 14px; padding: 5px;">순서 편집</button>
                    </div>
                </div>
                <table id="tree-table" class="fancytree-ext-table">
                    <colgroup>
                        <col width="300px">
                        <col width="200px">
                        <col width="100px">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>팀명</th>
                        <th>시스템/업무</th>
                        <th>인원수</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>

            <div class="main-content">
                <h2 class="header1"><span class="member-title">인력</span> </h2>

                <div id="project-member-grid-section" style="display:none;">
                    <div class="team-overview-title">
                        <div class="team-title">전체 투입 인력 목록</div>
                        <div class="btn-group">
                            <button class="">삭제</button>
                            <button class="member-edit-button">편집</button>
                            <button class="openModalBtn">그룹등록</button>
                            <button class="" onclick="openGroupPopup()">인력등록</button>
                        </div>
                    </div>
                    <div style="position: relative;height:270px;" id="grid-parent1">
                        <div data-ax5grid="projectMemberGrid" data-ax5grid-config="{}" style="height: 100%;"></div>
                    </div>
                </div>

                <!-- Modal 시작 -->
                <div id="teamModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <span class="modal-title">팀 등록</span>
                            <span class="close">&times;</span>
                        </div>

                        <div class="modal-form">
                            <form id="teamRegisterForm">
                                <table class="overview-table">
                                    <tr>
                                        <td class="text-align-center">
                                            <label for="team_title">팀명 <span class="required-icon">*</span></label>
                                        </td>
                                        <td colspan="3">
                                            <input type="text" id="team_title" name="team_title" value="" required>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-align-center">
                                            <label for="parent-team">상위 팀 <span class="required-icon">*</span></label>
                                        </td>
                                        <td>
                                            <select id="parent-team" name="parent-team" required onchange="handleStatusChange()">
                                                <option value="">선택하세요.</option>
                                            </select>
                                        </td>
                                        <td class="text-align-center">
                                            <label for="system">시스템/업무 <span class="required-icon">*</span></label>
                                        </td>
                                        <td>
                                            <select id="system" name="system" required onchange="handleStatusChange()">
                                                <option value="">선택하세요.</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-align-center">
                                            <label for="team_cont">팀 설명</label>
                                        </td>
                                        <td colspan="3">
                                            <textarea id="team_cont" name="team_cont" required></textarea>
                                            <span class="desc-count">
                                            <span class="char-count">0</span> / 1000</span>
                                        </td>
                                    </tr>
                                </table>
                                <button type="submit" class="team-rigist-btn">등록</button>
                            </form>
                        </div>
                    </div>
                </div>




                <div class="team-overview">
                    <div class="team-overview-title">
                        <div class="team-title">팀 개요</div>
                        <div class="btn-group">
                            <button class="openModalBtn">그룹등록</button>
                            <button class="">수정</button>
                            <button class="">삭제</button>
                        </div>
                    </div>

                    <table class="overview-table">
                        <tr>
                            <td class="text-align-right">팀명</td>
                            <td colspan="3" id="team-name">-</td>
                        </tr>
                        <tr>
                            <td class="text-align-right">상위 팀</td>
                            <td id="parent-team-name">-</td>
                            <td class="text-align-right">시스템/업무</td>
                            <td id="system-name">-</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-align-center">팀 설명</td>
                        </tr>
                        <tr>
                            <td colspan="4" id="team-description">
                                -
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="team-members">
                    <div class="team-overview-title">
                        <div class="team-title">팀원 목록</div>
                        <div class="btn-group">
                            <button class="">참여시작</button>
                            <button class="">참여종료</button>
                            <button class="">해제</button>
                            <button class="member-edit-button">편집</button>
                            <button class="" onclick="openGroupPopup()">인력등록</button>
                        </div>
                    </div>
                    <div style="position: relative;height:270px;" id="grid-parent">
                        <div data-ax5grid="teamMemberGrid" data-ax5grid-config="{}" style="height: 100%;"></div>
                    </div>
                </div>

                <div class="member-detail">
                    <div class="team-overview-title">
                        <div class="team-title">인력 상세</div>
                        <div class="btn-group">
                            <button class="">수정</button>
                            <button class="">해제</button>
                        </div>
                    </div>
                    <table class="detail-table">
                        <tr>
                            <td class="text-align-right">성명</td>
                            <td colspan="3" id="member-name"></td>
                        </tr>
                        <tr>
                            <td class="text-align-right">프로젝트 권한</td>
                            <td id="project-auth"></td>
                            <td class="text-align-right"> 기술등급</td>
                            <td id="tech-grade"></td>
                        </tr>
                        <tr>
                            <td class="text-align-right">직위</td>
                            <td colspan="3" id="position"></td>
                        </tr>
                        <tr>
                            <td class="text-align-right">예정참여시작일</td>
                            <td id="pre-start-date"></td>
                            <td class="text-align-right"> 예정참여종료일</td>
                            <td id="pre-end-date"></td>
                        </tr>
                        <tr>
                            <td class="text-align-right">참여시작일</td>
                            <td id="start-date"></td>
                            <td class="text-align-right">참여종료일</td>
                            <td id="end-date"></td>
                        </tr>
                        <tr>
                            <td class="text-align-right">Email</td>
                            <td id="email"></td>
                            <td class="text-align-right">내선전화</td>
                            <td id="phone-no"></td>
                        </tr>
                    </table>

                    <div class="team-overview-title">
                        <div class="team-title">소속팀 목록</div>
                    </div>
                    <table class="team-table">

                    </table>
                </div>
            </div>
        </div>

    </div>
</main>

<script src="../../../resources/member/js/list.js"></script>

<%@ include file="../footer.jsp" %>