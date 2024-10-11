<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.core"%>

<%@ include file="../project/projectHeader.jsp" %>

<link rel="stylesheet" href="../../../resources/project/css/list.css">

<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <!-- 검색 섹션 -->
        <div class="filter-section">
            <form id="project_search_form" action="#" method="post">
                상태
                <select id="stat_cd" name="stat_cd">
                    <option>전체</option>
                </select>
                <input type="text" name="prj_title" class="search-text" placeholder="프로젝트명을 검색하세요">
                <input type="submit" class="search" value="검색">
            </form>
            <div class="action-buttons">
                <a href="/projects/info?type=register" class="add-project">
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
            </tr>
            </thead>
            <tbody>
                <c:forEach items="${projectList}" var="list">
                    <tr>
                        <td><a href="/projects/dashboard"><c:out value="${list.prj_title}" /></a></td>
                        <td><c:out value="${list.project_status}" /></td>
                        <td>
                            <c:if test="${not empty list.projectManager}">
                                <c:forEach var="manager" items="${list.projectManager}">
                                    <c:out value="${manager.memNm}" />
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty list.projectManager}">
                                No Manager Assigned
                            </c:if>
                        </td>
                        <td><c:out value="${list.org}" /></td>
                        <c:if test="${list.st_dt != null}">
                            <td><c:out value="${list.st_dt}" /></td>
                        </c:if>
                        <c:if test="${list.st_dt == null}">
                            <td> - </td>
                        </c:if>
                        <c:if test="${list.end_dt != null}">
                            <td><c:out value="${list.end_dt}" /></td>
                        </c:if>
                        <c:if test="${list.end_dt == null}">
                            <td> - </td>
                        </c:if>
                        <td><progress id="bar01" value="<c:out value="${list.prg}" />" max="100"></progress> <c:out value="${list.prg}" />%</td>
                    </tr>
                </c:forEach>
                <tr>
                    <td><a href="/projects/dashboard">차세대 프로그램 구축</a></td>
                    <td><span class="status-label status-in-progress">진행중</span></td>
                    <td>PM01</td>
                    <td>SI개발1팀</td>
                    <td>2024-09-12</td>
                    <td>2024-09-13</td>
                    <td><progress id="bar00" value="30" max="100"></progress>&nbsp; 30%</td>
                </tr>
                <tr>
                    <td><a href="/projects/dashboard">B 프로젝트</a></td>
                    <td><span class="status-label status-completed">종료</span></td>
                    <td>PM02</td>
                    <td>SI개발1팀</td>
                    <td>2024-09-18</td>
                    <td>2024-09-18</td>
                    <td><progress id="bar02" value="100" max="100"></progress>&nbsp; 100%</td>
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
            <a href="#">&raquo;</a>
        </div>


    </div>
</main>

<script src="../../../resources/project/js/list.js"></script>

</body>
</html>
