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
public class KhachHangDao extends KetNoiCSDL {
    

    public boolean insert(KhachHang kh) {
        String sql = "INSERT INTO khachhang VALUES (?,?,?,?,?,?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, kh.getMaKH());
            ps.setString(2, kh.getTenKH());
            ps.setString(3, kh.getSDT());
            ps.setString(4, kh.getEmail());
            ps.setString(5, kh.getDiaChi());
            ps.setString(6,kh.getMatKhau());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public KhachHang login(String makh, String password) {
    String sql = "SELECT * FROM khachhang WHERE MaKH = ? AND MatKhau = ?";
    try {Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, makh);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            return new KhachHang(
                rs.getString("MaKH"),
                rs.getString("TenKH"),
                rs.getString("SDT"),
                rs.getString("Email"),
                rs.getString("DiaChi"),
                    rs.getString("MatKhau")
            );
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
    public KhachHang getByMaKH(String makh) {
    String sql = "SELECT * FROM khachhang WHERE MaKH = ?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, makh);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            KhachHang kh = new KhachHang();
            kh.setMaKH(rs.getString("MaKH"));
            kh.setTenKH(rs.getString("TenKH"));
            kh.setEmail(rs.getString("Email"));
            kh.setSDT(rs.getString("SDT"));
            kh.setDiaChi(rs.getString("DiaChi"));
            kh.setMatKhau(rs.getString("MatKhau")); 

            return kh;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
}
