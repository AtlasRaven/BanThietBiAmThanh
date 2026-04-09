/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.*;
/**
 *
 * @author ASUS
 */
public class DonHangDao extends KetNoiCSDL {

    public String taoDonHang(DonHang dh) {
        String maDH = "DH" + System.currentTimeMillis(); // auto mã
        String sql = "INSERT INTO DonHang VALUES (?, ?, ?, GETDATE(), ?, ?)";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, maDH);
            ps.setString(2, dh.getMaKH());
            ps.setString(3, dh.getMaNV());
            ps.setString(4, dh.getTrangThai());
            ps.setDouble(5, dh.getTongTien());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return maDH;
    }
}
