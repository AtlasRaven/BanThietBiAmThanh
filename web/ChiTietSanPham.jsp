<%-- 
    Document   : ChiTietSanPham
    Created on : Apr 8, 2026, 7:59:47 AM
    Author     : ASUS
--%>
<%@page import="java.util.List"%>
<%@page import="model.SanPham"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    private String getImageFallback() {
        return "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='700' height='520'%3E%3Crect width='100%25' height='100%25' fill='%23e2e8f0'/%3E%3Ctext x='50%25' y='50%25' dominant-baseline='middle' text-anchor='middle' fill='%2364748b' font-size='30' font-family='Arial'%3ENo Image%3C/text%3E%3C/svg%3E";
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
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Chi tiết sản phẩm</title>
        <style>
            :root {
                --bg: #eef1f5;
                --surface: #ffffff;
                --text: #1f2937;
                --muted: #6b7280;
                --primary: #64748b;
                --primary-dark: #475569;
                --primary-light: #94a3b8;
                --danger: #b91c1c;
                --border: #d1d5db;
                --shadow-sm: 0 6px 18px rgba(15, 23, 42, 0.08);
                --shadow-md: 0 12px 30px rgba(15, 23, 42, 0.12);
                --shadow-float: 0 24px 48px rgba(15, 23, 42, 0.18);
                --shadow-hover: 0 20px 40px rgba(15, 23, 42, 0.15);
                --ease-out: cubic-bezier(0.22, 1, 0.36, 1);
                --ease-spring: cubic-bezier(0.34, 1.56, 0.64, 1);
                --dur-fast: 0.18s;
                --dur: 0.35s;
                --dur-slow: 0.55s;
            }

            *, *::before, *::after {
                box-sizing: border-box;
            }

            body {
                font-family: "Segoe UI", Roboto, Arial, sans-serif;
                margin: 0;
                min-height: 100vh;
                background: linear-gradient(180deg, #f4f6f8 0%, var(--bg) 45%);
                color: var(--text);
                opacity: 0;
                animation: pageIn var(--dur-slow) var(--ease-out) forwards;
            }

            @keyframes pageIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }

            @media (prefers-reduced-motion: reduce) {
                *, *::before, *::after {
                    animation-duration: 0.01ms !important;
                    animation-iteration-count: 1 !important;
                    transition-duration: 0.01ms !important;
                }
                body { animation: none; opacity: 1; }
            }

            /* ----- Header ----- */
            .header {
                position: sticky;
                top: 0;
                z-index: 1000;
                background: linear-gradient(135deg, #374151 0%, #4b5563 100%);
                backdrop-filter: blur(10px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.12);
                box-shadow: var(--shadow-sm);
                padding: 15px 30px;
                display: flex;
                align-items: center;
                gap: 20px;
                transform: translateY(-100%);
                animation: headerSlide var(--dur-slow) var(--ease-out) forwards;
            }

            @keyframes headerSlide {
                to { transform: translateY(0); }
            }

            .logo {
                flex: 1;
                color: #fff;
                font-size: 20px;
                font-weight: 700;
                letter-spacing: 0.3px;
                transition: transform var(--dur) var(--ease-out), filter var(--dur);
            }

            .logo:hover {
                transform: scale(1.02);
                filter: brightness(1.08);
            }

            .search-wrapper {
                flex: 2;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 15px;
                background: rgba(255, 255, 255, 0.12);
                border: 1px solid rgba(255, 255, 255, 0.2);
                padding: 8px 15px;
                border-radius: 999px;
                transition: background var(--dur) var(--ease-out), box-shadow var(--dur), transform var(--dur);
            }

            .search-wrapper:hover {
                background: rgba(255, 255, 255, 0.18);
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.12);
            }

            .search-box {
                flex: 1;
                display: flex;
                align-items: center;
                background: white;
                border-radius: 999px;
                padding: 5px;
                gap: 5px;
                box-shadow: inset 0 0 0 1px #e2e8f0;
                transition: box-shadow var(--dur) var(--ease-out);
            }

            .search-box:focus-within {
                box-shadow: inset 0 0 0 2px var(--primary-light), 0 0 0 3px rgba(148, 163, 184, 0.35);
            }

            .search {
                flex: 2;
                padding: 10px;
                border: none;
                outline: none;
                color: #1f2937;
                transition: color var(--dur-fast);
            }

            .price-input,
            .sort-select {
                transition: background var(--dur-fast), transform var(--dur-fast), box-shadow var(--dur-fast);
            }

            .price-input {
                width: 90px;
                padding: 8px;
                border: none;
                outline: none;
                background: #f5f5f5;
                border-radius: 8px;
                color: #1f2937;
            }

            .price-input:hover,
            .sort-select:hover {
                background: #eef2f7;
            }

            .price-input:focus,
            .sort-select:focus {
                outline: none;
                box-shadow: 0 0 0 2px rgba(100, 116, 139, 0.45);
            }

            .sort-select {
                padding: 8px;
                border: none;
                background: #f5f5f5;
                border-radius: 8px;
                color: #1f2937;
                cursor: pointer;
            }

            .btn-search {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
                border: none;
                padding: 10px 16px;
                color: white;
                cursor: pointer;
                border-radius: 12px;
                transition: transform var(--dur-fast) var(--ease-spring), box-shadow var(--dur), filter var(--dur-fast), background var(--dur);
            }

            .btn-search:hover {
                background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
                transform: scale(1.06);
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
            }

            .btn-search:active {
                transform: scale(0.98);
            }

            .btn-search .btn-icon {
                font-size: 14px;
                line-height: 1;
            }

            .btn-search .btn-text {
                font-weight: 700;
                font-size: 13px;
                letter-spacing: 0.02em;
            }

            .cart-icon a {
                background: linear-gradient(135deg, #111827 0%, #1f2937 100%);
                color: white;
                padding: 10px 14px;
                border-radius: 12px;
                text-decoration: none;
                font-weight: bold;
                position: relative;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                border: 1px solid rgba(255, 255, 255, 0.2);
                transition: transform var(--dur-fast) var(--ease-spring), box-shadow var(--dur), filter var(--dur-fast);
            }

            .cart-icon a:hover {
                transform: translateY(-2px) scale(1.03);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.22);
                filter: brightness(1.1);
            }

            .cart-text {
                font-size: 13px;
                font-weight: 700;
                letter-spacing: 0.02em;
            }

            .cart-count {
                position: absolute;
                top: -6px;
                right: -10px;
                background: #b91c1c;
                color: white;
                font-size: 12px;
                padding: 3px 7px;
                border-radius: 50%;
                transition: transform var(--ease-spring) 0.2s;
            }

            .cart-icon a:hover .cart-count {
                transform: scale(1.15);
            }

            /* ----- Menu ----- */
            .menu {
                position: sticky;
                top: 62px;
                z-index: 999;
                background: linear-gradient(135deg, #4b5563 0%, #6b7280 100%);
                backdrop-filter: blur(6px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.12);
                box-shadow: var(--shadow-sm);
                padding: 10px 40px;
                display: flex;
                align-items: center;
                gap: 12px;
                opacity: 0;
                animation: fadeUp var(--dur-slow) var(--ease-out) 0.12s forwards;
            }

            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(8px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .menu a {
                color: #f8fafc;
                margin-right: 15px;
                text-decoration: none;
                font-weight: bold;
                padding: 8px 12px;
                border-radius: 10px;
                position: relative;
                background: rgba(17, 24, 39, 0.55);
                border: 1px solid rgba(255, 255, 255, 0.12);
                transition: background var(--dur) var(--ease-out), color var(--dur), transform var(--dur-fast), border-color var(--dur);
            }

            .menu a::after {
                content: "";
                position: absolute;
                left: 12px;
                right: 12px;
                bottom: 4px;
                height: 2px;
                background: rgba(255, 255, 255, 0.85);
                transform: scaleX(0);
                transition: transform var(--dur) var(--ease-out);
                border-radius: 2px;
            }

            .menu a:hover {
                background: rgba(15, 23, 42, 0.85);
                border-color: rgba(255, 255, 255, 0.22);
                transform: translateY(-1px);
            }

            .menu a:hover::after {
                transform: scaleX(1);
            }

            .menu a.menu-main {
                background: transparent;
                border-color: transparent;
            }

            .menu a.menu-main:hover {
                background: rgba(255, 255, 255, 0.14);
                border-color: transparent;
            }

            .contact-wrapper {
                position: relative;
                display: inline-block;
            }

            .contact-box {
                visibility: hidden;
                opacity: 0;
                transform: translateY(-8px) scale(0.98);
                transition: opacity var(--dur) var(--ease-out), transform var(--dur) var(--ease-out), visibility 0s linear var(--dur);
                position: absolute;
                top: 100%;
                left: 0;
                margin-top: 8px;
                width: 240px;
                background: white;
                border: 1px solid var(--border);
                padding: 14px;
                border-radius: 14px;
                box-shadow: var(--shadow-md);
                z-index: 1000;
                pointer-events: none;
            }

            .contact-wrapper:hover .contact-box {
                visibility: visible;
                opacity: 1;
                transform: translateY(0) scale(1);
                pointer-events: auto;
                transition-delay: 0s;
            }

            .contact-box h4,
            .contact-box p {
                margin: 6px 0;
                transition: transform var(--dur-fast), color var(--dur-fast);
            }

            .contact-box p:hover {
                color: var(--primary-dark);
                transform: translateX(4px);
            }

            /* ----- Main ----- */
            .detail-page-bg {
                position: relative;
                z-index: 0;
                padding: 28px 16px 56px;
            }

            .detail-page-bg::before {
                content: "";
                position: fixed;
                inset: 0;
                background: radial-gradient(ellipse 80% 50% at 50% -20%, rgba(100, 116, 139, 0.14), transparent 55%);
                pointer-events: none;
                z-index: -1;
            }

            .breadcrumb {
                width: min(960px, 96%);
                margin: 0 auto 16px;
                font-size: 14px;
                color: var(--muted);
                opacity: 0;
                animation: fadeSlideIn 0.5s var(--ease-out) 0.2s forwards;
            }

            .breadcrumb a {
                color: var(--primary-dark);
                text-decoration: none;
                transition: color var(--dur-fast), text-decoration var(--dur-fast);
            }

            .breadcrumb a:hover {
                color: var(--danger);
                text-decoration: underline;
            }

            @keyframes fadeSlideIn {
                from {
                    opacity: 0;
                    transform: translateX(-12px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .detail-float-card {
                position: relative;
                z-index: 10;
                width: min(960px, 96%);
                margin: 0 auto;
                background: var(--surface);
                padding: 32px 36px 36px;
                border-radius: 22px;
                border: 1px solid var(--border);
                box-shadow: var(--shadow-float);
                transition: box-shadow var(--dur) var(--ease-out), transform var(--dur) var(--ease-out), border-color var(--dur);
                animation: cardEnter 0.6s var(--ease-out) 0.08s both;
            }

            .detail-float-card:hover {
                box-shadow: var(--shadow-hover);
                transform: translateY(-2px);
                border-color: #c4c9d1;
            }

            @keyframes cardEnter {
                from {
                    opacity: 0;
                    transform: translateY(28px) scale(0.97);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }

            .detail-float-card h2 {
                text-align: center;
                color: #0f172a;
                margin: 0 0 28px;
                font-size: 1.55rem;
                font-weight: 700;
                letter-spacing: -0.02em;
                background: linear-gradient(135deg, #0f172a 0%, var(--primary-dark) 100%);
                -webkit-background-clip: text;
                background-clip: text;
                color: transparent;
            }

            .product-detail {
                display: flex;
                gap: 32px;
                align-items: flex-start;
                flex-wrap: wrap;
            }

            .left {
                flex: 1 1 300px;
                min-width: 260px;
            }

            .image-frame {
                position: relative;
                border-radius: 18px;
                overflow: hidden;
                border: 1px solid #e6edf7;
                box-shadow: var(--shadow-sm);
                background: linear-gradient(145deg, #f8fafc, #f1f5f9);
                transition: box-shadow var(--dur) var(--ease-out), transform var(--dur);
            }

            .image-frame:hover {
                box-shadow: var(--shadow-md);
                transform: translateY(-4px);
            }

            .image-frame::after {
                content: "";
                position: absolute;
                inset: 0;
                background: linear-gradient(180deg, transparent 60%, rgba(15, 23, 42, 0.06) 100%);
                opacity: 0;
                transition: opacity var(--dur);
                pointer-events: none;
            }

            .image-frame:hover::after {
                opacity: 1;
            }

            .product-img {
                width: 100%;
                max-height: 440px;
                display: block;
                object-fit: cover;
                transition: transform 0.65s var(--ease-out);
            }

            .image-frame:hover .product-img {
                transform: scale(1.05);
            }

            .right {
                flex: 1 1 320px;
                min-width: 280px;
            }

            .right h3 {
                margin: 0 0 12px;
                color: #0f172a;
                font-size: 1.45rem;
                line-height: 1.3;
                animation: staggerIn 0.5s var(--ease-out) 0.35s both;
            }

            .meta-tags {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
                margin-bottom: 12px;
                animation: staggerIn 0.5s var(--ease-out) 0.42s both;
            }

            .tag {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 999px;
                font-size: 13px;
                font-weight: 600;
                background: #f1f5f9;
                color: var(--primary-dark);
                border: 1px solid #e2e8f0;
                transition: transform var(--dur-fast) var(--ease-spring), background var(--dur), border-color var(--dur);
            }

            .tag:hover {
                transform: translateY(-2px);
                background: #e8eef5;
                border-color: var(--primary-light);
            }

            .price {
                color: var(--danger);
                font-size: 26px;
                font-weight: 800;
                letter-spacing: -0.02em;
                margin: 8px 0 14px;
                animation: staggerIn 0.5s var(--ease-out) 0.48s both;
                transition: transform var(--dur-fast) var(--ease-spring);
            }

            .price:hover {
                transform: scale(1.02);
            }

            .stock-line {
                animation: staggerIn 0.5s var(--ease-out) 0.52s both;
            }

            @keyframes staggerIn {
                from {
                    opacity: 0;
                    transform: translateY(12px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .desc-box {
                background: linear-gradient(145deg, #f8fafc, #f1f5f9);
                padding: 16px 18px;
                border-radius: 14px;
                margin-top: 14px;
                max-height: 180px;
                overflow-y: auto;
                border-left: 4px solid var(--primary);
                transition: border-color var(--dur), box-shadow var(--dur), transform var(--dur);
                animation: staggerIn 0.5s var(--ease-out) 0.58s both;
            }

            .desc-box:hover {
                border-left-color: var(--primary-dark);
                box-shadow: inset 0 0 0 1px rgba(100, 116, 139, 0.15);
            }

            .desc-box h4 {
                margin: 0 0 8px;
                color: #334155;
            }

            .desc-box p {
                color: #555;
                line-height: 1.6;
                margin: 0;
            }

            .form-cart {
                margin-top: 22px;
                animation: staggerIn 0.5s var(--ease-out) 0.64s both;
            }

            .form-cart label {
                font-weight: 600;
                color: #374151;
            }

            .form-cart input[type="number"] {
                width: 80px;
                padding: 10px 8px;
                margin-left: 10px;
                border: 1px solid var(--border);
                border-radius: 10px;
                transition: border-color var(--dur), box-shadow var(--dur), transform var(--dur-fast);
            }

            .form-cart input[type="number"]:hover {
                border-color: var(--primary-light);
            }

            .form-cart input[type="number"]:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(100, 116, 139, 0.25);
            }

            .btn-group {
                margin-top: 18px;
                display: flex;
                gap: 12px;
                flex-wrap: wrap;
            }

            .btn {
                flex: 1;
                min-width: 150px;
                padding: 14px 16px;
                border: none;
                border-radius: 12px;
                color: white;
                cursor: pointer;
                font-weight: 600;
                font-size: 15px;
                position: relative;
                overflow: hidden;
                transition: transform var(--dur-fast) var(--ease-spring), box-shadow var(--dur), filter var(--dur-fast);
            }

            .btn::before {
                content: "";
                position: absolute;
                inset: 0;
                background: linear-gradient(180deg, rgba(255,255,255,0.2) 0%, transparent 50%);
                opacity: 0;
                transition: opacity var(--dur);
            }

            .btn:hover::before {
                opacity: 1;
            }

            .add {
                background: linear-gradient(135deg, #ea580c 0%, #c2410c 100%);
                box-shadow: 0 4px 14px rgba(234, 88, 12, 0.35);
            }

            .buy {
                background: linear-gradient(135deg, #b91c1c 0%, #991b1b 100%);
                box-shadow: 0 4px 14px rgba(185, 28, 28, 0.35);
            }

            .add:hover,
            .buy:hover {
                transform: translateY(-3px);
                filter: brightness(1.06);
                box-shadow: 0 10px 24px rgba(15, 23, 42, 0.2);
            }

            .add:active,
            .buy:active {
                transform: translateY(0);
            }

            .btn-back {
                display: block;
                text-align: center;
                margin-top: 24px;
                padding: 14px;
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                color: white;
                text-decoration: none;
                border-radius: 12px;
                font-weight: bold;
                box-shadow: var(--shadow-sm);
                transition: transform var(--dur-fast) var(--ease-spring), box-shadow var(--dur), filter var(--dur);
                position: relative;
            }

            .btn-back:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 22px rgba(71, 85, 105, 0.35);
                filter: brightness(1.05);
            }

            .btn-back:active {
                transform: translateY(0);
            }

            .error {
                text-align: center;
                color: #b91c1c;
                font-weight: bold;
                padding: 40px 20px;
                animation: shake 0.5s var(--ease-out);
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                20% { transform: translateX(-6px); }
                40% { transform: translateX(6px); }
                60% { transform: translateX(-4px); }
                80% { transform: translateX(4px); }
            }

            .chat-widget-btn {
                position: fixed;
                right: 22px;
                bottom: 20px;
                z-index: 9999;
                border: none;
                background: linear-gradient(135deg, #64748b 0%, #475569 100%);
                color: #fff;
                padding: 14px 18px;
                border-radius: 999px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.25);
                transition: transform var(--dur-fast) var(--ease-spring), box-shadow var(--dur), filter var(--dur);
            }

            .chat-widget-btn:hover {
                transform: translateY(-3px) scale(1.03);
                box-shadow: 0 14px 32px rgba(0, 0, 0, 0.3);
                filter: brightness(1.08);
            }

            .chat-widget-panel {
                position: fixed;
                right: 22px;
                bottom: 78px;
                width: min(370px, calc(100vw - 24px));
                height: min(540px, 70vh);
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.25);
                overflow: hidden;
                z-index: 9999;
                border: 1px solid #e5e7eb;
                opacity: 0;
                visibility: hidden;
                transform: translateY(16px) scale(0.96);
                transition: opacity var(--dur) var(--ease-out), transform var(--dur) var(--ease-out), visibility 0s linear var(--dur);
            }

            .chat-widget-panel.active {
                opacity: 1;
                visibility: visible;
                transform: translateY(0) scale(1);
                transition-delay: 0s;
            }

            .chat-widget-panel iframe {
                width: 100%;
                height: 100%;
                border: none;
            }

            @media (max-width: 900px) {
                .header {
                    flex-wrap: wrap;
                }
                .search-wrapper {
                    width: 100%;
                    border-radius: 16px;
                }
                .menu {
                    top: 0;
                    overflow-x: auto;
                    white-space: nowrap;
                }
                .detail-float-card:hover {
                    transform: none;
                }
            }
        </style>
    </head>
    <body>
        <%
            String keywordValue = (String) request.getAttribute("keyword");
            String minPriceValue = (String) request.getAttribute("minPrice");
            String maxPriceValue = (String) request.getAttribute("maxPrice");
            String sortValue = (String) request.getAttribute("sort");
            String selectedCategory = (String) request.getAttribute("selectedCategory");
            List<String> categoryList = (List<String>) request.getAttribute("categoryList");
            SanPham sp = (SanPham) request.getAttribute("sp");
        %>

        <div class="header">
            <div class="logo">&#128722; STORE THIẾT BỊ</div>
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
                        <option value="<%= category%>" <%= (selectedCategory != null && selectedCategory.equals(category)) ? "selected" : ""%>><%= category%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <select name="sort" class="sort-select">
                        <option value="" <%= sortValue == null || sortValue.isEmpty() ? "selected" : ""%>>Sắp xếp</option>
                        <option value="asc" <%= "asc".equals(sortValue) ? "selected" : ""%>>Giá &#8593;</option>
                        <option value="desc" <%= "desc".equals(sortValue) ? "selected" : ""%>>Giá &#8595;</option>
                    </select>
                    <button type="submit" class="btn-search">
                        <span class="btn-icon">&#128269;</span>
                        <span class="btn-text">Tìm</span>
                    </button>
                </form>
                <div class="cart-icon">
                    <a href="GioHangServlet">
                        &#128722;
                        <span class="cart-text">Giỏ hàng</span>
                        <span class="cart-count"><%= session.getAttribute("cartSize") != null ? session.getAttribute("cartSize") : 0%></span>
                    </a>
                </div>
            </div>
            <div style="flex:1;"></div>
        </div>

        <div class="menu">
            <a href="InsertSanPham" class="menu-main">TRANG CHỦ</a>
            <a href="GioiThieu.jsp" class="menu-main">GIỚI THIỆU</a>
            <a href="#">PHÂN LOẠI</a>
            <div class="contact-wrapper">
                <a href="#">LIÊN HỆ </a>
                <div class="contact-box">
                    <h4>&#128222; Thông tin liên hệ</h4>
                    <p>&#127970; Shop ABC</p>
                    <p>&#128205; Hà Nội</p>
                    <p>&#128241; 0123 456 789</p>
                    <p>&#128231; shopabc@gmail.com</p>
                </div>
            </div>
        </div>

        <div class="detail-page-bg">
            <nav class="breadcrumb" aria-label="Breadcrumb">
                <a href="InsertSanPham">Trang chủ</a>
                <span aria-hidden="true"> / </span>
                <span>Chi tiết sản phẩm</span>
            </nav>

            <% if (sp == null) { %>
            <div class="detail-float-card">
                <div class="error">Không tìm thấy sản phẩm.</div>
                <a href="InsertSanPham" class="btn-back">&larr; Quay lại danh sách</a>
            </div>
            <% } else { %>
            <div class="detail-float-card">
                <h2>Chi tiết sản phẩm</h2>
                <div class="product-detail">
                    <div class="left">
                        <div class="image-frame">
                            <img src="<%= resolveImagePath(sp.getHinhAnh(), request.getContextPath())%>"
                                 onerror="this.onerror=null;this.src='<%= getImageFallback()%>';"
                                 class="product-img" alt="<%= sp.getTenSP()%>">
                        </div>
                    </div>
                    <div class="right">
                        <h3><%= sp.getTenSP()%></h3>
                        <div class="meta-tags">
                            <span class="tag"><%= sp.getPhanLoai()%></span>
                        </div>
                        <p class="price"><%= String.format("%,.0f", sp.getDonGia())%> VNĐ</p>
                        <p class="stock-line"><b>Số lượng còn:</b> <%= sp.getSoLuong()%></p>
                        <div class="desc-box">
                            <h4>Mô tả sản phẩm</h4>
                            <p><%= sp.getMoTa() != null ? sp.getMoTa() : "Chưa có mô tả"%></p>
                        </div>
                        <form action="CartServlet" method="get" class="form-cart">
                            <input type="hidden" name="maSP" value="<%= sp.getMaSP()%>">
                            <label>Số lượng:</label>
                            <input type="number" name="soLuong" value="1" min="1" max="<%= sp.getSoLuong()%>">
                            <div class="btn-group">
                                <button type="submit" name="action" value="add" class="btn add">Thêm vào giỏ</button>
                                <button type="submit" name="action" value="buy" class="btn buy" onclick="return confirmBuy()">Mua ngay</button>
                            </div>
                        </form>
                        <a href="InsertSanPham" class="btn-back">&larr; Quay lại danh sách sản phẩm</a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <button type="button" id="chatWidgetBtn" class="chat-widget-btn" aria-expanded="false" aria-controls="chatWidgetPanel">&#128172; Chat hỗ trợ</button>
        <div id="chatWidgetPanel" class="chat-widget-panel" role="dialog" aria-label="Chat hỗ trợ" aria-hidden="true">
            <iframe src="Chat.jsp" title="Chatbot hỗ trợ"></iframe>
        </div>
        <script>
            function confirmBuy() {
                return confirm("Bạn có chắc muốn mua sản phẩm này không?");
            }
            (function () {
                var btn = document.getElementById("chatWidgetBtn");
                var panel = document.getElementById("chatWidgetPanel");
                if (btn && panel) {
                    btn.addEventListener("click", function () {
                        var open = panel.classList.toggle("active");
                        btn.setAttribute("aria-expanded", open ? "true" : "false");
                        panel.setAttribute("aria-hidden", open ? "false" : "true");
                    });
                }
            })();
        </script>
    </body>
</html>
