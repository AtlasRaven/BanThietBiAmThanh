/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class CartItem {
    private SanPham sp;   // sản phẩm
    private int soLuong;  // số lượng

    public CartItem(SanPham sp, int soLuong) {
        this.sp = sp;
        this.soLuong = soLuong;
    }

    public SanPham getSp() {
        return sp;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    // 👉 tính tiền từng dòng
    public double getThanhTien() {
        return sp.getDonGia() * soLuong;
    }
}
