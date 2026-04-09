<%-- 
    Document   : GioHang
    Created on : Apr 9, 2026, 9:27:30 AM
    Author     : ASUS
--%>
<%@page import="java.util.*"%>
<%@page import="model.SanPham"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        body {
            font-family: Arial;
            background: #f5f5f5;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #d62828;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        th {
            background: #d62828;
            color: white;
            padding: 12px;
            text-align: center;
        }

        td {
            text-align: center;
            padding: 12px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #f9f9f9;
        }

        /* input số lượng */
        input[type="number"] {
            width: 60px;
            padding: 5px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* nút cập nhật */
        button {
            background: #2ecc71;
            border: none;
            padding: 6px 10px;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #27ae60;
        }

        /* nút xóa */
        a {
            text-decoration: none;
            font-weight: bold;
        }

        a[href*="remove"] {
            color: red;
        }

        a[href*="remove"]:hover {
            text-decoration: underline;
        }

        /* tổng tiền */
        h3 {
            text-align: right;
            color: #e74c3c;
            margin-top: 20px;
        }

        /* nút dưới */
        .actions {
            margin-top: 20px;
            text-align: center;
        }

        .actions a {
            display: inline-block;
            margin: 10px;
            padding: 10px 15px;
            border-radius: 8px;
            color: white;
            text-decoration: none;
            transition: 0.3s;
        }

        .continue {
            background: #3498db;
        }

        .continue:hover {
            background: #2980b9;
        }

        .checkout {
            background: #f39c12;
        }

        .checkout:hover {
            background: #e67e22;
        }
    </style>
    <body>


        <%
            List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
            double tongTien = 0;
        %>

        <h2>🛒 Giỏ hàng</h2>

        <table border="1" width="100%" cellpadding="10">
            <tr>
                <th>Tên SP</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Thành tiền</th>
                <th>Hành động</th>
            </tr>

            <%
                if (cart != null) {
                    for (SanPham sp : cart) {
                        double thanhTien = sp.getDonGia() * sp.getSoLuong();
                        tongTien += thanhTien;
            %>
            <tr>
                <td><%= sp.getTenSP()%></td>

                <td>
                    <form action="CartServlet">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="maSP" value="<%= sp.getMaSP()%>">

                        <input type="number" name="soLuong"
                               value="<%= sp.getSoLuong()%>" min="1">

                        <button type="submit">Cập nhật</button>
                    </form>
                </td>

                <td><%= String.format("%,.0f", sp.getDonGia())%></td>

                <td><%= String.format("%,.0f", thanhTien)%></td>

                <td>
                    <a href="CartServlet?action=remove&maSP=<%= sp.getMaSP()%>">
                        ❌ Xóa
                    </a>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>

        <h3>💰 Tổng tiền: <%= String.format("%,.0f", tongTien)%> VNĐ</h3>

        <br>

        <a href="InsertSanPham">← Mua tiếp</a> |
        <a href="CartServlet?action=checkout">🧾 Thanh toán</a>
    </body>
</html>
