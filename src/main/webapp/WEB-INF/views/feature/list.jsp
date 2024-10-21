<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<link rel="stylesheet" href="../../../resources/feature/css/featureList.css">

<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <div class="project-content">
            <div class="project-info">프로젝트 기능 관리</div>
        </div>

        <div class="feat_content">
            <div class="feat-info">진척률 현황</div>
            <div class="btn-add-feat">
                <button class="add-feat" onclick="openFeaturePopup()">기능등록</button>
            </div>
        </div>

        <div class="all-container">

            <div class="left-section">

                <div class="feat-info-row"> <!--해당 row 반복 -->
                    <div class="feat-title">전체</div>
                    <div class="prg-bar">
                        <progress id="all-bar" value="55" max="100"></progress><span class="prg-val">55%</span>
                    </div>
                    <div class="feat-total">
                        <span class="feat-total-cnt">15</span><span class="total-name">건 - </span>
                        <span class="total-name">(</span><span class="feat-complete-cnt">8</span><span class="total-name">건 완료 - </span>
                        <span class="feat-continue-cnt">7</span><span class="total-name">건 진행중)</span>
                    </div>
                </div>

                <div class="feat-info-row">
                    <div class="feat-title">A업무시스템</div>
                    <div class="prg-bar">
                        <progress class="feat-bar" value="35" max="100"></progress><span class="prg-val">35%</span>
                    </div>
                    <div class="feat-total">
                        <span class="feat-total-cnt">15</span><span class="total-name">건 - </span>
                        <span class="total-name">(</span><span class="feat-complete-cnt">8</span><span class="total-name">건 완료 - </span>
                        <span class="feat-continue-cnt">7</span><span class="total-name">건 진행중)</span>
                    </div>
                </div>

                <div class="feat-info-row">
                    <div class="feat-title">B업무시스템</div>
                    <div class="prg-bar">
                        <progress class="feat-bar" value="50" max="100"></progress><span class="prg-val">50%</span>
                    </div>
                    <div class="feat-total">
                        <span class="feat-total-cnt">15</span><span class="total-name">건 - </span>
                        <span class="total-name">(</span><span class="feat-complete-cnt">8</span><span class="total-name">건 완료 - </span>
                        <span class="feat-continue-cnt">7</span><span class="total-name">건 진행중)</span>
                    </div>
                </div>

                <div class="feat-info-row">
                    <div class="feat-title">C업무시스템</div>
                    <div class="prg-bar">
                        <progress class="feat-bar" value="20" max="100"></progress><span class="prg-val">20%</span>                    </div>
                    <div class="feat-total">
                        <span class="feat-total-cnt">15</span><span class="total-name">건 - </span>
                        <span class="total-name">(</span><span class="feat-complete-cnt">8</span><span class="total-name">건 완료 - </span>
                        <span class="feat-continue-cnt">7</span><span class="total-name">건 진행중)</span>
                    </div>
                </div>

            </div>

            <div class="right-section">
                <div class="feat-search-section">
                    <select class="feat-select-option" name="feat-user">
                        <option value="0">전체</option>
                        <option value="1">SI1팀-홍길동(개발자)</option>
                        <option value="2">SI2팀-김길동(개발자)</option>
                        <option value="3">SI2팀-강호동(개발자)</option>
                    </select>
                    <select class="feat-select-option" name="feat-option">
                        <option value="0">전체</option>
                        <option value="1">회면(기능)</option>
                    </select>
                </div>

                <div class="row-info">
                    <div class="feat-title">A업무시스템 - 화면 (홍길동)</div>
                    <div class="prg-bar">
                        <progress class="feat-bar" value="35" max="100"></progress><span class="prg-val">35%</span>
                    </div>
                    <div class="feat-total">
                        <span class="feat-total-cnt">15</span><span class="total-name">건 - </span>
                        <span class="total-name">(</span><span class="feat-complete-cnt">8</span><span class="total-name">건 완료 - </span>
                        <span class="feat-continue-cnt">7</span><span class="total-name">건 진행중)</span>
                    </div>
                </div>

                <table class="feat-info-table">
                    <tr class="tr-row">
                        <td>기능ID</td>
                        <td>기능명</td>
                        <td>상태</td>
                        <td>작업자</td>
                        <td>진척도</td>
                    </tr>
                    <tr>
                        <td>#1328</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>-</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>-</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>

                <div class="row-info">
                    <div class="feat-title">A업무시스템 - 화면 (홍길동)</div>
                    <div class="prg-bar">
                        <progress class="feat-bar" value="35" max="100"></progress><span class="prg-val">35%</span>
                    </div>
                    <div class="feat-total">
                        <span class="feat-total-cnt">15</span><span class="total-name">건 - </span>
                        <span class="total-name">(</span><span class="feat-complete-cnt">8</span><span class="total-name">건 완료 - </span>
                        <span class="feat-continue-cnt">7</span><span class="total-name">건 진행중)</span>
                    </div>
                </div>

                <table class="feat-info-table">
                    <tr class="tr-row">
                        <td>기능ID</td>
                        <td>기능명</td>
                        <td>상태</td>
                        <td>작업자</td>
                        <td>진척도</td>
                    </tr>
                    <tr>
                        <td>#1328</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>-</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>-</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>

            </div>
        </div>


    </div>
</main>
<script src="../../../resources/feature/js/list.js"></script>
<%@ include file="../footer.jsp" %>