<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Đăng xuất: huỷ phiên rồi về trang đăng nhập
    session.invalidate();
    response.sendRedirect("LoginView1.jsp");
%>
