<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký</title>

    <style>
        body {
            font-family: Arial;
            background: #f5f5f5;
        }

        .register-box {
            width: 400px;
            margin: 80px auto;
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
            margin: 8px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            width: 100%;
            padding: 10px;
            background: green;
            color: white;
            border: none;
            border-radius: 5px;
        }

        .error {
            color: red;
            text-align: center;
        }

        .success {
            color: green;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="register-box">
    <h2>Đăng ký khách hàng</h2>

    <%
        String msg = (String) request.getAttribute("msg");
        if (msg != null) {
    %>
        <p class="success"><%= msg %></p>
    <%
        }
    %>

    <form action="RegisterServlet" method="post">
        <input type="text" name="MaKH" placeholder="Mã khách hàng" required>
        <input type="text" name="TenKH" placeholder="Tên khách hàng" required>
        <input type="text" name="SDT" placeholder="Số điện thoại" required>
        <input type="email" name="Email" placeholder="Email" required>
        <input type="text" name="DiaChi" placeholder="Địa chỉ" required>
        <input type="text" name="MatKhau" placeholder="Mật Khẩu" required>
        <button type="submit">Đăng ký</button>
    </form>
</div>

</body>
</html>