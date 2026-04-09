<%-- 
    Document   : ChiTietSanPham
    Created on : Apr 8, 2026, 7:59:47 AM
    Author     : ASUS
--%>
<%@page import="model.SanPham"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        body {
            font-family: 'Segoe UI', Arial;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            margin: 0;
        }

        /* CARD */
        .container {
            width: 420px;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            animation: fadeIn 0.5s ease;
        }

        /* ANIMATION */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        /* AVATAR */
        .avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: #ddd;
            margin: 0 auto 15px;
            display: block;
        }

        /* INFO BLOCK */
        .info {
            margin: 12px 0;
            padding: 12px;
            border-radius: 8px;
            transition: 0.3s;
            display: flex;
            justify-content: space-between;
        }

        .info:hover {
            background: #f1f7ff;
        }

        .label {
            font-weight: bold;
            color: #555;
        }

        .value {
            color: #222;
        }

        /* ERROR */
        .error {
            text-align: center;
            color: red;
            font-weight: bold;
            margin-top: 50px;
        }

        /* BUTTON */
        .btn-back {
            display: block;
            text-align: center;
            margin-top: 25px;
            padding: 12px;
            background: linear-gradient(45deg, #3498db, #6dd5fa);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-back:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #2980b9, #57c1eb);
        }
        /* LAYOUT */
        .product-detail {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        /* LEFT IMAGE */
        .left {
            flex: 1;
        }

        .product-img {
            width: 100%;
            border-radius: 10px;
            object-fit: cover;
        }

        /* RIGHT INFO */
        .right {
            flex: 1;
        }

        /* PRICE */
        .price {
            color: red;
            font-size: 20px;
            font-weight: bold;
        }

        /* DESCRIPTION */
        .desc {
            color: #555;
            margin: 10px 0;
        }

        /* FORM */
        .form-cart {
            margin-top: 15px;
        }

        .form-cart input {
            width: 60px;
            padding: 5px;
            margin-left: 10px;
        }

        /* BUTTON GROUP */
        .btn-group {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }

        .btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 8px;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        /* BUTTON COLORS */
        .add {
            background: orange;
        }

        .buy {
            background: red;
        }

        .add:hover {
            background: darkorange;
        }

        .buy:hover {
            background: darkred;
        }
    </style>
    <body>

        <%
            SanPham sp = (SanPham) request.getAttribute("sp");
        %>

        <div class="container">

            <h2>Chi tiết sản phẩm</h2>

            <div class="product-detail">

                <!-- ẢNH -->
                <div class="left">
                    <img src="images/<%= sp.getHinhAnh()%>" class="product-img">
                </div>

                <!-- THÔNG TIN -->
                <div class="right">
                    <h3><%= sp.getTenSP()%></h3>

                    <p><b>Loại:</b> <%= sp.getPhanLoai()%></p>

                    <p class="price">
                        <%= String.format("%,.0f", sp.getDonGia())%> VNĐ
                    </p>

                    <p><b>Số lượng:</b> <%= sp.getSoLuong()%></p>

                    <p class="desc"><%= sp.getMoTa()%></p>

                    <form action="CartServlet" method="post" class="form-cart">
                        <input type="hidden" name="maSP" value="<%= sp.getMaSP()%>">

                        <label>Số lượng:</label>
                        <input type="number" name="soLuong" value="1" min="1">

                        <div class="btn-group">
                            <button type="submit" name="action" value="add" class="btn add">
                                Thêm vào giỏ
                            </button>

                            <button type="submit" name="action" value="buy" class="btn buy">
                                Mua ngay
                            </button>
                        </div>
                    </form>

                    <a href="InsertSanPham" class="btn-back">← Quay lại</a>
                </div>

            </div>

        </div>

    </body>
</html>
