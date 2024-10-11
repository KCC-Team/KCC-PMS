<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
<!-- ax5ui -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.css">

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-formatter/master/dist/ax5formatter.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>
<!--  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.search.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.dnd.min.js"></script>

<link rel="stylesheet" href="../../../resources/member/css/list.css">
<link rel="stylesheet" href="../../../resources/member/css/ax5grid.css">

<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <div class="member-content">
            <div class="member-info"> 투입인력 관리</div>
        </div>

        <div class="container1">
            <div class="left-section">
                <table class="sidebar-table1">
                    <thead>
                    <tr>
                        <th>팀명</th>
                        <th>시스템/업무</th>
                        <th>인원수</th>
                    </tr>
                    </thead>
                    <tbody>


                    </tbody>
                </table>
            </div>

            <div class="main-content">
                <h2 class="header1"><span class="member-title">인력</span> 2</h2>

                <div class="team-overview">
                    <div class="team-overview-title">
                        <div class="team-title">팀 개요</div>
                        <div class="btn-group">
                            <button class="" onclick="openGroupPopup()">그룹등록</button>
                            <button class="">수정</button>
                            <button class="">삭제</button>
                        </div>
                    </div>

                    <table class="overview-table">
                        <tr>
                            <td class="text-align-right">팀명</td>
                            <td colspan="3">개발팀</td>
                        </tr>
                        <tr>
                            <td class="text-align-right">상위 팀</td>
                            <td>PMS25프로젝트</td>
                            <td class="text-align-right">시스템/업무</td>
                            <td>철도업무시스템</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-align-center">팀 설명</td>
                        </tr>
                        <tr>
                            <td colspan="4">
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
                            <button class="">인력등록</button>
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
                            <td colspan="3">홍길동</td>
                        </tr>
                        <tr>
                            <td class="text-align-right">프로젝트 권한</td>
                            <td>팀원</td>
                            <td class="text-align-right"> 기술등급</td>
                            <td>초급</td>
                        </tr>
                        <tr>
                            <td class="text-align-right">직위</td>
                            <td colspan="3">사원</td>
                        </tr>
                        <tr>
                            <td class="text-align-right">예정참여시작일</td>
                            <td></td>
                            <td class="text-align-right"> 예정참여종료일</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="text-align-right">참여시작일</td>
                            <td></td>
                            <td class="text-align-right">참여종료일</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="text-align-right">Email</td>
                            <td></td>
                            <td class="text-align-right">내선전화</td>
                            <td></td>
                        </tr>
                    </table>

                    <div class="team-overview-title">
                        <div class="team-title">소속팀 목록</div>
                    </div>
                    <table class="team-table">
                        <tr>
                            <td>팀명</td>
                            <td>
                                <select>
                                    <option>팀A</option>
                                    <option>팀B</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>팀명</td>
                            <td>
                                <select>
                                    <option>팀A</option>
                                    <option>팀B</option>
                                </select>
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>

    </div>
</main>

<script src="../../../resources/member/js/list.js"></script>

<%@ include file="../footer.jsp" %>