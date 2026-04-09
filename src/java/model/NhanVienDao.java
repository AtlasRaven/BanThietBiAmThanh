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
public class NhanVienDao extends KetNoiCSDL {
    public NhanVien login(String tk, String mk) {
    String sql = "SELECT * FROM nhanvien WHERE TaiKhoan=? AND MatKhau=?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, tk);
        ps.setString(2, mk);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            NhanVien nv = new NhanVien();
            nv.setMaNV(rs.getString("MaNV"));
            nv.setTenNV(rs.getString("TenNV"));
            nv.setChucVu(rs.getString("ChucVu"));
            nv.setTaiKhoan(rs.getString("TaiKhoan"));
            nv.setMatKhau(rs.getString("MatKhau"));
            return nv;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
}
