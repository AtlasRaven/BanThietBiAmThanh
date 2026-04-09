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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.SanPham;
import model.SanPhamDao;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        String maSP = request.getParameter("maSP");

        HttpSession session = request.getSession();

        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        // ➕ THÊM GIỎ
        if ("add".equals(action)) {
            cart.put(maSP, cart.getOrDefault(maSP, 0) + 1);
            session.setAttribute("cart", cart);

            response.sendRedirect("InsertSanPham");
        } // ⚡ MUA NGAY
        else if ("buy".equals(action)) {
            cart.put(maSP, 1);
            session.setAttribute("cart", cart);

            response.sendRedirect("CartServlet?action=checkout"); // ✅ QUAN TRỌNG
        } // 🧾 THANH TOÁN
        else if ("checkout".equals(action)) {
            xuLyHoaDon(request, response);
        } else if ("print".equals(action)) {
            xuLyHoaDon(request, response); // dùng lại luôn
        } else {
            response.sendRedirect("InsertSanPham");
        }
    }

    private void xuLyHoaDon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");

        List<SanPham> list = new ArrayList<>();
        double tongTien = 0;

        SanPhamDao dao = new SanPhamDao();

        if (cart != null) {
            for (String maSP : cart.keySet()) {

                SanPham sp = dao.getById(maSP);

                if (sp != null) {
                    int soLuong = cart.get(maSP);

                    double thanhTien = sp.getDonGia() * soLuong;
                    tongTien += thanhTien;

                    sp.setSoLuong(soLuong);
                    list.add(sp);
                }
            }
        }

        String maDH = "DH" + System.currentTimeMillis();

        request.setAttribute("maDH", maDH);
        request.setAttribute("list", list);
        request.setAttribute("tongTien", tongTien);

        request.getRequestDispatcher("HoaDon.jsp").forward(request, response);
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
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");

        List<SanPham> list = new ArrayList<>();
        double tongTien = 0;

        SanPhamDao dao = new SanPhamDao();

        if (cart != null) {
            for (String maSP : cart.keySet()) {
                SanPham sp = dao.getById(maSP); // lấy từ DB
                int soLuong = cart.get(maSP);

                double thanhTien = sp.getDonGia() * soLuong;
                tongTien += thanhTien;

                sp.setSoLuong(soLuong); // gán lại để hiển thị
                list.add(sp);
            }
        }
        String maDH = "DH" + System.currentTimeMillis();
        request.setAttribute("maDH", maDH);
        request.setAttribute("list", list);
        request.setAttribute("tongTien", tongTien);

        String action = request.getParameter("action");

        if ("print".equals(action)) {
            request.getRequestDispatcher("InHoaDon.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("HoaDon.jsp").forward(request, response);
        }
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
