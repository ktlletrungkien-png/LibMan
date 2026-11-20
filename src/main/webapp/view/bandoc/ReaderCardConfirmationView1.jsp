<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.Date,java.text.SimpleDateFormat,dao.*,model.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

    // Dữ liệu nhận từ trang Registration (bước 14)
    SchoolMember1 outSchoolMember = (SchoolMember1) session.getAttribute("schoolMember");
    Date outExpireDate = (Date) session.getAttribute("expireDate");
    if (outSchoolMember == null || outExpireDate == null) {
        response.sendRedirect("ReaderCardRegistrationView1.jsp");
        return;
    }
    Date outIssueDate = new Date(System.currentTimeMillis());   // ngày cấp = ngày hiện tại
    ReaderCard1 readerCard = null;                               // thuộc tính ẩn readerCard : ReaderCard1
    String message = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (request.getParameter("subBack") != null) {
            // click Quay lại: trở về trang đăng kí
            response.sendRedirect("ReaderCardRegistrationView1.jsp");
            return;
        }
        if (request.getParameter("subConfirm") != null) {
            // Bước 16-19: click Xác nhận -> gọi lớp ReaderCard1 đóng gói thông tin thẻ
            readerCard = new ReaderCard1();                      // bước 18: ReaderCard1()
            readerCard.setSchoolMember(outSchoolMember);
            readerCard.setIssueDate(outIssueDate);
            readerCard.setExpireDate(outExpireDate);
            readerCard.setStatus("ACTIVE");

            // Bước 20-22: gọi ReaderCard1DAO.saveReaderCard() lưu thẻ, nhận lại số thẻ
            String readerCardNumber = (new ReaderCard1DAO()).saveReaderCard(readerCard);
            if (readerCardNumber != null) {
                // Bước 23: gọi trang Result kèm thẻ vừa lưu (số thẻ nằm trong readerCard)
                session.setAttribute("readerCard", readerCard);
                response.sendRedirect("ReaderCardResultView1.jsp");
                return;
            }
            message = "Lưu thẻ bạn đọc không thành công, vui lòng thử lại.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác nhận thông tin đăng ký</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<%@ include file="topbar.jsp" %>
<h2>Xác nhận thông tin đăng ký</h2>

<%-- Bước 15: hiển thị xác nhận.
     ReaderCardConfirmationView1: outSchoolMember : SchoolMember1, outIssueDate : date, outExpireDate : date,
     subConfirm : submit, subBack : submit; thuộc tính ẩn: readerCard : ReaderCard1 (biến Java ở trên) --%>
<div class="card" id="outSchoolMember"><div class="kv">
    <div><span>Mã sinh viên</span><%=outSchoolMember.getSchoolId()%></div>
    <div><span>Họ và tên</span><%=outSchoolMember.getName()%></div>
    <div><span>Email trường</span><%=outSchoolMember.getSchoolEmail()%></div>
    <div><span>Ngày sinh</span><%=df.format(outSchoolMember.getDob())%></div>
    <div><span>Vai trò</span><%=outSchoolMember.getRole()%></div>
    <div><span>Có giá trị đến</span><%=df.format(outSchoolMember.getValidUntil())%></div>
</div></div>
<div class="card"><div class="kv">
    <div><span>Ngày cấp</span><b id="outIssueDate" style="font-weight:400"><%=df.format(outIssueDate)%></b></div>
    <div><span>Ngày hết hạn</span><b id="outExpireDate" style="font-weight:400"><%=df.format(outExpireDate)%></b></div>
</div></div>

<form name="frmConfirm" action="ReaderCardConfirmationView1.jsp" method="post">
    <input type="submit" id="subConfirm" name="subConfirm" value="Xác nhận">
    <input type="submit" id="subBack" name="subBack" class="btn2" value="Quay lại" formnovalidate>
</form>
<% if (message != null) { %>
<p class="error"><%=message%></p>
<% } %>
<%@ include file="footer.jsp" %>
</body>
</html>
