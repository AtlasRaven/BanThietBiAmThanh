<%@page import="model.SanPham"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    SanPham sp = (SanPham) request.getAttribute("sp");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>

    <style>
        body {
            font-family: 'Segoe UI', Arial;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            margin: 0;
        }

        .container {
            width: 420px;
            margin: 80px auto;
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
            margin-bottom: 20px;
            color: #333;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 8px;
            border: 1px solid #ccc;
            outline: none;
            transition: 0.3s;
        }

        input:focus {
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52,152,219,0.5);
        }

        .btn-submit {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(45deg, #3498db, #6dd5fa);
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-submit:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #2980b9, #57c1eb);
        }

        .btn-back {
            display: block;
            text-align: center;
            margin-top: 15px;
            text-decoration: none;
            color: #555;
        }

        .btn-back:hover {
            color: #000;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Sửa sản phẩm</h2>

    <form action="SuaSanPhamServlet" method="post">
        <input type="hidden" name="maSP" value="<%= sp.getMaSP() %>">

        <label>Tên sản phẩm</label>
        <input name="ten" value="<%= sp.getTenSP() %>">

        <label>Loại</label>
        <input name="loai" value="<%= sp.getPhanLoai() %>">

        <label>Giá</label>
        <input name="gia" value="<%= sp.getDonGia() %>">

        <label>Số lượng</label>
        <input name="sl" value="<%= sp.getSoLuong() %>">

        <label>Mô tả</label>
        <input name="mota" value="<%= sp.getMoTa() %>">

        <button type="submit" class="btn-submit">Cập nhật</button>
    </form>

    <a href="InsertSanPham" class="btn-back">← Quay lại</a>
</div>

</body>
</html>