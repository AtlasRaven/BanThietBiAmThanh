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
            /* RESET */
            body {
                font-family: Arial;
                background: #f5f5f5;
                margin: 0;
            }

            /* HEADER */
            .header {
                background: #d62828;
                padding: 15px 30px;
                display: flex;
                align-items: center;
                gap: 20px;
            }

            /* SEARCH WRAPPER (bao cả search + cart) */
            .search-wrapper {
                flex: 2;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 15px;
                background: rgba(255,255,255,0.2);
                padding: 8px 15px;
                border-radius: 40px;
            }

            /* SEARCH BOX */
            .search-box {
                flex: 1;
                display: flex;
                align-items: center;
                background: white;
                border-radius: 30px;
                padding: 5px;
                gap: 5px;
            }

            /* INPUT */
            .search {
                flex: 2;
                padding: 10px;
                border: none;
                outline: none;
            }

            /* PRICE */
            .price-input {
                width: 90px;
                padding: 8px;
                border: none;
                outline: none;
                background: #f5f5f5;
                border-radius: 5px;
            }

            /* SELECT */
            .sort-select {
                padding: 8px;
                border: none;
                background: #f5f5f5;
                border-radius: 5px;
            }

            /* BUTTON */
            .btn-search {
                background: #f39c12;
                border: none;
                padding: 10px 15px;
                color: white;
                cursor: pointer;
                border-radius: 20px;
            }

            /* CART ICON */
            .cart-icon a {
                background: #2ecc71;
                color: white;
                padding: 10px 15px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: bold;
                position: relative;
                display: inline-block;
            }

            /* SỐ LƯỢNG */
            .cart-count {
                position: absolute;
                top: -6px;
                right: -10px;
                background: red;
                color: white;
                font-size: 12px;
                padding: 3px 7px;
                border-radius: 50%;
            }

            /* input giá */
            .price-input {
                width: 90px;
                padding: 8px;
                border: none;
                outline: none;
                background: #f5f5f5;
                border-radius: 5px;
            }

            /* select */
            .sort-select {
                padding: 8px;
                border: none;
                background: #f5f5f5;
                border-radius: 5px;
            }

            /* nút search */
            .btn-search {
                background: #f39c12;
                border: none;
                padding: 10px 15px;
                color: white;
                cursor: pointer;
                border-radius: 20px;
                transition: 0.3s;
            }

            .btn-search:hover {
                background: #e67e22;
            }


            .search-box {
                margin: 0 auto;
            }

            .right {
                flex: 1;
            }
            /* MENU */
            .menu {
                background: #c1121f;
                padding: 10px 40px;
            }

            .menu a {
                color: white;
                margin-right: 15px;
                text-decoration: none;
                font-weight: bold;
            }
            .product-card {
                background: white;
                border-radius: 12px;
                padding: 10px;
                transition: 0.3s;
                cursor: pointer;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            }
            /* LAYOUT */
            .main {
                width: 95%;
                margin: auto;
                display: flex;
            }

            /* SIDEBAR */
            .sidebar {
                width: 230px;
                background: white;
                margin: 15px 10px;
                padding: 15px;
                border-radius: 10px;
            }

            .sidebar h3 {
                margin-bottom: 10px;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
            }

            .sidebar li {
                padding: 10px;
                border-bottom: 1px solid #eee;
                cursor: pointer;
                transition: 0.3s;
            }

            .sidebar li:hover {
                background: #f1f1f1;
                border-radius: 5px;
            }
            /* USER MENU */
            .user-menu {
                position: relative;
                display: inline-block;
            }

            /* BUTTON */
            .dropbtn {
                background: #3498db;
                padding: 8px 12px;
                border-radius: 20px;
                color: white;
                cursor: pointer;
                transition: 0.3s;
            }

            .dropbtn:hover {
                background: #2980b9;
            }

            /* DROPDOWN */
            .dropdown-content {
                position: absolute;
                right: 0;
                top: 120%;
                background: white;
                min-width: 180px;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);

                opacity: 0;
                transform: translateY(10px);
                pointer-events: none;
                transition: 0.3s;
            }

            /* ITEM */
            .dropdown-content a {
                display: block;
                padding: 10px;
                text-decoration: none;
                color: #333;
                transition: 0.2s;
            }

            .dropdown-content a:hover {
                background: #f5f5f5;
            }

            /* SHOW DROPDOWN */
            .user-menu:hover .dropdown-content {
                opacity: 1;
                transform: translateY(0);
                pointer-events: auto;
            }
            /* CONTENT */
            .content {
                flex: 1;
                margin: 10px;
            }

            /* BANNER */
            .banner img {
                width: 100%;
                height: 220px;
                object-fit: cover;
                border-radius: 10px;
                margin-bottom: 15px;
            }

            /* PRODUCT GRID */
            .product-list {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 15px;
            }

            /* CARD */
            .product-card {
                background: white;
                border-radius: 12px;
                padding: 10px;
                transition: 0.3s;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            .product-card img {
                width: 100%;
                height: 180px;
                object-fit: cover;
                border-radius: 8px;
            }
            .product-card a {
                text-decoration: none;
                color: black;
            }
            .product-name {
                font-weight: bold;
                margin: 8px 0;
            }

            .price {
                color: red;
                font-weight: bold;
            }

            .desc {
                font-size: 13px;
                color: gray;
                height: 40px;
                overflow: hidden;
            }

            /* ADMIN */
            .admin-actions {
                display: flex;
                gap: 10px;
                margin-top: 10px;
            }

            .btn-edit {
                flex: 1;
                background: orange;
                color: white;
                text-align: center;
                padding: 6px;
                border-radius: 5px;
                text-decoration: none;
            }

            .btn-delete {
                flex: 1;
                background: red;
                color: white;
                text-align: center;
                padding: 6px;
                border-radius: 5px;
                text-decoration: none;
            }

            /* ADD BUTTON */
            .btn-add {
                background: #2ecc71;
                color: white;
                padding: 10px 15px;
                border-radius: 6px;
                text-decoration: none;
            }

            /* TOP BAR */
            .top-bar {
                position: fixed;
                top: 15px;
                right: 20px;
                z-index: 1000;
            }
            .btn-add-sidebar {
                display: block;
                background: #2ecc71;
                color: white;
                text-align: center;
                padding: 10px;
                border-radius: 8px;
                margin-bottom: 15px;
                text-decoration: none;
                font-weight: bold;
                transition: 0.3s;
            }

            .btn-add-sidebar:hover {
                background: #27ae60;
                transform: scale(1.05);
            }
            .search-box {
                display: flex;
                align-items: center;
                background: white;
                border-radius: 30px;
                overflow: hidden;
                padding: 5px;
                gap: 5px;
                width: 650px;
            }

            /* ô nhập chính */
            .search {
                flex: 2;
                padding: 10px;
                border: none;
                outline: none;
            }

            /* input giá */
            .price-input {
                width: 90px;
                padding: 8px;
                border: none;
                outline: none;
                background: #f5f5f5;
                border-radius: 5px;
            }

            /* select */
            .sort-select {
                padding: 8px;
                border: none;
                background: #f5f5f5;
                border-radius: 5px;
            }

            /* nút */
            .btn-search {
                background: #f39c12;
                border: none;
                padding: 10px 15px;
                color: white;
                cursor: pointer;
                border-radius: 20px;
                transition: 0.3s;
            }

            .btn-search:hover {
                background: #e67e22;
            }
            .contact-wrapper {
                position: relative;
                display: inline-block;
            }

            /* hộp thông tin */
            .contact-box {
                display: none;
                position: absolute;
                top: 25px;
                left: 0;

                width: 220px;
                background: white;
                border: 1px solid #ddd;
                padding: 10px;
                border-radius: 8px;

                box-shadow: 0 4px 10px rgba(0,0,0,0.2);
                z-index: 999;
            }

            /* hover vào là hiện */
            .contact-wrapper:hover .contact-box {
                display: block;
            }
            .cart {
                background: white;
                padding: 8px 15px;
                border-radius: 25px;
                text-decoration: none;
                color: #333;
                font-weight: bold;
                position: relative;
                transition: 0.3s;
            }

            .cart:hover {
                background: #f1f1f1;
            }

            .cart-count {
                background: red;
                color: white;
                font-size: 12px;
                padding: 3px 7px;
                border-radius: 50%;
                position: absolute;
                top: -5px;
                right: -5px;
            }


            /* LOGO bên trái */
            .logo {
                flex: 1;
                color: white;
                font-size: 20px;
                font-weight: bold;
            }

            /* WRAPPER ở giữa */


            /* SEARCH BOX */
            .search-box {
                display: flex;
                align-items: center;
                background: white;
                border-radius: 30px;
                padding: 5px;
                gap: 5px;
            }

            /* INPUT */
            .search {
                width: 220px;
                padding: 10px;
                border: none;
                outline: none;
            }

            /* PRICE */
            .price-input {
                width: 80px;
                padding: 8px;
                border: none;
                background: #f5f5f5;
                border-radius: 5px;
            }

            /* SELECT */
            .sort-select {
                padding: 8px;
                border: none;
                background: #f5f5f5;
                border-radius: 5px;
            }

            /* BUTTON */
            .btn-search {
                background: #f39c12;
                border: none;
                padding: 10px 15px;
                color: white;
                border-radius: 20px;
                cursor: pointer;
            }

            /* CART */
            .cart-icon a {
                background: #2ecc71;
                color: white;
                padding: 10px 15px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: bold;
                position: relative;
            }

            /* SỐ LƯỢNG */
            .cart-count {
                position: absolute;
                top: -6px;
                right: -10px;
                background: red;
                color: white;
                font-size: 12px;
                padding: 3px 7px;
                border-radius: 50%;
            }
        </style>
    </head>

    <body>

        <%
            String role = (String) session.getAttribute("role");
            NhanVien nv = (NhanVien) session.getAttribute("admin");
            String user = (String) session.getAttribute("user");
        %>
        <!-- HEADER -->
        <div class="header">

            <!-- LOGO -->
            <div class="logo">🛒 STORE THIẾT BỊ</div>

            <!-- SEARCH + CART (GIỮA) -->
            <div class="search-wrapper">

                <form action="searchSanPhamServlet" method="get" class="search-box">

                    <input type="text" name="keyword" class="search" placeholder="Tên / Mã sản phẩm...">

                    <input type="number" name="minPrice" placeholder="Từ giá" class="price-input">
                    <input type="number" name="maxPrice" placeholder="Đến giá" class="price-input">

                    <select name="sort" class="sort-select">
                        <option value="">Sắp xếp</option>
                        <option value="asc">Giá ↑</option>
                        <option value="desc">Giá ↓</option>
                    </select>

                    <button type="submit" class="btn-search">🔍</button>
                </form>

                <div class="cart-icon">
                    <a href="GioHangServlet">
                        🛒
                        <span class="cart-count">
                            <%= session.getAttribute("cartSize") != null ? session.getAttribute("cartSize") : 0%>
                        </span>
                    </a>
                </div>

            </div>

            <!-- PHẦN TRỐNG BÊN PHẢI -->
            <div style="flex:1;"></div>

        </div>
        <!-- MENU -->
        <div class="menu">
            <a href="InsertSanPham">TRANG CHỦ</a>
            <a href="#">GIỚI THIỆU</a>
            <a href="#">SẢN PHẨM</a>
            <a href="#">KHUYẾN MÃI</a>

            <!-- POPUP LIÊN HỆ -->
            <div class="contact-wrapper">
                <a href="#">Liên hệ</a>

                <div class="contact-box">
                    <h4>📞 Thông tin liên hệ</h4>
                    <p>🏢 Shop ABC</p>
                    <p>📍 Hà Nội</p>
                    <p>📱 0123 456 789</p>
                    <p>📧 shopabc@gmail.com</p>
                </div>
            </div>
        </div>
        <div class="main">
            <!-- SIDEBAR -->
            <div class="sidebar">
                <h3>DANH MỤC</h3>

                <% if ("admin".equals(role)) { %>
                <a href="ThemSanPhamServlet" class="btn-add-sidebar">
                    ➕ Thêm sản phẩm
                </a>
                <% } %>

                <ul>
                    <li><a href ="InsertSanPham">Trang chủ</a></li>
                    <li>Sản phẩm</li>
                    <li>Tìm theo hãng</li>
                    <li>Khuyến mãi</li>
                    <li>Liên hệ</li>
                </ul>
            </div>

            <!-- CONTENT -->
            <div class="content">

                <!-- BANNER -->
                <div class="banner">
                    <img src="images/banner.jpg" alt="">
                </div>



                <% if ("admin".equals(role)) { %>

                <% } %>
                <!-- TOP BAR -->
                <div class="top-bar">
                    <% if (role == null) { %>
                    <a href="login.jsp" class="btn-login">Đăng nhập</a>

                    <% } else if ("admin".equals(role)) {%>
                    <div class="user-menu">
                        <span class="dropbtn">👨‍💼 <%= nv.getTenNV()%> ▼</span>  
                        <div class="dropdown-content">
                            <a href="NhanVienServlet">Thông tin</a>
                            <a href="LogoutServlet">Đăng xuất</a>
                        </div>
                    </div>

                    <% } else {%>
                    <div class="user-menu">
                        <span class="dropbtn">👤 <%= user%> ▼</span>
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
                        <a href="ChiTietSanPham?maSP=<%= sp.getMaSP()%>">
                            <img src="images/<%= sp.getHinhAnh()%>" alt="">

                            <div class="product-name"><%= sp.getTenSP()%></div>
                            <div>Loại: <%= sp.getPhanLoai()%></div>

                            <div class="price">
                                Giá: <%= String.format("%,.0f", sp.getDonGia())%> VNĐ
                            </div>

                            <div>Số lượng: <%= sp.getSoLuong()%></div>
                            <div class="desc"><%= sp.getMoTa()%></div>
                        </a>

                        <% if ("admin".equals(role)) {%>
                        <div class="admin-actions">
                            <a href="SuaSanPhamServlet?maSP=<%= sp.getMaSP()%>" class="btn-edit">Sửa</a>
                            <a href="XoaSanPhamServlet?maSP=<%= sp.getMaSP()%>"
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
