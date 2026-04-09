/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class ChiTietDonHang {

    private String MaDH;
    private String MaSP;
    private int SoLuong;
    private double DonGia;

    public ChiTietDonHang() {
    }

    public ChiTietDonHang(String MaDH, String MaSP, int SoLuong, double DonGia) {
        this.MaDH = MaDH;
        this.MaSP = MaSP;
        this.SoLuong = SoLuong;
        this.DonGia = DonGia;
    }

    public String getMaDH() {
        return MaDH;
    }

    public String getMaSP() {
        return MaSP;
    }

    public int getSoLuong() {
        return SoLuong;
    }

    public double getDonGia() {
        return DonGia;
    }

    public void setMaDH(String MaDH) {
        this.MaDH = MaDH;
    }

    public void setMaSP(String MaSP) {
        this.MaSP = MaSP;
    }

    public void setSoLuong(int SoLuong) {
        this.SoLuong = SoLuong;
    }

    public void setDonGia(double DonGia) {
        this.DonGia = DonGia;
    }

}
