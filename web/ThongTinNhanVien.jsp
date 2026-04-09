<%@page import="model.NhanVien"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    NhanVien nv = (NhanVien) request.getAttribute("nv");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin nhân viên</title>

        <style>
            body {
                font-family: Arial;
                background: #f5f5f5;
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
            }

            .info {
                margin: 10px 0;
                padding: 10px;
                border-bottom: 1px solid #eee;
            }

            .btn-back {
                display: block;
                margin-top: 20px;
                text-align: center;
                background: #3498db;
                color: white;
                padding: 10px;
                border-radius: 5px;
                text-decoration: none;
            }
        </style>
    </head>

    <body>

        <% if (nv == null) { %>
        <p>Không có dữ liệu nhân viên</p>
        <% } else {%>

        <div class="container">
            <h2>Thông tin nhân viên</h2>

            <div class="info">Mã NV: <%= nv.getMaNV()%></div>
            <div class="info">Tên NV: <%= nv.getTenNV()%></div>
            <div class="info">Chức vụ: <%= nv.getChucVu()%></div>
            <div class="info">Tài khoản: <%= nv.getTaiKhoan()%></div>

            <a href="InsertSanPham" class="btn-back">← Quay lại</a>
        </div>

        <% }%>

    </body>
</html>