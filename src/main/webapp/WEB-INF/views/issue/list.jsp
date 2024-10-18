<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>
<link rel="stylesheet" href="../../../resources/danger/css/danger.css">
<link rel="stylesheet" href="../../../resources/danger/css/ax5grid.css">

<main class="content" id="content">
    <div class="main_content">
        <div class="issue-content">
            <div class="issue-info">이슈현황</div>
        </div>

        <div class="filter-section">
            <form action="#" method="post" enctype="multipart/form-data">
                상태
                <select name="status">
                    <option>전체</option>
                    <option value="1">발생전</option>
                    <option value="2">진행</option>
                    <option value="3">종료</option>
                </select>
                <input type="text" name="title" class="search-text" placeholder="이슈명을 검색하세요">
                <input type="submit" class="search" value="검색">
            </form>
            <div class="action-buttons">
                <a href="/projects/issueInfo?type=register">
                    <button class="add-project">+ 이슈등록</button>
                </a>
                <a href="#">
                    <button class="danger-export-excel"><i class="fa-solid fa-download"></i> 액셀받기</button>
                </a>
            </div>
        </div>

        <div style="position: relative;height:100%; width: 90%;" id="grid-parent">
            <!-- 위험 목록 테이블 -->
            <div class="list_table" data-ax5grid="first-grid"  data-ax5grid-config="{
                sortable: true,
                header: {
                    columnHeight: 50
                },
                body: {
                    columnHeight: 50
                }
            }" style="height: 600px; width: 97%;">
            </div>
        </div>
    </div>
</main>

<script src="../../../resources/issue/js/list.js"></script>

<%@ include file="../footer.jsp" %>