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
public class SanPhamDao extends KetNoiCSDL {

    KetNoiCSDL db = new KetNoiCSDL();

    // 🔹 1. HIỂN THỊ (SELECT ALL)
    public List<SanPham> getAll() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM sanpham";

        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

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

        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, maSP);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 5. TÌM KIẾM (SEARCH theo tên)
    public List<SanPham> searchAdvanced(String keyword, Double min, Double max, String sort) {
        return searchAdvanced(keyword, min, max, sort, null);
    }

    public List<SanPham> searchAdvanced(String keyword, Double min, Double max, String sort, String category) {
        List<SanPham> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM SanPham WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (LOWER(MaSP) LIKE ? OR LOWER(TenSP) LIKE ? OR LOWER(PhanLoai) LIKE ?)");
        }

        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND LOWER(PhanLoai) = ?");
        }

        if (min != null) {
            sql.append(" AND DonGia >= ?");
        }

        if (max != null) {
            sql.append(" AND DonGia <= ?");
        }

        if ("asc".equals(sort)) {
            sql.append(" ORDER BY DonGia ASC");
        } else if ("desc".equals(sort)) {
            sql.append(" ORDER BY DonGia DESC");
        }

        try {
            Connection conn = db.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString());

            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String key = "%" + keyword.toLowerCase() + "%";
                ps.setString(index++, key);
                ps.setString(index++, key);
                ps.setString(index++, key);
            }

            if (category != null && !category.trim().isEmpty()) {
                ps.setString(index++, category.trim().toLowerCase());
            }

            if (min != null) {
                ps.setDouble(index++, min);
            }

            if (max != null) {
                ps.setDouble(index++, max);
            }

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

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT PhanLoai FROM SanPham WHERE PhanLoai IS NOT NULL AND TRIM(PhanLoai) <> '' ORDER BY PhanLoai";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("PhanLoai"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public SanPham getById(String maSP) {
        String sql = "SELECT * FROM SanPham WHERE MaSP = ?";
        try {
            Connection conn = db.getConnection();
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
