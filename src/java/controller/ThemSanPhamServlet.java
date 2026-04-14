/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.Part;
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
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 30 * 1024 * 1024
)
public class ThemSanPhamServlet extends HttpServlet {

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

        Part imagePart = request.getPart("hinhAnhFile");
        String uploadedFileName = saveImageIfExists(imagePart, request);
        if (!uploadedFileName.isEmpty()) {
            hinhAnh = uploadedFileName;
        }
        if (hinhAnh == null) {
            hinhAnh = "";
        }

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

    private String saveImageIfExists(Part filePart, HttpServletRequest request) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return "";
        }

        String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (submittedName == null || submittedName.trim().isEmpty()) {
            return "";
        }

        String extension = "";
        int dotIndex = submittedName.lastIndexOf('.');
        if (dotIndex >= 0) {
            extension = submittedName.substring(dotIndex);
        }
        String storedName = "sp_" + System.currentTimeMillis() + extension;

        String uploadPath = request.getServletContext().getRealPath("/images");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        filePart.write(new File(uploadDir, storedName).getAbsolutePath());
        return storedName;
    }
}
