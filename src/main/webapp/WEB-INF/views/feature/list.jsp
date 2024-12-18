<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<link rel="stylesheet" href="../../../resources/feature/css/featureList.css">
<link rel="stylesheet" href="../../../resources/common/css/ax5grid.css">
<%--<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>--%>
<script src="../../../resources/feature/js/circle-progress.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <div class="project-content">
            <div class="project-info">프로젝트 기능 관리</div>
            <div class="btn-add-feat">
                <button class="add-feat" onclick="openFeaturePopup()">기능등록</button>
            </div>
        </div>

        <div class="all-container">

            <div class="left-section">

                <div class="feat_content first">
                    <div class="project-title">차세대 공공 프로젝트</div>
                    <div class="feat-all-chart">
                        <div class="circle">
                            <strong class="circle_strong">라벨</strong>
                        </div>
                    </div>
                </div>


                <div id="system-container">

                </div>

                <div id="pagination" class="pagination">
                    <span id="page-numbers"></span> <!-- 여기에 동적으로 페이지 번호와 내비게이션 버튼을 삽입 -->
                </div>
            </div>


            <div class="middle-section">
                <div class="feat_content">
                    <div class="feat-info-title">기능별 진척도</div>
                </div>

                <div class="feat-search-section">
                    <input type="hidden" id="systemNo" name="systemNo">
                    <div class="system-select-wrapper">
                        <span class="system-select-button" id="system-select">
                            <span>시스템/업무 선택</span>
                        </span>
                        <!-- 메뉴 리스트 -->
                        <ul class="mymenu" id="system-menu"></ul>
                    </div>
                    <select id="featClassOption" class="feat-select-option" name="feat-option3">
                        <option value="">전체분류</option>
                    </select>
                </div>

                <div class="row-info">
                    <div id="midSystemFeatureTitle" class="feat-title">차세대 공공 프로젝트 - (전체)</div>
                    <div class="prg-bar">
                        <progress id="midFeatBar" class="feat-bar" value="35" max="100"></progress><span id="midFPrgVal" class="prg-val">35%</span>
                    </div>
                    <div class="feat-total">
                        <span id="midTotalCnt" class="feat-total-cnt">15</span><span class="total-name">건 - </span>
                        <span class="total-name">(</span>
                        <span id="midCompleteCnt" class="feat-complete-cnt">8</span>
                        <span class="total-name">건 완료, </span>
                        <span id="midContinueCnt" class="feat-continue-cnt">7</span><span class="total-name">건 진행중, </span>
                        <span id="midDelayCnt" class="feat-continue-cnt">2</span><span class="total-name">건 지연)</span>
                    </div>
                </div>

                <form class="feat-search-form" id="feat_team_form" action="#" method="post">
                    <select id="featStatusOption" class="feat-select-option" name="feat-option5">
                        <option value="">전체</option>
                    </select>
                    <input id="midSearchBar" type="text" class="search-text" name="" value="" placeholder=" 작업자명 검색...">
                    <button id="featureSearch" type="submit" class="feat-submit-btn">검색</button>
                </form>

                <div style="position: relative;height:100%; width: 98%;" id="grid-parent">
                    <div class="list_table" data-ax5grid="first-grid"  data-ax5grid-config="{
                        header: {
                            columnHeight: 40
                        },
                        body: {
                            columnHeight: 40
                        }
                        }" style="height: 470px; width: 100%;">
                    </div>
                </div>

            </div>


            <div class="right-section">
                <div class="feat_content">
                    <div class="feat-info-title">작업자별 진척도</div>
                </div>
                <form class="feat-search-form" id="feat_user_form" action="#" method="post">
                    <input id="memberSearchBar" type="text" class="search-text" name="" value="" placeholder="팀명 혹은 작업자 명 검색...">
                    <button id="memberSearch" type="submit" class="feat-submit-btn">검색</button>
                </form>

                <div class="list_table" data-ax5grid="member-grid"  data-ax5grid-config="{
                        header: {
                            columnHeight: 40
                        },
                        body: {
                            columnHeight: 40
                        }
                        }" style="height: 280px; width: 100%;">
                </div>

                <div class="feat_content delay">
                    <div class="feat-info-title">지연목록</div>
                </div>

                <div id="delay">
                    <!-- 지연목록 grid 구현-->
                    <div class="list_table" data-ax5grid="delay-grid"  data-ax5grid-config="{
                        header: {
                            columnHeight: 40
                        },
                        body: {
                            columnHeight: 40
                        }
                        }" style="height: 280px; width: 100%;">
                    </div>
                </div>
            </div>
            <!-- 모달 구조 -->
            <div id="memberFeatureModal" class="modal" style="display: none;">
                <div class="modal-content">
                    <span class="close-btn" onclick="closeModal()">&times;</span>
                    <span class="modal-title" id="modalMemberName"></span>

                    <div class="member-prg-bar-container">
                        <progress id="memberFeatBar" class="member-prg-bar" value="" max="100"></progress>
                        <span id="memberPrgVal" class="prg-val"></span>
                    </div>

                    <div class="chart-container">
                        <canvas id="difficultyChart"></canvas>
                        <canvas id="statusChart"></canvas>
                        <canvas id="priorityChart"></canvas>
                        <canvas id="classificationChart"></canvas>
                    </div>

                    <div data-ax5grid="feature-grid" data-ax5grid-config="{
                        header: {
                            columnHeight: 40
                        },
                        body: {
                            columnHeight: 40
                        }
                        }" style="height: 400px; width: 100%;">
                    </div>
                </div>
            </div>

        </div>
    </div>
</main>
<script src="../../../resources/feature/js/list.js"></script>
<%@ include file="../footer.jsp" %>