<%-- Kiểm tra đăng nhập cho mọi trang của gói quanli (include tĩnh ở đầu mỗi trang).
     Chưa đăng nhập hoặc hết phiên -> về trang đăng nhập. Chức năng đăng nhập/đăng xuất nằm ngoài sơ đồ lớp. --%>
<%
    model.Member1 loggedManager = (model.Member1) session.getAttribute("manager");
    if (loggedManager == null) {
        response.sendRedirect(request.getContextPath() + "/view/thanhvien/LoginView1.jsp?err=timeout");
        return;
    }
%>
