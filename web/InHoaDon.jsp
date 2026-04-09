<%@page import="java.util.*"%>
<%@page import="model.SanPham"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>In hóa đơn</title>

        <style>
            body {
                font-family: Arial;
                background: white;
                padding: 40px;
            }

            .invoice {
                width: 700px;
                margin: auto;
            }

            h2 {
                text-align: center;
            }

            .info {
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                border: 1px solid black;
                padding: 10px;
                text-align: center;
            }

            .tong {
                text-align: right;
                margin-top: 15px;
                font-weight: bold;
            }

            .btn-print {
                margin-top: 20px;
                text-align: center;
            }

            .btn-print button {
                padding: 10px 20px;
                font-size: 16px;
            }

            /* Ẩn nút khi in */
            @media print {
                .btn-print {
                    display: none;
                }
            }
        </style>
    </head>

    <body>

        <%
            String maDH = (String) request.getAttribute("maDH");
            List<SanPham> list = (List<SanPham>) request.getAttribute("list");
            Double tongTien = (Double) request.getAttribute("tongTien");
        %>

        <div class="invoice">

            <h2>🧾 HÓA ĐƠN BÁN HÀNG</h2>

            <div class="info">
                <p>Mã đơn: <b><%= maDH%></b></p>
                <p>Ngày: <%= new java.util.Date()%></p>
            </div>

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
                    <td><%= String.format("%,.0f", sp.getDonGia())%></td>
                    <td><%= String.format("%,.0f", sp.getDonGia() * sp.getSoLuong())%></td>
                </tr>
                <%
                        }
                    }
                %>

            </table>

            <div class="tong">
                Tổng tiền: <%= String.format("%,.0f", tongTien)%> VNĐ
            </div>

            <div class="btn-print">
                <button onclick="window.print()">🖨️ In hóa đơn</button>
            </div>

        </div>

    </body>
</html>