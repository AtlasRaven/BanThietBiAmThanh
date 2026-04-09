/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.SanPham;
import model.SanPhamDao;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "ThemSanPhamServlet", urlPatterns = {"/ThemSanPhamServlet"})
public class ThemSanPhamServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ThemSanPhamServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ThemSanPhamServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("ThemSanPham.jsp");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 🔒 Check admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (!"admin".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 📥 Lấy dữ liệu từ form
        String maSP = request.getParameter("maSP");
        String tenSP = request.getParameter("tenSP");
        String phanLoai = request.getParameter("phanLoai");

        // ✅ FIX chống lỗi NULL
        String soLuongStr = request.getParameter("soLuong");
        int soLuong = 0;
        if (soLuongStr != null && !soLuongStr.trim().isEmpty()) {
            soLuong = Integer.parseInt(soLuongStr);
        }

        String donGiaStr = request.getParameter("donGia");
        double donGia = 0;
        if (donGiaStr != null && !donGiaStr.trim().isEmpty()) {
            donGia = Double.parseDouble(donGiaStr);
        }

        String moTa = request.getParameter("moTa");
        String hinhAnh = request.getParameter("hinhAnh");

        // 📦 Tạo object
        SanPham sp = new SanPham(maSP, tenSP, phanLoai, donGia, soLuong, moTa, hinhAnh);

        // 💾 Lưu DB
        SanPhamDao dao = new SanPhamDao();
        dao.insert(sp);

        // 🔁 Quay về danh sách
        response.sendRedirect("InsertSanPham");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
