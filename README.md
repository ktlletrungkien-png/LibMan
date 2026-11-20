# LibMan – 2 module: Bạn đọc đăng kí làm thẻ bạn đọc / Thống kê tài liệu theo số lần mượn

Web app JSP thuần (không servlet/framework), Maven, Jakarta EE 10 → chạy trên **Tomcat 10.1**, CSDL **MySQL 8**.

## Chạy trong NetBeans
1. Tạo CSDL: mở MySQL Workbench (hoặc `mysql -u root -p`) và chạy file `database/libman.sql`
   (CLI: `mysql -u root -p --default-character-set=utf8mb4 < database/libman.sql`).
2. Sửa mật khẩu MySQL trong `src/main/java/dao/ConnectionDAO1.java` (biến `password`, và `dbUrl` nếu cổng khác 3306).
3. NetBeans → File → Open Project → chọn thư mục `LibMan`.
4. Services → Servers → Add Server → Apache Tomcat (bản 10.1.x). Chuột phải project → Properties → Run → chọn server đó.
5. Chuột phải project → Run. Mở `http://localhost:8080/LibMan/`.

## Dữ liệu thử
- Đăng nhập quản lí: `manager01` / `123456` (vào từ trang `http://localhost:8080/LibMan/` → Đăng nhập quản lí; có nút Đăng xuất).
- Đăng kí thẻ thành công: mã `B23DCCN208`, hạn thẻ ≤ 30/06/2028.
- Đã có thẻ (ngoại lệ): `B23DCCN100`. Mã không tồn tại: nhập mã bất kì khác.
- Thống kê: 01/10/2026 – 31/10/2026 cho kết quả 5 tài liệu, tổng 79 lượt mượn.
- Chạy lại `libman.sql` để trả CSDL về trạng thái ban đầu.

Đối chiếu code ↔ sơ đồ: xem `docs/DoiChieu_SoDo_Code.md`.
