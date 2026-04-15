<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="model.SanPham"%>
<%@page import="model.NhanVien"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private String getImageFallback() {
        return "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='500' height='360'%3E%3Crect width='100%25' height='100%25' fill='%23e2e8f0'/%3E%3Ctext x='50%25' y='50%25' dominant-baseline='middle' text-anchor='middle' fill='%2364748b' font-size='26' font-family='Arial'%3ENo Image%3C/text%3E%3C/svg%3E";
    }

    private String resolveImagePath(String hinhAnh, String contextPath) {
        if (hinhAnh == null || hinhAnh.trim().isEmpty()) {
            return getImageFallback();
        }

        String value = hinhAnh.trim().replace("\\", "/");
        if (value.startsWith("http://") || value.startsWith("https://") || value.startsWith("data:")) {
            return value;
        }
        if (value.startsWith("/")) {
            return contextPath + value;
        }
        if (value.startsWith("images/")) {
            return contextPath + "/" + value;
        }
        if (value.contains("/")) {
            return contextPath + "/" + value;
        }
        return contextPath + "/images/" + value;
    }
%>

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
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .menu a {
                color: white;
                margin-right: 15px;
                text-decoration: none;
                font-weight: bold;
            }

            .chat-widget-btn {
                position: fixed;
                right: 22px;
                bottom: 20px;
                z-index: 9999;
                border: none;
                background: linear-gradient(135deg, #64748b 0%, #475569 100%);
                color: #fff;
                padding: 12px 16px;
                border-radius: 999px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.25);
            }

            .chat-widget-btn:hover {
                background: linear-gradient(135deg, #525f74 0%, #334155 100%);
            }

            .chat-widget-panel {
                position: fixed;
                right: 22px;
                bottom: 78px;
                width: 370px;
                height: 540px;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.25);
                overflow: hidden;
                z-index: 9999;
                display: none;
                border: 1px solid #e5e7eb;
            }

            .chat-widget-panel.active {
                display: block;
            }

            .chat-widget-panel iframe {
                width: 100%;
                height: 100%;
                border: none;
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
            .category-wrapper {
                position: relative;
                display: inline-block;
            }

            .category-box {
                display: none;
                position: absolute;
                top: 34px;
                left: 0;
                min-width: 220px;
                max-height: 300px;
                overflow-y: auto;
                background: white;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.2);
                z-index: 1000;
                padding: 8px 0;
            }

            .category-wrapper:hover .category-box {
                display: block;
            }

            .category-box a {
                display: block;
                padding: 8px 12px;
                color: #334155;
                text-decoration: none;
                font-weight: 600;
            }

            .category-box a:hover {
                background: #eef4ff;
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

            /* ===== Modern UI Override (giu nguyen bo cuc) ===== */
            :root {
                --bg: #eef1f5;
                --surface: #ffffff;
                --surface-soft: #f5f7fa;
                --text: #1f2937;
                --muted: #6b7280;
                --primary: #64748b;
                --primary-dark: #475569;
                --danger: #b91c1c;
                --success: #166534;
                --border: #d1d5db;
                --shadow-sm: 0 6px 18px rgba(15, 23, 42, 0.08);
                --shadow-md: 0 12px 30px rgba(15, 23, 42, 0.12);
            }

            body {
                font-family: "Segoe UI", Roboto, Arial, sans-serif;
                background: linear-gradient(180deg, #f4f6f8 0%, var(--bg) 45%);
                color: var(--text);
            }

            .header {
                position: sticky;
                top: 0;
                z-index: 1000;
                background: linear-gradient(135deg, #374151 0%, #4b5563 100%);
                backdrop-filter: blur(8px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.12);
                box-shadow: var(--shadow-sm);
            }

            .logo {
                color: #fff;
                font-weight: 700;
                letter-spacing: 0.3px;
            }

            .search-wrapper {
                background: rgba(255, 255, 255, 0.12);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 999px;
            }

            .search-box {
                border-radius: 999px;
                box-shadow: inset 0 0 0 1px #e2e8f0;
            }

            .search, .price-input, .sort-select {
                color: #1f2937;
            }

            .btn-search {
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                border-radius: 999px;
            }

            .btn-search:hover {
                background: linear-gradient(135deg, #525f74 0%, #374151 100%);
            }

            .cart-icon a {
                background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
                border-radius: 999px;
            }

            .menu {
                position: sticky;
                top: 74px;
                z-index: 999;
                background: linear-gradient(135deg, #4b5563 0%, #6b7280 100%);
                backdrop-filter: blur(6px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.12);
                box-shadow: var(--shadow-sm);
            }

            .menu a {
                color: #f8fafc;
                padding: 8px 10px;
                border-radius: 10px;
                margin-right: 6px;
                transition: 0.2s;
            }

            .menu a:hover {
                background: rgba(255, 255, 255, 0.12);
            }

            .main {
                width: min(1280px, 96%);
                gap: 12px;
                margin-top: 14px;
            }

            .sidebar {
                background: var(--surface);
                border: 1px solid var(--border);
                box-shadow: var(--shadow-sm);
                position: sticky;
                top: 130px;
                height: fit-content;
            }

            .sidebar h3 {
                margin-top: 2px;
                font-size: 18px;
            }

            .sidebar li {
                border-bottom: 1px solid #edf2f7;
                border-radius: 10px;
                color: #334155;
            }

            .sidebar li:hover {
                background: #eef4ff;
            }

            .content {
                margin-top: 15px;
            }

            .banner img {
                border-radius: 16px;
                box-shadow: var(--shadow-md);
                border: 1px solid var(--border);
            }

            .top-bar {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 12px;
            }

            .btn-login, .dropbtn {
                border-radius: 999px;
                box-shadow: var(--shadow-sm);
            }

            .product-list {
                gap: 18px;
            }

            .product-card {
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: 16px;
                box-shadow: var(--shadow-sm);
                overflow: hidden;
            }

            .product-card:hover {
                transform: translateY(-6px);
                box-shadow: var(--shadow-md);
            }

            .product-card img {
                border-radius: 12px;
                border: 1px solid #e6edf7;
            }

            .product-name {
                font-size: 16px;
                color: #0f172a;
            }

            .price {
                color: var(--danger);
            }

            .desc {
                color: var(--muted);
            }

            .btn-edit, .btn-delete, .btn-add, .btn-add-sidebar {
                border-radius: 10px;
                font-weight: 600;
            }

            .btn-add-sidebar {
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            }

            .contact-box {
                border: 1px solid var(--border);
                border-radius: 12px;
                box-shadow: var(--shadow-md);
            }

            @media (max-width: 1100px) {
                .product-list {
                    grid-template-columns: repeat(3, 1fr);
                }
            }

            @media (max-width: 900px) {
                .main {
                    flex-direction: column;
                }

                .sidebar {
                    width: auto;
                    position: static;
                }

                .menu {
                    top: 66px;
                    overflow-x: auto;
                    white-space: nowrap;
                }

                .product-list {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 600px) {
                .header {
                    padding: 12px;
                    gap: 10px;
                    flex-wrap: wrap;
                }

                .search-wrapper {
                    width: 100%;
                    border-radius: 16px;
                    padding: 8px;
                }

                .search-box {
                    flex-wrap: wrap;
                    border-radius: 14px;
                }

                .price-input, .sort-select {
                    width: calc(50% - 4px);
                }

                .product-list {
                    grid-template-columns: 1fr;
                }

                .chat-widget-panel {
                    width: calc(100vw - 20px);
                    right: 10px;
                    bottom: 72px;
                }

                .chat-widget-btn {
                    right: 10px;
                    bottom: 10px;
                }
            }
        </style>
    </head>

    <body>

        <%
            String role = (String) session.getAttribute("role");
            NhanVien nv = (NhanVien) session.getAttribute("admin");
            String user = (String) session.getAttribute("user");
            String keywordValue = (String) request.getAttribute("keyword");
            String minPriceValue = (String) request.getAttribute("minPrice");
            String maxPriceValue = (String) request.getAttribute("maxPrice");
            String sortValue = (String) request.getAttribute("sort");
            String selectedCategory = (String) request.getAttribute("selectedCategory");
            List<String> categoryList = (List<String>) request.getAttribute("categoryList");
        %>
        <!-- HEADER -->
        <div class="header">

            <!-- LOGO -->
            <div class="logo">🛒 STORE THIẾT BỊ</div>

            <!-- SEARCH + CART (GIỮA) -->
            <div class="search-wrapper">

                <form action="searchSanPhamServlet" method="get" class="search-box">

                    <input type="text" name="keyword" class="search" placeholder="Tên / Mã sản phẩm..." value="<%= keywordValue != null ? keywordValue : ""%>">

                    <input type="number" name="minPrice" placeholder="Từ giá" class="price-input" value="<%= minPriceValue != null ? minPriceValue : ""%>">
                    <input type="number" name="maxPrice" placeholder="Đến giá" class="price-input" value="<%= maxPriceValue != null ? maxPriceValue : ""%>">

                    <select name="category" class="sort-select">
                        <option value="">Phân loại</option>
                        <%
                            if (categoryList != null) {
                                for (String category : categoryList) {
                        %>
                        <option value="<%= category%>" <%= category.equals(selectedCategory) ? "selected" : ""%>><%= category%></option>
                        <%
                                }
                            }
                        %>
                    </select>

                    <select name="sort" class="sort-select">
                        <option value="" <%= sortValue == null || sortValue.isEmpty() ? "selected" : ""%>>Sắp xếp</option>
                        <option value="asc" <%= "asc".equals(sortValue) ? "selected" : ""%>>Giá ↑</option>
                        <option value="desc" <%= "desc".equals(sortValue) ? "selected" : ""%>>Giá ↓</option>
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
            <a href="GioiThieu.jsp">GIỚI THIỆU</a>
            <a hrf="">PHÂN LOẠI</a>
            <!-- POPUP LIÊN HỆ -->
            <div class="contact-wrapper">
                <a href="#">LIÊN HỆ </a>

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
                    <li><a href="InsertSanPham">Tất cả sản phẩm</a></li>
                        <%
                            if (categoryList != null) {
                                for (String category : categoryList) {
                        %>
                    <li><a href="searchSanPhamServlet?category=<%= URLEncoder.encode(category, "UTF-8")%>"><%= category%></a></li>
                        <%
                                }
                            }
                        %>
                    <li>Liên hệ</li>
                </ul>
            </div>

            <!-- CONTENT -->
            <div class="content">

                <!-- BANNER -->
                <div class="banner">
                    <img src="images/banner.svg" alt="">
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
                            <img src="<%= resolveImagePath(sp.getHinhAnh(), request.getContextPath())%>"
                                 onerror="this.onerror=null;this.src='<%= getImageFallback()%>';"
                                 alt="">

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

        <button type="button" id="chatWidgetBtn" class="chat-widget-btn">💬 Chat hỗ trợ</button>
        <div id="chatWidgetPanel" class="chat-widget-panel">
            <iframe src="Chat.jsp" title="Chatbot hỗ trợ"></iframe>
        </div>

        <script>
            const chatWidgetBtn = document.getElementById("chatWidgetBtn");
            const chatWidgetPanel = document.getElementById("chatWidgetPanel");

            chatWidgetBtn.addEventListener("click", () => {
                chatWidgetPanel.classList.toggle("active");
            });
        </script>
    </body>
</html>
