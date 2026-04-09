/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class DonHang {
     private String MaDH;
    private String MaKH;
    private String MaNV;
    private Date NgayDat;
    private String TrangThai;
    private double TongTien;

    public DonHang() {
    }

    public DonHang(String MaDH, String MaKH, String MaNV, Date NgayDat, String TrangThai, double TongTien) {
        this.MaDH = MaDH;
        this.MaKH = MaKH;
        this.MaNV = MaNV;
        this.NgayDat = NgayDat;
        this.TrangThai = TrangThai;
        this.TongTien = TongTien;
    }

    public String getMaDH() {
        return MaDH;
    }

    public String getMaKH() {
        return MaKH;
    }

    public String getMaNV() {
        return MaNV;
    }

    public Date getNgayDat() {
        return NgayDat;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public double getTongTien() {
        return TongTien;
    }

    public void setMaDH(String MaDH) {
        this.MaDH = MaDH;
    }

    public void setMaKH(String MaKH) {
        this.MaKH = MaKH;
    }

    public void setMaNV(String MaNV) {
        this.MaNV = MaNV;
    }

    public void setNgayDat(Date NgayDat) {
        this.NgayDat = NgayDat;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public void setTongTien(double TongTien) {
        this.TongTien = TongTien;
    }
}
