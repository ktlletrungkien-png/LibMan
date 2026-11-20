<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*" %>
<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ quản lí</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<%@ include file="topbar.jsp" %>
<h2>Trang chủ quản lí</h2>

<%-- ManagerHomeView1: subViewStatistic : submit (sequence bước 1-2: click xem thống kê -> gọi trang StatSelect) --%>
<form name="frmHome" action="StatisticSelectionView1.jsp" method="get">
    <input type="submit" id="subViewStatistic" name="subViewStatistic" value="Xem báo cáo">
</form>
<%@ include file="footer.jsp" %>
</body>
</html>
