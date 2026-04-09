<%-- 
    Document   : GioHang
    Created on : Apr 9, 2026, 9:27:30 AM
    Author     : ASUS
--%>

<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");

            if (cart != null) {
                for (String maSP : cart.keySet()) {
        %>
        <p>
            Mã SP: <%= maSP%> | Số lượng: <%= cart.get(maSP)%>
        </p>
        <%
            }
        } else {
        %>
        <p>Giỏ hàng trống</p>
        <%
            }
        %>
    </body>
</html>
