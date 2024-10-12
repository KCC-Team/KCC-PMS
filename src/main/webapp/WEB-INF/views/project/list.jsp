<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.core"%>

<%@ include file="../project/projectHeader.jsp" %>

<link rel="stylesheet" href="../../../resources/project/css/list.css">

<!-- 콘텐츠 영역 -->
<main class="content" id="content">
    <div class="main_content">

        <div class="filter-section">
            <form id="project_search_form" action="/projects/list" method="get">
                상태
                <select id="stat_cd" name="stat_cd">
                    <option value="all">전체</option>
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

        <table>
            <thead>
            <tr>
                <th>프로젝트</th>
                <th>상태</th>
                <th>PM</th>
                <th>주관기관</th>
                <th width="200px">시작일</th>
                <th width="200px">완료일</th>
                <th width="300px">진척도</th>
            </tr>
            </thead>
            <tbody>
                <c:if test="${empty projectList}">
                    <tr>
                        <td colspan="7">배정받은 프로젝트가 없습니다.</td>
                    </tr>
                </c:if>

                <c:if test="${not empty projectList}">
                    <c:forEach items="${projectList}" var="list">
                        <tr>
                            <td><a href="/projects/dashboard"><c:out value="${list.prj_no}" /><c:out value="${list.prj_title}" /></a></td>
                            <td>
                                <c:if test="${list.project_status == '대기'}">
                                    <span class="status-label status-in-wait">
                                            <c:out value="${list.project_status}" />
                                    </span>
                                </c:if>
                                <c:if test="${list.project_status == '진행중'}">
                                    <span class="status-label status-in-progress">
                                            <c:out value="${list.project_status}" />
                                    </span>
                                </c:if>
                                <c:if test="${list.project_status == '완료'}">
                                    <span class="status-label status-completed">
                                            <c:out value="${list.project_status}" />
                                    </span>
                                </c:if>
                            </td>
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
                </c:if>
            </tbody>
        </table>

        <div class="pull-right d-flex justify-content-center"
             aria-label="Page navigation example">
            <ul class="pagination">

                <c:if test="${pageMaker.prev}">
                    <li class="paginate_button page-item prev">
                        <a href="${pageMaker.startPage -1}" class="page-link">이전</a>
                    </li>
                </c:if>

                <br />

                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="paginate_button page-item ${pageMaker.cri.pageNum == num ? "active":""} ">
                        <a href="${num}" class="page-link">${num}</a>
                    </li>
                </c:forEach>

                <c:if test="${pageMaker.next}">
                    <li class="paginate_button page-item next">
                        <a href="${pageMaker.endPage + 1 }" class="page-link">다음</a>
                    </li>
                </c:if>

            </ul>
        </div>

        <form id='actionForm' action="/projects/list" method='get'>
            <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
            <input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
            <input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'>
            <input type='hidden' name='prj_title' value=''>
            <input type='hidden' name='stat_cd' value=''>
        </form>


    </div>
</main>

<script src="../../../resources/project/js/list.js"></script>

</body>
</html>
