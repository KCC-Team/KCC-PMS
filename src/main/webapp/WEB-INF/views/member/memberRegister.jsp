<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>인력 등록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
    <!-- ax5ui -->
    <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    <link rel="stylesheet" href="../../../resources/member/css/memberRegister.css">
    <link rel="stylesheet" href="../../../resources/common/css/ax5gridMin.css">
</head>
<body>
<div id="member-apply-title-container">
    <span class="mem-apply-title">인력등록</span>
</div>
<%--<div class="option-btn-container">--%>
<%--    <button id="group_total">조직도에서찾기</button>--%>
<%--    <button id="project_member_total">목록으로 찾기</button>--%>
<%--</div>--%>

<div class="tab-container">
    <button class="tab-btn active" id="group_total" onclick="openTab(this)">조직도에서 찾기</button>
    <button class="tab-btn" id="project_member_total" onclick="openTab(this)">목록으로 찾기</button>
</div>

<div id="add-member-by-group">
    <div id="usergroup-memberList-content">
        <div id="jstree-container">
            <!-- jstree 내용을 위한 스크롤 가능한 영역 -->
            <div id="jstree-content">
                <div id="jstree"></div>
            </div>
            <input type="text" id="search" placeholder="검색..." />
        </div>
        <div id="memberList">
            <div class="memberList-title-area">
                <div>
                    <h3 id="selectedGroupName" class="group-name"></h3>
                </div>

                <button class="member-add-button">추가하기</button>
            </div>

            <div class="member-grid">
                <div style="position: relative;height:270px;" id="grid-parent">
                    <div data-ax5grid="groupmemGrid" data-ax5grid-config="{}" style="height: 100%;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="addedMembersList">
        <div class="memberList-title-area">
            <div>
                <h3 class="group-name">추가 인원</h3>
            </div>
            <div class="button-container">
                <button class="preStartSetButton">예정시작</button>
                <button class="preEndSetButton">예정종료</button>
                <button class="startSetButton">참여시작</button>
                <button class="reg-member-edit-button">편집</button>
                <button class="member-remove-button">제거하기</button>
                <button class="apply">적용하기</button>
            </div>
        </div>

        <div style="position: relative;height:200px;" id="grid-parent3">
            <div id="y-added-grid" data-ax5grid="added-grid" data-ax5grid-config="{}" style="height: 100%;"></div>
        </div>
    </div>
</div>


<div id="add-member-by-prjmem">
    <div id="prjmem_list">
        <div class="memberList-title-area">
            <div>
                <h3 class="group-name">프로젝트 인원</h3>
            </div>
            <div class="button-container">
                <button class="member-add-button">추가하기</button>
            </div>
        </div>


        <div style="position: relative;height:270px;" id="grid-parent5">
            <div data-ax5grid="prjmember-grid" data-ax5grid-config="{}" style="height: 100%;"></div>
        </div>
    </div>
    <div class="addedMembersList">
        <div class="memberList-title-area">
            <div>
                <h3 class="group-name">추가 인원</h3>
            </div>
            <div class="button-container">
                <button class="preStartSetButton">예정시작</button>
                <button class="preEndSetButton">예정종료</button>
                <button class="startSetButton">참여시작</button>
                <button class="reg-member-edit-button">편집</button>
                <button class="member-remove-button">제거하기</button>
                <button class="apply">적용하기</button>
            </div>
        </div>

        <div style="position: relative;height:200px;" id="grid-parent2">
            <!--<div class="y-added-grid"  data-ax5grid="added-grid" data-ax5grid-config="{}" style="height: 100%;"></div>-->
        </div>
    </div>
</div>
<script src="../../../resources/member/js/list.js"></script>
<script src="../../../resources/member/js/memberRegisterGrid.js"></script>
<script src="../../../resources/member/js/memberRegister.js"></script>

</body>
</html>
