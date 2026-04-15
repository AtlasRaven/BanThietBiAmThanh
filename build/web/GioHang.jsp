<%@page import="java.util.List"%>
<%@page import="model.SanPham"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Giỏ hàng | Dung & Hung Audio</title>
    <style>
      body { font-family: "Segoe UI", Arial, sans-serif; margin: 0; background: linear-gradient(180deg,#eef3ff 0%,#f8fbff 100%); color: #0f172a; }
      .page { width: min(1080px, 95%); margin: 24px auto; background: #fff; border: 1px solid #dbe4f0; border-radius: 16px; box-shadow: 0 10px 30px rgba(15,23,42,.12); padding: 20px; }
      h2 { margin: 0 0 16px; }
      table { width: 100%; border-collapse: collapse; }
      th, td { text-align: center; padding: 12px 10px; border-bottom: 1px solid #edf2f7; }
      th { background: #1d4ed8; color: #fff; }
      tr:hover { background: #f8fbff; }
      input[type="number"] { width: 70px; padding: 6px; border: 1px solid #cbd5e1; border-radius: 8px; }
      button { border: none; background: #16a34a; color: #fff; padding: 7px 10px; border-radius: 8px; cursor: pointer; }
      .remove-link { color: #dc2626; font-weight: 700; text-decoration: none; }
      .summary { display: flex; justify-content: space-between; align-items: center; margin-top: 18px; flex-wrap: wrap; gap: 10px; }
      .total { font-size: 22px; font-weight: 700; color: #dc2626; }
      .actions { display: flex; gap: 10px; flex-wrap: wrap; }
      .btn { text-decoration: none; color: #fff; font-weight: 700; padding: 10px 14px; border-radius: 10px; }
      .btn-continue { background: #2563eb; }
      .btn-checkout { background: #f59e0b; }
      .empty { color: #64748b; padding: 16px 0; text-align: center; }
      .btn-undo {background: #2563eb;}
    </style>
  </head>
  <body>
    <%
      List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
      double tongTien = 0;
    %>
    <div class="page">
      <h2>🛒 Giỏ hàng của bạn</h2>
      <table>
        <tr>
          <th>Tên SP</th>
          <th>Số lượng</th>
          <th>Giá</th>
          <th>Thành tiền</th>
          <th>Hành động</th>
        </tr>
        <%
          if (cart != null && !cart.isEmpty()) {
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
              <input type="number" name="soLuong" value="<%= sp.getSoLuong()%>" min="1">
              <button type="submit">Cập nhật</button>
            </form>
          </td>
          <td><%= String.format("%,.0f", sp.getDonGia())%> VNĐ</td>
          <td><%= String.format("%,.0f", thanhTien)%> VNĐ</td>
          <td>
            <a class="remove-link" href="CartServlet?action=remove&maSP=<%= sp.getMaSP()%>">❌ Xóa</a>
          </td>
        </tr>
        <%
            }
          } else {
        %>
        <tr>
          <td colspan="5" class="empty">Giỏ hàng đang trống.</td>
        </tr>
        <%
          }
        %>
      </table>
      <div class="summary">
        <div class="total">💰 Tổng tiền: <%= String.format("%,.0f", tongTien)%> VNĐ</div>
        <div class="actions">
          <a class="btn btn-continue" href="InsertSanPham">← Mua tiếp</a>
          <a class="btn btn-checkout" href="CartServlet?action=checkout">🧾 Thanh toán</a>
          <a class="btn btn-undo" href ="InsertSanPham">Quay lại</a>
        </div>
      </div>
    </div>
  </body>
</html>
