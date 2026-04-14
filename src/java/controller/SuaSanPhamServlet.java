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
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.SanPham;
import model.SanPhamDao;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "SuaSanPhamServlet", urlPatterns = {"/SuaSanPhamServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 30 * 1024 * 1024
)
public class SuaSanPhamServlet extends HttpServlet {

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
      String maSP = request.getParameter("maSP");

        SanPhamDao dao = new SanPhamDao();
        SanPham sp = dao.getById(maSP);

        request.setAttribute("sp", sp);
        request.getRequestDispatcher("SuaSanPham.jsp")
               .forward(request, response);
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

        String maSP = request.getParameter("maSP");
        String ten = request.getParameter("ten");
        String loai = request.getParameter("loai");
        double gia = Double.parseDouble(request.getParameter("gia"));
        int sl = Integer.parseInt(request.getParameter("sl"));
        String mota = request.getParameter("mota");
        String oldHinhAnh = request.getParameter("oldHinhAnh");
        String hinhAnhText = request.getParameter("hinhAnh");

        Part imagePart = request.getPart("hinhAnhFile");
        String uploadedFileName = saveImageIfExists(imagePart, request);
        String finalHinhAnh;
        if (!uploadedFileName.isEmpty()) {
            finalHinhAnh = uploadedFileName;
        } else if (hinhAnhText != null && !hinhAnhText.trim().isEmpty()) {
            finalHinhAnh = hinhAnhText.trim();
        } else {
            finalHinhAnh = oldHinhAnh != null ? oldHinhAnh : "";
        }

        SanPham sp = new SanPham(maSP, ten, loai, gia, sl, mota, finalHinhAnh);

        SanPhamDao dao = new SanPhamDao();
        dao.update(sp);

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
