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
import java.util.ArrayList;
import java.util.List;
import model.SanPham;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "GioHangServlet", urlPatterns = {"/GioHangServlet"})
public class GioHangServlet extends HttpServlet {

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
            out.println("<title>Servlet GioHangServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GioHangServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        // ================= ADD =================
        if ("add".equals(action)) {

            String maSP = request.getParameter("maSP");
            String tenSP = request.getParameter("tenSP");
            double gia = Double.parseDouble(request.getParameter("gia"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));

            boolean exists = false;

            for (SanPham sp : cart) {
                if (sp.getMaSP().equals(maSP)) {
                    sp.setSoLuong(sp.getSoLuong() + soLuong);
                    exists = true;
                    break;
                }
            }

            if (!exists) {
                SanPham sp = new SanPham();
                sp.setMaSP(maSP);
                sp.setTenSP(tenSP);
                sp.setDonGia(gia);
                sp.setSoLuong(soLuong);
                cart.add(sp);
            }

            response.sendRedirect("InsertSanPham");
            return;
        }

        // ================= BUY =================
        if ("buy".equals(action)) {

            String maSP = request.getParameter("maSP");
            String tenSP = request.getParameter("tenSP");
            double gia = Double.parseDouble(request.getParameter("gia"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));

            cart.clear();

            SanPham sp = new SanPham();
            sp.setMaSP(maSP);
            sp.setTenSP(tenSP);
            sp.setDonGia(gia);
            sp.setSoLuong(soLuong);

            cart.add(sp);

            session.setAttribute("cart", cart);
            response.sendRedirect("GioHangServlet");
            return;
        }

        // ================= REMOVE =================
        if ("remove".equals(action)) {
            String maSP = request.getParameter("maSP");

            cart.removeIf(sp -> sp.getMaSP().equals(maSP));
        }

        // ================= UPDATE =================
        if ("update".equals(action)) {
            String maSP = request.getParameter("maSP");
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));

            for (SanPham sp : cart) {
                if (sp.getMaSP().equals(maSP)) {
                    sp.setSoLuong(soLuong);
                }
            }
        }

        // ================= TÍNH TỔNG =================
        double tongTien = 0;
        int totalQuantity = 0;

        for (SanPham sp : cart) {
            tongTien += sp.getDonGia() * sp.getSoLuong();
            totalQuantity += sp.getSoLuong();
        }

        // ================= LƯU SESSION =================
        session.setAttribute("cart", cart);
        session.setAttribute("cartSize", totalQuantity);
        session.setAttribute("tongTien", tongTien);

        // ================= GỬI JSP =================
        request.setAttribute("cart", cart);
        request.setAttribute("tongTien", tongTien);

        request.getRequestDispatcher("GioHang.jsp").forward(request, response);
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
        processRequest(request, response);
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
