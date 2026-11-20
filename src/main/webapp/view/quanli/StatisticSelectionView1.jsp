<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*" %>
<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chọn loại thống kê</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<%@ include file="topbar.jsp" %>
<h2>Chọn loại thống kê</h2>

<%-- Bước 3: hiển thị. StatisticSelectionView1: selStatisticType : Select, subMaterialBorrowing : submit
     Bước 4-5: chọn loại thống kê "tài liệu theo số lần mượn" và click -> gọi trang MaterialBorrowingStatisticsView1 --%>
<form name="frmSelect" action="MaterialBorrowingStatisticsView1.jsp" method="get">
    <label for="selStatisticType">Loại thống kê</label>
    <select id="selStatisticType" name="selStatisticType">
        <option value="materialBorrowing" selected>Thống kê tài liệu theo số lần mượn</option>
    </select>
    <div>
        <input type="submit" id="subMaterialBorrowing" name="subMaterialBorrowing" value="Chọn">
    </div>
</form>
<%@ include file="footer.jsp" %>
</body>
</html>
