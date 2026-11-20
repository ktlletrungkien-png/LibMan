<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LibMan</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<h2>LibMan - điểm vào để chạy thử 2 module</h2>
<p>(Trang này chỉ để thử; đăng nhập chưa thuộc phạm vi 2 module.)</p>
<ul>
    <li><a href="view/bandoc/ReaderHomeView1.jsp">Trang chủ bạn đọc</a> (module Bạn đọc đăng kí làm thẻ bạn đọc)</li>
    <li><a href="view/thanhvien/LoginView1.jsp">Đăng nhập quản lí</a> (manager01 / 123456; sau đó vào trang chủ quản lí; module Thống kê tài liệu theo số lần mượn)</li>
</ul>
</body>
</html>
