<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    String title = (String) request.getAttribute("titleName");
    if (title != null && title.length() > 1) {
        request.setAttribute("title", title);
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KCC PMS</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
    <link rel="stylesheet" href="../../../resources/common/css/common.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.min.js"></script>
    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.min.js"></script>
    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-formatter/master/dist/ax5formatter.min.js"></script>
    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.min.js"></script>
    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-toast/master/dist/ax5toast.css" />
    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-toast/master/dist/ax5toast.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-calendar/master/dist/ax5calendar.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-picker/master/dist/ax5picker.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.css">

    <script src="../../../resources/output/js/jstree.js"></script>
</head>
<body>

<button class="toggle-btn" id="toggle-btn">
    <span class="arrow">←</span>
</button>

<!-- 헤더 -->
<%@ include file="header.jsp" %>

<!-- 왼쪽 메뉴 -->
<aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <a href="/projects/dashboard">
            <img src="../../resources/common/images/main_logo.png" alt="Project Logo">
        </a>
    </div>
    <ul class="menu">
        <li class="prj-all-list">
            <a href="/projects/list">
                전체 프로젝트 목록
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fas fa-box"></i><span>프로젝트</span>
                <i class="fas fa-chevron-down toggle-arrow"></i>
            </a>
            <ul class="submenu">
                <li><a href="/projects/dashboard"><span class="dot">•</span>대시보드</a></li>
                <li><a href="/projects/info?type=view"><span class="dot">•</span>프로젝트 정보</a></li>
                <li><a href="/projects/wbsList"><span class="dot">•</span>프로젝트 WBS</a></li>
                <li><a href="/projects/features"><span class="dot">•</span>프로젝트 기능</a></li>
                <li><a href="/systems/list"><span class="dot">•</span>시스템 / 업무 관리</a></li>
            </ul>
        </li>

        <li>
            <a href="#">
                <i class="fas fa-users"></i><span>인력</span>
                <i class="fas fa-chevron-down toggle-arrow"></i>
            </a>
            <ul class="submenu">
                <li><a href="#"><span class="dot">•</span>인력현황</a></li>
                <li><a href="/projects/members"><span class="dot">•</span>투입인력관리</a></li>
                <li><a href="#"><span class="dot">•</span>고객관리</a></li>
            </ul>
        </li>

        <li>
            <a href="#">
                <i class="fas fa-briefcase"></i><span>일반업무</span>
                <i class="fas fa-chevron-down toggle-arrow"></i>
            </a>
            <ul class="submenu">
                <li><a href="/projects/dangers"><span class="dot">•</span>위험 관리</a></li>
                <li><a href="/projects/issues"><span class="dot">•</span>이슈 관리</a></li>
                <li><a href="/projects/defects"><span class="dot">•</span>결함 관리</a></li>
                <li><a href="#"><span class="dot">•</span>요구사항 관리</a></li>
            </ul>
        </li>

        <li>
            <a href="#">
                <i class="fas fa-vial"></i><span>테스트</span>
                <i class="fas fa-chevron-down toggle-arrow"></i>
            </a>
            <ul class="submenu">
                <li><a href="/projects/tests"><span class="dot">•</span>테스트 관리</a></li>
            </ul>
        </li>

        <li>
            <a href="#">
                <i class="fas fa-comments"></i><span>커뮤니티</span>
                <i class="fas fa-chevron-down toggle-arrow"></i>
            </a>
            <ul class="submenu">
                <li><a href="#"><span class="dot">•</span>공지사항</a></li>
                <li><a href="#"><span class="dot">•</span>캘린더</a></li>
            </ul>
        </li>

    </ul>
</aside>
