<%@page import="model.NhanVien"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giới thiệu | Dung & Hung Audio</title>
        <style>
            :root {
                --bg: #f3f6fb;
                --surface: #ffffff;
                --text: #152238;
                --muted: #66758f;
                --primary: #3b82f6;
                --primary-dark: #1d4ed8;
                --border: #dbe4f0;
                --shadow-sm: 0 6px 18px rgba(15, 23, 42, 0.08);
                --shadow-md: 0 12px 30px rgba(15, 23, 42, 0.12);
            }
            body {
                font-family: "Segoe UI", Roboto, Arial, sans-serif;
                margin: 0;
                background: linear-gradient(180deg, #eef3ff 0%, var(--bg) 45%);
                color: var(--text);
            }
            .header {
                padding: 15px 30px;
                display: flex;
                align-items: center;
                gap: 20px;
                position: sticky;
                top: 0;
                z-index: 1000;
                background: rgba(17, 24, 39, 0.92);
                backdrop-filter: blur(8px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.12);
                box-shadow: var(--shadow-sm);
            }
            .logo { color: #fff; font-weight: 700; letter-spacing: 0.3px; white-space: nowrap; }
            .search-wrapper { flex: 2; display: flex; justify-content: center; align-items: center; gap: 10px; background: rgba(255,255,255,0.12); padding: 8px 15px; border-radius: 999px; border: 1px solid rgba(255,255,255,0.2); }
            .search-box { flex: 1; display: flex; align-items: center; background: #fff; border-radius: 899px; padding: 5px; gap: 5px; box-shadow: inset 0 0 0 1px #e2e8f0; }
            .search { flex: 2; padding: 10px; border: none; outline: none; }
            .price-input { width: 90px; padding: 8px; border: none; outline: none; background: #f5f5f5; border-radius: 5px; }
            .sort-select { padding: 8px; border: none; background: #f5f5f5; border-radius: 5px; }
            .search, .price-input, .sort-select { color: #1f2937; }
            .btn-search { background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); border: none; padding: 10px 15px; color: white; cursor: pointer; border-radius: 999px; }
            .btn-search:hover { background: linear-gradient(135deg, #2563eb 0%, #1e3a8a 100%); }
            .cart-icon a { background: linear-gradient(135deg, #22c55e 0%, #15803d 100%); color: white; padding: 10px 15px; border-radius: 999px; text-decoration: none; font-weight: bold; position: relative; display: inline-block; }
            .cart-count { position: absolute; top: -6px; right: -10px; background: red; color: white; font-size: 12px; padding: 3px 7px; border-radius: 50%; }
            .menu { padding: 10px 40px; position: sticky; top: 74px; z-index: 999; display: flex; align-items: center; gap: 10px; background: rgba(30, 41, 59, 0.96); backdrop-filter: blur(6px); border-bottom: 1px solid rgba(255, 255, 255, 0.12); box-shadow: var(--shadow-sm); }
            .menu a { color: #f8fafc; margin-right: 6px; text-decoration: none; font-weight: bold; padding: 8px 10px; border-radius: 10px; transition: 0.2s; }
            .menu a:hover { background: rgba(255, 255, 255, 0.12); text-decoration: none; }
            .contact-wrapper { position: relative; display: inline-block; }
            .contact-box {
                display: none;
                position: absolute;
                top: 28px;
                left: 0;
                width: 250px;
                background: #fff;
                color: #333;
                border-radius: 8px;
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
                padding: 12px;
                z-index: 1001;
            }
            .contact-box h4 { margin: 0 0 8px; color: #c1121f; }
            .contact-box p { margin: 6px 0; font-size: 14px; }
            .contact-wrapper:hover .contact-box { display: block; }
            .user-menu { position: relative; display: inline-block; margin-left: auto; }
            .dropbtn {
                background: #3498db;
                padding: 8px 12px;
                border-radius: 20px;
                color: white;
                cursor: pointer;
                transition: 0.3s;
                font-weight: bold;
            }
            .dropbtn:hover { background: #2980b9; }
            .dropdown-content {
                position: absolute;
                right: 0;
                top: 120%;
                background: white;
                min-width: 180px;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
                opacity: 0;
                transform: translateY(10px);
                pointer-events: none;
                transition: 0.3s;
            }
            .dropdown-content a {
                display: block;
                padding: 10px;
                text-decoration: none;
                color: #333;
            }
            .dropdown-content a:hover { background: #f5f5f5; }
            .user-menu:hover .dropdown-content {
                opacity: 1;
                transform: translateY(0);
                pointer-events: auto;
            }
            .btn-login {
                margin-left: auto;
                background: #3498db;
                color: #fff;
                text-decoration: none;
                padding: 8px 14px;
                border-radius: 20px;
                font-weight: bold;
            }

            .container { width: min(1280px, 96%); margin: 25px auto; }
            .hero { background: linear-gradient(135deg, #1e3a8a, #2563eb); color: #fff; border-radius: 16px; padding: 36px; box-shadow: var(--shadow-md); }
            .hero h1 { margin: 0 0 12px; font-size: clamp(30px, 4vw, 44px); }
            .hero p { margin: 0; line-height: 1.7; color: #dbeafe; }
            .section { margin-top: 18px; background: #fff; border: 1px solid #dbe4f0; border-radius: 14px; padding: 22px; box-shadow: var(--shadow-sm); }
            .section h2 { margin: 0 0 10px; font-size: 24px; color: #0f172a; }
            .section p { margin: 0 0 12px; line-height: 1.8; color: #475569; }
            .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 16px; margin-top: 16px; }
            .card { background: #f8fbff; border: 1px solid #dbe4f0; border-radius: 12px; padding: 16px; box-shadow: var(--shadow-sm); }
            .card h3 { margin: 0 0 8px; color: #1e3a8a; }
            .card ul { margin: 0; padding-left: 18px; color: #475569; line-height: 1.7; }

            @media (max-width: 900px) {
                .header { flex-wrap: wrap; }
                .search-wrapper { width: 100%; }
                .menu { top: 66px; overflow-x: auto; white-space: nowrap; }
            }

            @media (max-width: 600px) {
                .header {
                    padding: 12px;
                    gap: 10px;
                    flex-wrap: wrap;
                }

                .search-wrapper {
                    width: 100%;
                    border-radius: 16px;
                    padding: 8px;
                }

                .search-box {
                    flex-wrap: wrap;
                    border-radius: 14px;
                }

                .price-input, .sort-select {
                    width: calc(50% - 4px);
                }
            }
        </style>
    </head>
    <body>
        <%
            String role = (String) session.getAttribute("role");
            NhanVien nv = (NhanVien) session.getAttribute("admin");
            String user = (String) session.getAttribute("user");
        %>

        <div class="header">
            <div class="logo">🛒 STORE THIẾT BỊ</div>
            <div class="search-wrapper">
                <form action="searchSanPhamServlet" method="get" class="search-box">
                    <input type="text" name="keyword" class="search" placeholder="Tên / Mã sản phẩm...">
                    <input type="number" name="minPrice" placeholder="Từ giá" class="price-input">
                    <input type="number" name="maxPrice" placeholder="Đến giá" class="price-input">
                    <select name="sort" class="sort-select">
                        <option value="">Sắp xếp</option>
                        <option value="asc">Giá ↑</option>
                        <option value="desc">Giá ↓</option>
                    </select>
                    <button type="submit" class="btn-search">🔍</button>
                </form>
                <div class="cart-icon">
                    <a href="GioHangServlet">
                        🛒
                        <span class="cart-count"><%= session.getAttribute("cartSize") != null ? session.getAttribute("cartSize") : 0%></span>
                    </a>
                </div>
            </div>
            <div style="flex:1;"></div>
        </div>

        <div class="menu">
            <a href="InsertSanPham">TRANG CHỦ</a>
            <a href="GioiThieu.jsp">GIỚI THIỆU</a>
            <a href="InsertSanPham">PHÂN LOẠI</a>
            
            <div class="contact-wrapper">
                <a href="#">LIÊN HỆ</a>
                <div class="contact-box">
                    <h4>📞 Thông tin liên hệ</h4>
                    <p>🏢 Shop ABC</p>
                    <p>📍 Hà Nội</p>
                    <p>📱 0123 456 789</p>
                    <p>📧 shopabc@gmail.com</p>
                </div>
            </div>
            <% if ("admin".equals(role)) { %>
            <div class="user-menu">
                <span class="dropbtn">👨‍💼 <%= nv.getTenNV()%> ▼</span>
                <div class="dropdown-content">
                    <a href="NhanVienServlet">Thông tin</a>
                    <a href="LogoutServlet">Đăng xuất</a>
                </div>
            </div>
            <% } else if (role != null) { %>
            <div class="user-menu">
                <span class="dropbtn">👤 <%= user%> ▼</span>
                <div class="dropdown-content">
                    <a href="KhachHangServlet">Thông tin cá nhân</a>
                    <a href="LogoutServlet">Đăng xuất</a>
                </div>
            </div>
            <% } else { %>
            <a href="login.jsp" class="btn-login">ĐĂNG NHẬP</a>
            <% } %>
        </div>

        <main class="container">
            <section class="hero">
                <h1>Giới thiệu tổng quan về Dung & Hung Audio</h1>
                <p>
                    Dung & Hung Audio là nền tảng bán lẻ thiết bị âm thanh theo mô hình omni-channel, kết hợp bán hàng trực tuyến
                    với dịch vụ tư vấn kỹ thuật theo nhu cầu thực tế của khách hàng. Chúng tôi phục vụ nhiều nhóm khách hàng:
                    người dùng gia đình, phòng thu nhỏ, game thủ, nhà sáng tạo nội dung và doanh nghiệp cần giải pháp âm thanh ổn định.
                    Mục tiêu của hệ thống là giúp khách hàng tìm đúng sản phẩm, đúng ngân sách và đúng mục đích sử dụng.
                </p>
            </section>

            <section class="section">
                <h2>Định vị thương hiệu và chiến lược phát triển</h2>
                <p>
                    Ở cấp độ vĩ mô, Dung & Hung Audio định vị là đơn vị cung cấp giải pháp âm thanh toàn diện, không chỉ bán thiết bị
                    đơn lẻ mà còn đồng hành trong suốt vòng đời sử dụng sản phẩm. Hệ thống sản phẩm được xây dựng theo các trục nhu cầu:
                    giải trí cá nhân, học tập trực tuyến, sản xuất nội dung và triển khai âm thanh cho không gian thương mại.
                </p>
                <p>
                    Chiến lược phát triển tập trung vào ba trụ cột: (1) danh mục sản phẩm chính hãng đa phân khúc,
                    (2) năng lực tư vấn dựa trên dữ liệu tồn kho - giá bán - hành vi tìm kiếm,
                    và (3) dịch vụ hậu mãi linh hoạt nhằm nâng cao tỷ lệ quay lại của khách hàng.
                </p>
            </section>

            <section class="grid">
                <article class="card">
                    <h3>Tầm nhìn dài hạn</h3>
                    <ul>
                        <li>Trở thành điểm đến tin cậy cho thiết bị âm thanh tại thị trường nội địa.</li>
                        <li>Chuẩn hóa quy trình tư vấn theo nhu cầu sử dụng thực tế.</li>
                        <li>Phát triển hệ sinh thái dịch vụ trước và sau bán hàng.</li>
                    </ul>
                </article>

                <article class="card">
                    <h3>Sứ mệnh</h3>
                    <ul>
                        <li>Đưa sản phẩm âm thanh chất lượng đến đúng người dùng với chi phí hợp lý.</li>
                        <li>Giảm rủi ro chọn sai sản phẩm bằng tư vấn kỹ thuật minh bạch.</li>
                        <li>Tạo trải nghiệm mua sắm nhanh, rõ ràng, dễ theo dõi đơn hàng.</li>
                    </ul>
                </article>

                <article class="card">
                    <h3>Giá trị cốt lõi</h3>
                    <ul>
                        <li>Uy tín nguồn hàng và thông tin sản phẩm.</li>
                        <li>Lấy khách hàng làm trung tâm trong mọi quyết định.</li>
                        <li>Cải tiến liên tục thông qua phản hồi thực tế.</li>
                    </ul>
                </article>
            </section>

            <section class="section">
                <h2>Năng lực vận hành và cam kết dịch vụ</h2>
                <p>
                    Hệ thống web được tối ưu cho quy trình quản trị sản phẩm, tìm kiếm theo tiêu chí, cập nhật tồn kho và tư vấn tự động qua chatbot.
                    Điều này giúp khách hàng nhận thông tin gần thời gian thực về giá bán, số lượng và tình trạng sản phẩm. Song song đó,
                    đội ngũ vận hành duy trì chuẩn dịch vụ gồm phản hồi nhanh, giao hàng an toàn và hỗ trợ hậu mãi rõ ràng.
                </p>
                <p>
                    Chúng tôi cam kết minh bạch trong mọi giao dịch, luôn cập nhật trạng thái xử lý đơn hàng, đồng thời cung cấp nhiều lựa chọn thanh toán
                    và giao nhận để phù hợp với từng khu vực. Với định hướng bền vững, Dung & Hung Audio tiếp tục đầu tư vào trải nghiệm số
                    và chất lượng tư vấn để trở thành đối tác mua sắm lâu dài của khách hàng.
                </p>
            </section>
        </main>
    </body>
</html>
