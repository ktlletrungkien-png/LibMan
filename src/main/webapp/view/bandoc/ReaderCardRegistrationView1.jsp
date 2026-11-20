<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.Date,dao.*,model.*" %>
<%!
    // Chỉ dùng để in lại dữ liệu người dùng nhập, tránh chèn HTML
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    String message = null;
    String inSchoolId = "";
    String strExpireDate = "";

    // Bước 4: bạn đọc nhập mã sinh viên, hạn thẻ và click subRegister (trang tự submit vào chính nó)
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("subRegister") != null) {
        inSchoolId = request.getParameter("inSchoolId").trim();
        strExpireDate = request.getParameter("inExpireDate");
        Date inExpireDate = Date.valueOf(strExpireDate);

        // Bước 5-10: gọi SchoolMember1DAO.getSchoolMemberBySchoolId() lấy thành viên trường
        SchoolMember1 schoolMember = (new SchoolMember1DAO()).getSchoolMemberBySchoolId(inSchoolId);

        if (schoolMember == null) {
            message = "Không tìm thấy thành viên trường có mã " + inSchoolId + ".";
        } else if (inExpireDate.after(schoolMember.getValidUntil())) {
            // xử lí nhỏ tại giao diện (không phải bước riêng trong sequence): hạn thẻ <= hạn thành viên
            message = "Hạn thẻ không được vượt quá thời hạn của thành viên trường.";
        } else {
            // Bước 11-13: gọi ReaderCard1DAO.checkExistCard() kiểm tra đã có thẻ chưa
            boolean existCard = (new ReaderCard1DAO()).checkExistCard(inSchoolId);
            if (existCard) {
                message = "Thành viên này đã có thẻ bạn đọc.";
            } else {
                // Bước 14: gọi trang Confirm kèm thông tin thành viên và hạn thẻ
                session.setAttribute("schoolMember", schoolMember);
                session.setAttribute("expireDate", inExpireDate);
                response.sendRedirect("ReaderCardConfirmationView1.jsp");
                return;
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng ký làm thẻ bạn đọc</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<%@ include file="topbar.jsp" %>
<h2>Đăng ký làm thẻ bạn đọc</h2>

<%-- Bước 3: hiển thị form. ReaderCardRegistrationView1: inSchoolId : String, inExpireDate : date, subRegister : submit --%>
<form name="frmRegister" action="ReaderCardRegistrationView1.jsp" method="post">
    <label for="inSchoolId">Mã sinh viên / mã cán bộ</label>
    <input type="text" id="inSchoolId" name="inSchoolId" value="<%=esc(inSchoolId)%>" required>

    <label for="inExpireDate">Ngày hết hạn thẻ</label>
    <input type="date" id="inExpireDate" name="inExpireDate" value="<%=esc(strExpireDate)%>" required>

    <div>
        <input type="submit" id="subRegister" name="subRegister" value="Thêm">
    </div>
</form>
<% if (message != null) { %>
<p class="error"><%=message%></p>
<% } %>
<%@ include file="footer.jsp" %>
</body>
</html>
