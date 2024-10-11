<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String uri = request.getRequestURI();
    String project_type = request.getParameter("type");
    boolean isProjectRegister = uri.contains("/project/info.jsp");
    boolean isProjectList = uri.contains("/project/list.jsp");

    String projectTitle = "";
    if (isProjectRegister && project_type.equals("register")) {
        projectTitle = "프로젝트 등록";
    }
    if (isProjectList) {
        projectTitle = "프로젝트 현황";
    }
%>

<!-- header -->
<header class="header">
    <div class="header-content">
        <% if (!projectTitle.isEmpty()) { %>
            <span><%=projectTitle%></span>
        <% } else { %>
            <div class="dropdown header-project-name">
                <a class="btn dropdown-toggle project-title fw-bold" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    차세대 프로그램 구축
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" onclick="#">B 프로젝트</a></li>
                    <li><a class="dropdown-item" href="#" onclick="#">C 프로젝트</a></li>
                </ul>
            </div>
        <% } %>
    </div>
    <div class="header-icons">
        <a href="/outputs/list"><i class="fa-solid fa-folder-open"></i></a>     <!-- 폴더 아이콘 -->
        <i class="fas fa-bell"></i>                 <!-- 알림 아이콘 -->
        <i class="fa-regular fa-envelope"></i>      <!-- 이메일 메뉴 아이콘 -->
        <div class="dropdown header-user-name">
            <a class="btn dropdown-toggle project-user-name" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                홍길동 주임
            </a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">내 정보</a></li>
                <li><a class="dropdown-item" href="#">로그아웃</a></li>
            </ul>
        </div>
    </div>
</header>