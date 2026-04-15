<%@page import="java.util.List"%>
<%@page import="model.SanPham"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Hóa đơn | Dung & Hung Audio</title>
    <style>
      body { margin: 0; font-family: "Segoe UI", Arial, sans-serif; background: linear-gradient(180deg,#eef3ff 0%,#f8fbff 100%); }
      .wrap { width: min(900px, 95%); margin: 24px auto; background: #fff; border: 1px solid #dbe4f0; border-radius: 16px; box-shadow: 0 10px 30px rgba(15,23,42,.12); padding: 22px; }
      h2 { margin: 0; text-align: center; color: #0f172a; }
      .code { margin: 8px 0 14px; text-align: center; color: #64748b; }
      table { width: 100%; border-collapse: collapse; }
      th, td { text-align: center; padding: 11px; border-bottom: 1px solid #edf2f7; }
      th { background: #1d4ed8; color: #fff; }
      .total { text-align: right; margin-top: 14px; font-size: 22px; color: #dc2626; font-weight: 700; }
      .actions { display: flex; justify-content: center; flex-wrap: wrap; gap: 10px; margin-top: 16px; }
      .btn { text-decoration: none; color: #fff; padding: 10px 14px; border-radius: 10px; font-weight: 700; }
      .btn-print { background: #0ea5e9; }
      .btn-home { background: #334155; }
    </style>
  </head>
  <body>
    <%
      String maDH = (String) request.getAttribute("maDH");
      List<SanPham> list = (List<SanPham>) request.getAttribute("list");
      Double tongTien = (Double) request.getAttribute("tongTien");
    %>
    <div class="wrap">
      <h2>🧾 HÓA ĐƠN THANH TOÁN</h2>
      <p class="code">Mã đơn hàng: <b><%= maDH != null ? maDH : ""%></b></p>

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

      <div class="total">Tổng tiền: <%= tongTien != null ? String.format("%,.0f", tongTien) : "0"%> VNĐ</div>
      <div class="actions">
        <a href="CartServlet?action=print" class="btn btn-print">🖨️ Xuất hóa đơn</a>
        <a href="InsertSanPham" class="btn btn-home">Quay lại trang sản phẩm</a>
      </div>
    </div>
  </body>
</html>
