/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class NhanVien {
    private  String MaNV;
    private String TenNV;
    private String ChucVu;
    private String TaiKhoan;
    private String MatKhau;

    public NhanVien() {
    }

    public NhanVien(String MaNV, String TenNV, String ChucVu, String TaiKhoan, String MatKhau) {
        this.MaNV = MaNV;
        this.TenNV = TenNV;
        this.ChucVu = ChucVu;
        this.TaiKhoan = TaiKhoan;
        this.MatKhau = MatKhau;
    }

    public String getMaNV() {
        return MaNV;
    }

    public String getTenNV() {
        return TenNV;
    }

    public String getChucVu() {
        return ChucVu;
    }

    public String getTaiKhoan() {
        return TaiKhoan;
    }

    public String getMatKhau() {
        return MatKhau;
    }

    public void setMaNV(String MaNV) {
        this.MaNV = MaNV;
    }

    public void setTenNV(String TenNV) {
        this.TenNV = TenNV;
    }

    public void setChucVu(String ChucVu) {
        this.ChucVu = ChucVu;
    }

    public void setTaiKhoan(String TaiKhoan) {
        this.TaiKhoan = TaiKhoan;
    }

    public void setMatKhau(String MatKhau) {
        this.MatKhau = MatKhau;
    }
}
