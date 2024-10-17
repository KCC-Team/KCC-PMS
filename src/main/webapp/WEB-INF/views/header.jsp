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

    String prjTitle = "차세대 공공 프로젝트";
    if ((String) session.getAttribute("prjTitle") != null) {
        prjTitle = (String) session.getAttribute("prjTitle");
    }

    Object prjNo = session.getAttribute("prjNo");
    Integer prjNoInt = null;
    if (prjNo instanceof Integer) {
        prjNoInt = (Integer) prjNo;
    }
%>

<script type="text/javascript">
    var prjTitle = '<%= prjTitle != null ? prjTitle : "" %>';
    var prjNo = '<%= prjNoInt != null ? prjNoInt.toString() : "" %>';
</script>

<!-- header -->
<header class="header">
    <div class="header-content">
        <% if (!projectTitle.isEmpty()) { %>
        <span><%=projectTitle%></span>
        <% } else { %>
        <div class="dropdown header-project-name">
            <a class="btn dropdown-toggle common-project-title fw-bold" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <%=prjTitle%>
            </a>
            <ul class="dropdown-menu ul-prj-title">
            </ul>
        </div>
        <% } %>
    </div>
    <div class="header-icons">
        <a href="/outputs"><i class="fa-solid fa-folder-open"></i></a>     <!-- 폴더 아이콘 -->
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