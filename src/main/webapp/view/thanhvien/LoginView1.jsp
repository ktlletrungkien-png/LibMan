<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao.*,model.*" %>
<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    String message = null;
    String inUsername = "";
    if ("timeout".equals(request.getParameter("err"))) {
        message = "Hết phiên làm việc hoặc chưa đăng nhập. Vui lòng đăng nhập!";
    }

    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("subLogin") != null) {
        inUsername = request.getParameter("inUsername").trim();
        String inPassword = request.getParameter("inPassword");
        Member1DAO member1DAO = new Member1DAO();
        Member1 member = member1DAO.checkLogin(inUsername, inPassword);
        if (ConnectionDAO1.con == null) {
            message = "Không kết nối được CSDL. Kiểm tra mật khẩu MySQL trong ConnectionDAO1.java và MySQL đã chạy chưa.";
        } else if (member == null) {
            message = "Sai tên đăng nhập hoặc mật khẩu!";
        } else if ("Manager".equalsIgnoreCase(member.getAccount().getRole().getRoleName())) {
            request.changeSessionId();                       // chống fixation phiên
            session.setAttribute("manager", member);
            response.sendRedirect("../quanli/ManagerHomeView1.jsp");   // vào trang chủ quản lí
            return;
        } else {
            message = "Tài khoản không có quyền truy cập chức năng quản lí.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<div class="scr">
<div class="hd"><b>LibMan</b></div>
<div class="bd">
<h2>Đăng nhập</h2>
<form name="frmLogin" action="LoginView1.jsp" method="post">
    <label for="inUsername">Tên đăng nhập</label>
    <input type="text" id="inUsername" name="inUsername" value="<%=esc(inUsername)%>" required>

    <label for="inPassword">Mật khẩu</label>
    <input type="password" id="inPassword" name="inPassword" required>

    <div>
        <input type="submit" id="subLogin" name="subLogin" value="Đăng nhập">
    </div>
</form>
<% if (message != null) { %>
<p class="error"><%=message%></p>
<% } %>
</div>
</div>
</body>
</html>
