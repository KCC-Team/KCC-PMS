<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KCC PMS Login</title>
    <link rel="stylesheet" href="../../resources/member/css/login.css">
</head>
<body>

<div class="login-container">
    <div class="login-left">
        <div class="login-image">
            <img src="../../resources/common/images/img_login_visual.jpg" alt="Login Image">
        </div>
    </div>

    <div class="login-box">
        <div class="login-content">
            <span class="logo-image"><img src="../../resources/common/images/main_logo2.png" alt="logo"></span>
            <h1><img src="../../resources/common/images/tit_login.png" alt="Login Image"></h1>
            <form action="/login" method="POST">
                <div class="input-group">
                    <input type="text" name="username" placeholder="아이디" required>
                </div>
                <div class="input-group">
                    <input type="password" name="password" placeholder="패스워드" required>
                </div>
                <button type="submit" class="login-btn">로그인</button>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>
        </div>
    </div>
</div>
</body>
</html>
