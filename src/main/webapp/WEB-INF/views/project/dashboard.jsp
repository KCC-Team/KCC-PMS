<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>

<link rel="stylesheet" href="../../../resources/project/css/dashboard.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <div class="container">
            <!-- 작업목록 section  -->
            <div class="stats-section">
                <div class="stat-box">
                    <div class="stat-box-header">
                        <i class="fas fa-tasks"></i>
                        <div class="stat-box-content">
                            <h3 id="myWorkCount">10</h3>
                            <p>내 작업</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">View More <span class="arrow">&rarr;</span></a>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-box-header">
                        <i class="fa-solid fa-thumbtack"></i>
                        <div class="stat-box-content">
                            <h3 id="myIssueCount">2</h3>
                            <p>이슈</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">View More <span class="arrow">&rarr;</span></a>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-box-header">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        <div class="stat-box-content">
                            <h3 id="myDangerCount">0</h3>
                            <p>위험</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">View More <span class="arrow">&rarr;</span></a>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-box-header">
                        <i class="fas fa-vial"></i>
                        <div class="stat-box-content">
                            <h3 id="myDefectsCount">3</h3>
                            <p>결함</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">View More <span class="arrow">&rarr;</span></a>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-box-header">
                        <i class="fa-solid fa-file-lines"></i>
                        <div class="stat-box-content">
                            <h3 id="myOutputCount">5</h3>
                            <p>산출물</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">View More <span class="arrow">&rarr;</span></a>
                    </div>
                </div>
                <div class="stat-box">
                    <div class="stat-box-header">
                        <i class="fas fa-comments"></i>
                        <div class="stat-box-content">
                            <h3 id="myNoticeCount">3</h3>
                            <p>공지사항</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#">View More <span class="arrow">&rarr;</span></a>
                    </div>
                </div>
            </div>

            <!-- 프로젝트 정보 section -->
            <div class="project-info">
                <div class="project-details">
                    <div class="project-info-title">
                        <h2>프로젝트 정보</h2>
                        <div class="action-buttons">
<%--                            <span><a href="/projects/modify">수정</a></span>--%>
                        </div>
                    </div>
                    <div class="project-title">
                        <div class="label">차세대 프로그램 구축</div>
                    </div>
                    <div class="info-grid">
                        <div class="info">
                            <div class="label">시작일</div>
                            <div class="pj-date value">2024-06-10</div>
                        </div>
                        <div class="info">
                            <div class="label">종료일</div>
                            <div class="pj-date value">2024-06-20</div>
                        </div>
                        <div class="info progress-bar-complete">
                            <div class="label">완료율</div>
                            <div class="progress-bar">
                                <div class="progress" style="width: 30%;"></div>
                            </div>
                            <span class="value progress-bar-value">30%</span>
                        </div>
                        <div class="info">
                            <div class="label">PM</div>
                            <div class="value">pmo01</div>
                        </div>
                        <div class="info">
                            <div class="label">작업개수</div>
                            <div class="value">118 Tasks</div>
                        </div>
                        <div class="info">
                            <div class="label">참여인원 수</div>
                            <div class="value">4</div>
                        </div>
                        <div class="info">
                            <div class="label">상태</div>
                            <div class="value">진행중</div>
                        </div>
                        <div class="info">
                            <div class="label">주관기관</div>
                            <div class="value">병무청</div>
                        </div>
                    </div>
                </div>

                <div class="project-participation">
                    <div class="project-info-title">
                        <h2>프로젝트 참여자 정보</h2>
                    </div>
                    <table>
                        <thead>
                        <tr>
                            <th>참여자명</th>
                            <th>직급</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>PL01</td>
                            <td>차장</td>
                        </tr>
                        <tr>
                            <td>USER01</td>
                            <td>대리</td>
                        </tr>
                        <tr>
                            <td>USER02</td>
                            <td>대리</td>
                        </tr>
                        <tr>
                            <td>USER03</td>
                            <td>사원</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 차트 Section -->
            <div class="charts-section">

                <div class="chart">
                    <h3>작업 현황</h3>
                    <canvas id="taskStatusChart"></canvas>
                </div>
                <div class="chart">
                    <h3>이슈 현황</h3>
                    <canvas id="issueStatusChart"></canvas>
                </div>
                <div class="chart">
                    <h3>위험 현황</h3>
                    <canvas id="dangerStatusChart"></canvas>
                </div>
                <div class="chart">
                    <h3>결함 현황</h3>
                    <canvas id="defectsStatusChart"></canvas>
                </div>
            </div>

        </div>


    </div>
</main>

<script src="../../../resources/project/js/dashboard.js"></script>

<%@ include file="../footer.jsp" %>