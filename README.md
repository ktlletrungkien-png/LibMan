# LibMan

Bài tập môn Phân tích thiết kế hệ thống (mã đề 4) – hệ thống quản lý thư viện LibMan, gồm 2 module:

1. **Bạn đọc đăng kí làm thẻ bạn đọc**
2. **Thống kê tài liệu theo số lần mượn** (nhân viên quản lí)

## Công nghệ
Java 17+, JSP thuần (không servlet, không framework), Maven (đóng gói war), Jakarta EE 10, Apache Tomcat 10.1, MySQL 8 (Connector/J 8.4.0), NetBeans.

## Cấu trúc source
| Thư mục | Nội dung |
|---|---|
| `src/main/java/model` | Các lớp thực thể (tên lớp có hậu tố `1`) |
| `src/main/java/dao` | `ConnectionDAO1` (kết nối CSDL) và các lớp DAO kế thừa nó |
| `src/main/webapp/view/bandoc` | Giao diện module 1 (đăng kí làm thẻ bạn đọc) |
| `src/main/webapp/view/quanli` | Giao diện module 2 (thống kê tài liệu theo số lần mượn) |
| `src/main/webapp/view/thanhvien` | Đăng nhập / đăng xuất (tiền điều kiện của module 2) |

Quy ước theo thiết kế: mỗi lớp giao diện trong sơ đồ là một trang JSP cùng tên (ví dụ `ReaderCardRegistrationView1.jsp`); `id` và `name` của các phần tử HTML trùng tên thuộc tính trong sơ đồ lớp.

## Chạy chương trình
1. Tạo CSDL MySQL tên `libman` theo sơ đồ CSDL của báo cáo (script CSDL không đưa lên repository).
2. Sửa thông tin kết nối (`dbUrl`, `username`, `password`) trong `src/main/java/dao/ConnectionDAO1.java`.
3. Mở project bằng NetBeans, gắn Apache Tomcat 10.1 rồi Run.
4. Truy cập `http://localhost:8080/LibMan/`.
