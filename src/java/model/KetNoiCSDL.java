/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.DriverManager;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class KetNoiCSDL {
     public java.sql.Connection getConnection(){
        String url ="jdbc:mysql://localhost:3306/quanly_thietbiamthanh";
        String user ="root";
        String pass="";
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url,user,pass);
        }catch(Exception e){
            Logger.getLogger(KetNoiCSDL.class.getName())
                    .log(Level.SEVERE, null, e);
        }
        return null;
    
}
}
