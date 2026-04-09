<%@page import="model.KhachHang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin cá nhân</title>

        <style>
            body {
                font-family: Arial;
                background: #f5f5f5;
                margin: 0;
            }

            .container {
                width: 400px;
                margin: 80px auto;
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #333;
            }

            .info {
                margin: 15px 0;
                padding: 10px;
                border-bottom: 1px solid #eee;
            }

            .label {
                font-weight: bold;
                color: #555;
            }

            .value {
                color: #000;
            }

            .error {
                text-align: center;
                color: red;
                font-weight: bold;
            }

            .btn-back {
                display: block;
                text-align: center;
                margin-top: 20px;
                padding: 10px;
                background: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }

            .btn-back:hover {
                background: #2980b9;
            }
        </style>
    </head>
    <body>

        <%
            KhachHang kh = (KhachHang) request.getAttribute("kh");
            if (kh == null) {
        %>
        <p class="error">Không tìm thấy thông tin khách hàng!</p>
        <%
        } else {
        %>

        <div class="container">
            <h2>Thông tin cá nhân</h2>

            <div class="info">
                <span class="label">Tên:</span>
                <span class="value"><%= kh.getTenKH()%></span>
            </div>

            <div class="info">
                <span class="label">Email:</span>
                <span class="value"><%= kh.getEmail()%></span>
            </div>

            <div class="info">
                <span class="label">SĐT:</span>
                <span class="value"><%= kh.getSDT()%></span>
            </div>

            <div class="info">
                <span class="label">Địa chỉ:</span>
                <span class="value"><%= kh.getDiaChi()%></span>
            </div>

            <a href="InsertSanPham" class="btn-back">← Quay lại trang sản phẩm</a>
        </div>

        <%
            }
        %>

    </body>
</html>