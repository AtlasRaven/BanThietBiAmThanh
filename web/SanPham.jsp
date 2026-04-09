<%@page import="java.util.List"%>
<%@page import="model.SanPham"%>
<%@page import="model.NhanVien"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>

    <style>
        body {
            font-family: Arial;
            background: #f5f5f5;
            margin: 0;
        }

        .container {
            width: 90%;
            margin: auto;
        }

        h2 {
            text-align: center;
        }

        /* TOP BAR */
        .top-bar {
            position: absolute;
            top: 10px;
            right: 20px;
        }

        .btn-login {
            background: #3498db;
            padding: 8px 12px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
        }

        /* USER MENU */
        .user-menu {
            position: relative;
            display: inline-block;
        }

        .dropbtn {
            background: #3498db;
            padding: 8px 12px;
            border-radius: 5px;
            color: white;
            cursor: pointer;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background: white;
            min-width: 180px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            border-radius: 5px;
        }

        .dropdown-content a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: black;
        }

        .dropdown-content a:hover {
            background: #f1f1f1;
        }

        .user-menu:hover .dropdown-content {
            display: block;
        }

        /* PRODUCT */
        .product-list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .product-card {
            background: white;
            border-radius: 10px;
            padding: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .product-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 8px;
        }

        .product-name {
            font-weight: bold;
            margin: 10px 0;
        }

        .price {
            color: red;
            font-weight: bold;
        }

        .desc {
            font-size: 13px;
            color: gray;
        }

        /* ADMIN BUTTON */
        .admin-actions {
            margin-top: 10px;
            display: flex;
            gap: 10px;
        }

        .btn-edit {
            flex: 1;
            text-align: center;
            padding: 6px;
            background: orange;
            color: white;
            border-radius: 5px;
            text-decoration: none;
        }

        .btn-delete {
            flex: 1;
            text-align: center;
            padding: 6px;
            background: red;
            color: white;
            border-radius: 5px;
            text-decoration: none;
        }

        .btn-edit:hover {
            background: darkorange;
        }

        .btn-delete:hover {
            background: darkred;
        }
    </style>
</head>

<body>

<%
    String role = (String) session.getAttribute("role");
    NhanVien nv = (NhanVien) session.getAttribute("admin");
    String user = (String) session.getAttribute("user");
%>

<div class="container">
    <h2>Danh sách sản phẩm</h2>

    <!-- TOP BAR -->
    <div class="top-bar">
        <% if (role == null) { %>
            <a href="login.jsp" class="btn-login">Đăng nhập</a>

        <% } else if ("admin".equals(role)) { %>
            <div class="user-menu">
                <span class="dropbtn">👨‍💼 <%= nv.getTenNV() %> ▼</span>
                <div class="dropdown-content">
                    <a href="NhanVienServlet">Thông tin</a>
                    <a href="LogoutServlet">Đăng xuất</a>
                </div>
            </div>

        <% } else { %>
            <div class="user-menu">
                <span class="dropbtn">👤 <%= user %> ▼</span>
                <div class="dropdown-content">
                    <a href="KhachHangServlet">Thông tin cá nhân</a>
                    <a href="LogoutServlet">Đăng xuất</a>
                </div>
            </div>
        <% } %>
    </div>

    <!-- PRODUCT LIST -->
    <div class="product-list">
        <%
            List<SanPham> list = (List<SanPham>) request.getAttribute("ListSP");
            if (list != null) {
                for (SanPham sp : list) {
        %>

        <div class="product-card">
            <a href="ChiTietSanPham?maSP=<%= sp.getMaSP() %>">
                <img src="images/<%= sp.getHinhAnh() %>" alt="">

                <div class="product-name"><%= sp.getTenSP() %></div>
                <div>Loại: <%= sp.getPhanLoai() %></div>

                <div class="price">
                    Giá: <%= String.format("%,.0f", sp.getDonGia()) %> VNĐ
                </div>

                <div>Số lượng: <%= sp.getSoLuong() %></div>
                <div class="desc"><%= sp.getMoTa() %></div>
            </a>

            <% if ("admin".equals(role)) { %>
            <div class="admin-actions">
                <a href="SuaSanPhamServlet?maSP=<%= sp.getMaSP() %>" class="btn-edit">Sửa</a>
                <a href="XoaSanPhamServlet?maSP=<%= sp.getMaSP() %>"
                   onclick="return confirm('Xóa sản phẩm này?')"
                   class="btn-delete">Xóa</a>
            </div>
            <% } %>
        </div>

        <%
                }
            }
        %>
    </div>
</div>

</body>
</html>