/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;
/**
 *
 * @author ASUS
 */
public class SanPhamDao extends KetNoiCSDL{
    KetNoiCSDL db = new KetNoiCSDL();

    // 🔹 1. HIỂN THỊ (SELECT ALL)
    public List<SanPham> getAll() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM sanpham";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SanPham sp = new SanPham(
                        rs.getString("MaSP"),
                        rs.getString("TenSP"),
                        rs.getString("PhanLoai"),
                        rs.getDouble("DonGia"),
                        rs.getInt("SoLuong"),
                        rs.getString("MoTa"),
                        rs.getString("HinhAnh")
                );
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🔹 2. THÊM (INSERT)
    public boolean insert(SanPham sp) {
        String sql = "INSERT INTO sanpham VALUES (?,?,?,?,?,?,?)";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, sp.getMaSP());
            ps.setString(2, sp.getTenSP());
            ps.setString(3, sp.getPhanLoai());
            ps.setDouble(4, sp.getDonGia());
            ps.setInt(5, sp.getSoLuong());
            ps.setString(6, sp.getMoTa());
            ps.setString(7, sp.getHinhAnh());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 3. SỬA (UPDATE)
    public boolean update(SanPham sp) {
        String sql = "UPDATE sanpham SET TenSP=?, PhanLoai=?, DonGia=?, SoLuong=?, MoTa=?, HinhAnh=? WHERE MaSP=?";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, sp.getTenSP());
            ps.setString(2, sp.getPhanLoai());
            ps.setDouble(3, sp.getDonGia());
            ps.setInt(4, sp.getSoLuong());
            ps.setString(5, sp.getMoTa());
            ps.setString(6, sp.getHinhAnh());
            ps.setString(7, sp.getMaSP());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 4. XÓA (DELETE)
    public boolean delete(String maSP) {
        String sql = "DELETE FROM sanpham WHERE MaSP=?";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, maSP);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 5. TÌM KIẾM (SEARCH theo tên)
    public List<SanPham> searchByName(String keyword) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM sanpham WHERE TenSP LIKE ?";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SanPham sp = new SanPham(
                        rs.getString("MaSP"),
                        rs.getString("TenSP"),
                        rs.getString("PhanLoai"),
                        rs.getDouble("DonGia"),
                        rs.getInt("SoLuong"),
                        rs.getString("MoTa"),
                        rs.getString("HinhAnh")
                );
                list.add(sp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; 
    }
    public SanPham getById(String maSP) {
    String sql = "SELECT * FROM SanPham WHERE MaSP = ?";
    try {Connection conn = db.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, maSP);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new SanPham(
                rs.getString("MaSP"),
                rs.getString("TenSP"),
                rs.getString("PhanLoai"),
                rs.getDouble("DonGia"),
                rs.getInt("SoLuong"),
                rs.getString("MoTa"),
                rs.getString("HinhAnh")
            );
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
}

