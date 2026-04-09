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
public class ChiTietDonHangDao extends KetNoiCSDL {

    public void insert(ChiTietDonHang ct) {
        String sql = "INSERT INTO ChiTietDonHang VALUES (?, ?, ?, ?)";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, ct.getMaDH());
            ps.setString(2, ct.getMaSP());
            ps.setInt(3, ct.getSoLuong());
            ps.setDouble(4, ct.getDonGia());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}