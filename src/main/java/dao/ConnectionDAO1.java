package dao;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Lớp cha của mọi lớp DAO (Hình 3.5, Hình 3.6): giữ thuộc tính con : Connection
 * và constructor ConnectionDAO1() tạo kết nối tới CSDL.
 */
public class ConnectionDAO1 {
    // Sơ đồ lớp: con : Connection (public, các DAO con dùng chung 1 kết nối cho cả ứng dụng,
    // giống lớp DAO trong giáo trình).
    public static Connection con;

    public ConnectionDAO1() {
        try {
            if (con == null || con.isClosed() || !con.isValid(2)) {
                // ====== SỬA CHO PHÙ HỢP MÁY CỦA BẠN ======
                String dbUrl = "jdbc:mysql://localhost:3306/libman"
                        + "?useSSL=false&allowPublicKeyRetrieval=true"
                        + "&serverTimezone=Asia/Ho_Chi_Minh&characterEncoding=UTF-8";
                String dbClass = "com.mysql.cj.jdbc.Driver";
                String username = "root";
                String password = "123456";   // <-- mật khẩu MySQL của bạn
                // =========================================
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, username, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
