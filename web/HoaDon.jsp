<%@page import="java.util.*"%>
<%@page import="model.SanPham"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hóa đơn</title>

        <style>
            body {
                font-family: 'Segoe UI', Arial;
                background: linear-gradient(135deg, #74ebd5, #ACB6E5);
                margin: 0;
            }

            .container {
                width: 700px;
                margin: 60px auto;
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                animation: fadeIn 0.5s ease;
            }

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
            }

            .ma-don {
                text-align: center;
                margin-bottom: 20px;
                color: #555;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }

            th {
                background: #3498db;
                color: white;
                padding: 10px;
            }

            td {
                padding: 10px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            tr:hover {
                background: #f1f7ff;
            }

            .tong-tien {
                text-align: right;
                margin-top: 20px;
                font-size: 20px;
                font-weight: bold;
                color: red;
            }

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

        </style>
    </head>

    <body>

        <%
            String maDH = (String) request.getAttribute("maDH");
            List<SanPham> list = (List<SanPham>) request.getAttribute("list");
            Double tongTien = (Double) request.getAttribute("tongTien");
        %>

        <div class="container">

            <h2>🧾 HÓA ĐƠN</h2>

            <p class="ma-don">
                Mã đơn: <b><%= (maDH != null ? maDH : "")%></b>
            </p>

            <table>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá</th>
                    <th>Thành tiền</th>
                </tr>

                <%
                    if (list != null) {
                        for (SanPham sp : list) {
                %>
                <tr>
                    <td><%= sp.getTenSP()%></td>
                    <td><%= sp.getSoLuong()%></td>
                    <td><%= String.format("%,.0f", sp.getDonGia())%> VNĐ</td>
                    <td><%= String.format("%,.0f", sp.getDonGia() * sp.getSoLuong())%> VNĐ</td>
                </tr>
                <%
                        }
                    }
                %>

            </table>

            <div class="tong-tien">
                Tổng tiền: <%= (tongTien != null ? String.format("%,.0f", tongTien) : "0")%> VNĐ
            </div>

            
            <a href="CartServlet?action=print" class="btn-back">
                🖨️ Xuất hóa đơn
            </a>
            <a href ="InsertSanPham "class="btn-back">Quay Lại</a>
        </div>

    </body>
</html>