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
import java.util.List;
import model.CartItem;
import model.ChiTietDonHang;
import model.ChiTietDonHangDao;
import model.DonHang;
import model.DonHangDao;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        String maKH = (String) session.getAttribute("user");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("giohang.jsp");
            return;
        }

        double tongTien = 0;
        for (CartItem item : cart) {
            tongTien += item.getThanhTien(); // chuẩn
        }

// tạo đơn hàng
        DonHang dh = new DonHang();
        dh.setMaKH(maKH);
        dh.setTrangThai("Đã thanh toán");
        dh.setTongTien(tongTien);

        DonHangDao dhDAO = new DonHangDao();
        String maDH = dhDAO.taoDonHang(dh);

// lưu chi tiết
        ChiTietDonHangDao ctDAO = new ChiTietDonHangDao();

        for (CartItem item : cart) {
            ChiTietDonHang ct = new ChiTietDonHang();
            ct.setMaDH(maDH);
            ct.setMaSP(item.getSp().getMaSP());
            ct.setSoLuong(item.getSoLuong());
            ct.setDonGia(item.getSp().getDonGia());

            ctDAO.insert(ct);
        }

// clear cart
        session.removeAttribute("cart");

// forward
        request.setAttribute("maDH", maDH);
        request.setAttribute("cart", cart);
        request.setAttribute("tongTien", tongTien);

        request.getRequestDispatcher("HoaDon.jsp").forward(request, response);
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
