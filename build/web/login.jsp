<%-- 
    Document   : LogIn
    Created on : Apr 7, 2026, 1:11:33 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <style>
            body {
                font-family: Arial;
                background: #f5f5f5;
            }

            .login-box {
                width: 350px;
                margin: 100px auto;
                padding: 25px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
            }

            input {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            button {
                width: 100%;
                padding: 10px;
                background: #3498db;
                color: white;
                border: none;
                border-radius: 5px;
            }

            button:hover {
                background: #2980b9;
            }

            .error {
                color: red;
                text-align: center;
            }

            .back {
                text-align: center;
                margin-top: 10px;
            }
            .register-link {
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
            }

            .register-link a {
                color: #3498db;
                text-decoration: none;
                font-weight: bold;
            }

            .register-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
<body>

    <div class="login-box">
        <h2>Đăng nhập</h2>

        <!-- Hiển thị lỗi -->
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <p class="error"><%= error%></p>
        <%
            }
        %>

        <form action="LoginServlet" method="post">
            <input type="text" name="user" placeholder="Mã Khách Hàng" required>
            <input type="password" name="pass" placeholder="Mật khẩu" required>

            <button type="submit">Đăng nhập</button>
        </form>

        <div class="back">
            <a href="InsertSanPham">⬅ Quay lại trang sản phẩm</a>
        </div>
        <div class="register-link">
            Chưa có tài khoản? 
            <a href="Register.jsp">Đăng ký ngay</a>
        </div>
    </div>

</body>
</html>
</body>
</html>
