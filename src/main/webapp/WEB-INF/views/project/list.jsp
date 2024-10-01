<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String title = "프로젝트 현황";
    request.setAttribute("title", title);
%>

<%@ include file="../project/projectHeader.jsp" %>

<link rel="stylesheet" href="../../../resources/project/css/list.css">

<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <!-- 검색 섹션 -->
        <div class="filter-section">
            <form action="#" method="post">
                상태
                <select name="status">
                    <option>전체</option>
                    <option value="1">진행중</option>
                    <option value="2">종료</option>
                </select>
                주관기관
                <select name="organization">
                    <option>전체</option>
                    <option value="1">병무청</option>
                    <option value="2">코레일</option>
                </select>
                <input type="text" name="title" class="search-text" placeholder="프로젝트명을 검색하세요">
                <input type="submit" class="search" value="검색">
            </form>
            <div class="action-buttons">
                <a href="/project/register" class="add-project">
                    <button class="add-project">+ 프로젝트 등록</button>
                </a>
            </div>
        </div>

        <!-- 리스트 섹션 -->
        <table>
            <thead>
            <tr>
                <th>프로젝트</th>
                <th>상태</th>
                <th>PM</th>
                <th>주관기관</th>
                <th>시작일</th>
                <th>완료일</th>
                <th>진척도</th>
                <th>이슈</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><a href="/project/dashboard">차세대 프로그램 구축</a></td>
                <td><span class="status-label status-in-progress">진행중</span></td>
                <td>PM01</td>
                <td>SI개발1팀</td>
                <td>2024-09-12</td>
                <td>2024-09-13</td>
                <td><progress id="bar01" value="30" max="100"></progress>&nbsp; 30%</td>
                <td>1</td>
            </tr>
            <tr>
                <td><a href="/project/dashboard">B 프로젝트</a></td>
                <td><span class="status-label status-completed">종료</span></td>
                <td>PM02</td>
                <td>SI개발1팀</td>
                <td>2024-09-18</td>
                <td>2024-09-18</td>
                <td><progress id="bar02" value="100" max="100"></progress>&nbsp; 100%</td>
                <td>0</td>
            </tr>
            <tr>
                <td><a href="/project/dashboard">C 프로젝트</a></td>
                <td><span class="status-label status-completed">종료</span></td>
                <td>PM03</td>
                <td>SI개발2팀</td>
                <td>2024-09-19</td>
                <td>2024-09-19</td>
                <td><progress id="bar03" value="100" max="100"></progress>&nbsp; 100%</td>
                <td>0</td>
            </tr>
            </tbody>
        </table>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <a href="#" >&laquo;</a>
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">6</a>
            <a href="#">&raquo;</a>
        </div>


    </div>
</main>

<script src="../../../resources/project/js/list.js"></script>

</body>
</html>
