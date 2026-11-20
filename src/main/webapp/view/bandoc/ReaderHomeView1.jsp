<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ bạn đọc</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<%@ include file="topbar.jsp" %>
<h2>Trang chủ bạn đọc</h2>

<%-- ReaderHomeView1: subRegisterReaderCard : submit (sequence bước 1-2: click đăng kí -> gọi trang Register) --%>
<form name="frmHome" action="ReaderCardRegistrationView1.jsp" method="get">
    <input type="submit" id="subRegisterReaderCard" name="subRegisterReaderCard" value="Đăng ký làm thẻ bạn đọc">
</form>
<%@ include file="footer.jsp" %>
</body>
</html>
