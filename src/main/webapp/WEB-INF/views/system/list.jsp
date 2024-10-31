<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../common.jsp" %>
<link rel="stylesheet" href="../../../resources/system/css/list.css">

<!-- 콘텐츠 영역 -->
<main class="content" id="content">
  <div class="main_content">

    <div class="project-content">
      <div class="project-info">시스템 / 업무 관리</div>
    </div>

    <div class="all-container">

      <div class="left-section">

        <div class="btn-add-system">
          <button class="add-feat" onclick="system_register()">시스템 등록</button>
        </div>

        <table class="system-table">
          <tr>
            <td class="system-title">
              시스템명
            </td>
          </tr>
        </table>

      </div>


      <div class="right-section">

        <div class="system-content">
          <div class="system-info"></div>
          <div class="btn-modify-system">
            <button class="add-feat btn-sys-save" onclick="modify1()">저장</button>
            <button class="add-feat btn-sys-delete" onclick="delete1()">삭제</button>
          </div>
        </div>

        <table class="system-info-table">
          <tr>
            <td class="sys-info-title">
              시스템명
            </td>
            <td>
              <input type="text" class="sys-info-title-txt" name="" value="차세대 공공 프로젝트">
            </td>
          </tr>
          <tr>
            <td class="info-desc">
              설명
            </td>
            <td class="sys-info-desc" colspan="2">
              <textarea class="sys-info-desc-txt" name=""></textarea>
            </td>
          </tr>
        </table>

        <div class="system-content work">
          <div class="system-info-list">업무 목록</div>
          <div class="btn-modify-system">
            <button class="add-feat" onclick="register_work()">업무 등록</button>
            <button class="add-feat" onclick="delete2()">삭제</button>
          </div>
        </div>

        <div class="table-wrapper">
          <table class="submenu-list-table">
              <tr>
                <td class="submenu-list-bg">
                  <input type="checkbox" id="check-all" name="check-all">
                </td>
                <td class="submenu-list-bg">
                  업무명
                </td>
                <td class="submenu-list-bg">
                  설명
                </td>
              </tr>
          </table>
        </div>


        <div class="btn-save-work">
          <button class="add-feat btn-sys-save" onclick="modify1()">저장</button>
        </div>

        <table class="sub-info-table">
          <tr>
            <td class="sub-info-title">
              업무명
            </td>
            <td>
              <input type="text" class="sub-info-title-txt" name="" value="">
            </td>
          </tr>
          <tr>
            <td class="sub-info-desc">
              설명
            </td>
            <td colspan="2">
              <textarea class="sub-info-desc-txt" name=""></textarea>
            </td>
          </tr>
        </table>

      </div>

    </div>

  </div>
</main>

<script src="../../../resources/system/js/list.js"></script>
<%@ include file="../footer.jsp" %>
