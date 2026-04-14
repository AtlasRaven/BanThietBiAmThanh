/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */

public class SanPham {
    private String MaSP;
    private String TenSP;
    private String PhanLoai;
    private double DonGia;
    private int SoLuong;
    private String MoTa;
    private String HinhAnh;

    public SanPham() {
    }

    public SanPham(String MaSP, String TenSP,String PhanLoai, double DonGia, int SoLuong, String MoTa, String HinhAnh) {
        this.MaSP = MaSP;
        this.TenSP = TenSP;
        this.PhanLoai = PhanLoai;
        this.DonGia = DonGia;
        this.SoLuong = SoLuong;
        this.MoTa = MoTa;
        this.HinhAnh = HinhAnh;
    }

    public String getMaSP() {
        return MaSP;
    }

    public String getTenSP() {
        return TenSP;
    }

    public String getPhanLoai() {
        return PhanLoai;
    }

    public void setPhanLoai(String PhanLoai) {
        this.PhanLoai = PhanLoai;
    }

    public double getDonGia() {
        return DonGia;
    }

    public int getSoLuong() {
        return SoLuong;
    }

    public String getMoTa() {
        return MoTa;
    }

    public String getHinhAnh() {
        return HinhAnh;
    }

    public void setMaSP(String MaSP) {
        this.MaSP = MaSP;
    }

    public void setTenSP(String TenSP) {
        this.TenSP = TenSP;
    }

    public void setDonGia(double DonGia) {
        this.DonGia = DonGia;
    }

    public void setSoLuong(int SoLuong) {
        this.SoLuong = SoLuong;
    }

    public void setMoTa(String MoTa) {
        this.MoTa = MoTa;
    }

    public void setHinhAnh(String HinhAnh) {
        this.HinhAnh = HinhAnh;
    }
}
