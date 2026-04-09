<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm sản phẩm</title>

        <style>
            body {
                font-family: Arial;
                background: linear-gradient(120deg, #3498db, #8e44ad);
                margin: 0;
            }

            .form-container {
                width: 400px;
                margin: 60px auto;
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
            }

            input, textarea {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

            textarea {
                resize: none;
                height: 80px;
            }

            .btn-submit {
                width: 100%;
                margin-top: 15px;
                padding: 10px;
                border: none;
                border-radius: 6px;
                background: #2ecc71;
                color: white;
                font-size: 16px;
                cursor: pointer;
            }

            .btn-submit:hover {
                background: #27ae60;
            }

            .back-link {
                display: block;
                text-align: center;
                margin-top: 10px;
                text-decoration: none;
                color: #3498db;
            }

            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>

        <div class="form-container">
            <h2>➕ Thêm sản phẩm</h2>

            <form action="ThemSanPhamServlet" method="post">

                <label>Mã SP</label>
                <input type="text" name="maSP" required>

                <label>Tên SP</label>
                <input type="text" name="tenSP" required>

                <label>Phân loại</label>
                <input type="text" name="phanLoai">

                <label>Giá</label>
                <input type="number" name="donGia">

                <label>Số lượng</label>
                <input type="number" name="soLuong">

                <label>Mô tả</label>
                <textarea name="moTa"></textarea>

                <label>Hình ảnh (tên file)</label>
                <input type="text" name="hinhAnh">

                <button type="submit" class="btn-submit">Thêm sản phẩm</button>
            </form>

            <a href="InsertSanPham" class="back-link">⬅ Quay lại</a>
        </div>

    </body>
</html>