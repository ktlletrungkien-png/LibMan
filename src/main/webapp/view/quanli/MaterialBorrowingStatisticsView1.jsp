<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.Date,java.text.SimpleDateFormat,dao.*,model.*" %>
<%@ include file="auth.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    String strStart = request.getParameter("inStartDate");
    String strEnd = request.getParameter("inEndDate");
    String message = null;

    // Thuộc tính ẩn listMaterialStatistic : MaterialBorrowingStatistics1[]
    MaterialBorrowingStatistics1[] listMaterialStatistic = null;

    // Bước 7: nhập khoảng thời gian và click subViewStatistic (trang tự submit vào chính nó)
    if (strStart != null && !strStart.isEmpty() && strEnd != null && !strEnd.isEmpty()) {
        Date inStartDate = Date.valueOf(strStart);
        Date inEndDate = Date.valueOf(strEnd);
        if (inEndDate.before(inStartDate)) {
            message = "Ngày kết thúc phải sau hoặc bằng ngày bắt đầu.";
        } else {
            // Bước 8-13: gọi MaterialBorrowingStatistics1DAO.getMaterialBorrowingStatistics()
            listMaterialStatistic = (new MaterialBorrowingStatistics1DAO()).getMaterialBorrowingStatistics(inStartDate, inEndDate);
            // giữ danh sách để bước 15-16 lấy "tài liệu thống kê đã chọn" truyền sang trang chi tiết
            session.setAttribute("listMaterialStatistic", listMaterialStatistic);
        }
    }

    // ===== TÍNH TỔNG TẠI TRANG NÀY (không có lớp/hàm riêng trong sơ đồ lớp) =====
    // outTotalMaterial     : tổng số tài liệu    = số phần tử của listMaterialStatistic
    // outTotalBorrowCount  : tổng số lượt mượn   = cộng borrowCount của từng phần tử
    int outTotalMaterial = 0;
    int outTotalBorrowCount = 0;
    if (listMaterialStatistic != null) {
        outTotalMaterial = listMaterialStatistic.length;
        for (MaterialBorrowingStatistics1 stat : listMaterialStatistic) {
            outTotalBorrowCount += stat.getBorrowCount();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thống kê tài liệu</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<%@ include file="topbar.jsp" %>
<h2>Thống kê tài liệu</h2>

<%-- Bước 6: hiển thị form. MaterialBorrowingStatisticsView1: inStartDate : date, inEndDate : date,
     subViewStatistic : submit, tblMaterialStatistic : Table, lnkStatisticSelectionView : Link,
     lnkMaterialBorrowingDetails : Link, outTotalMaterial : integer, outTotalBorrowCount : integer --%>
<form name="frmStatistic" action="MaterialBorrowingStatisticsView1.jsp" method="get">
    <div class="row2">
        <div>
            <label for="inStartDate">Ngày bắt đầu</label>
            <input type="date" id="inStartDate" name="inStartDate" value="<%=strStart == null ? "" : strStart%>" required>
        </div>
        <div>
            <label for="inEndDate">Ngày kết thúc</label>
            <input type="date" id="inEndDate" name="inEndDate" value="<%=strEnd == null ? "" : strEnd%>" required>
        </div>
    </div>

    <div class="actions">
        <input type="submit" id="subViewStatistic" name="subViewStatistic" value="Xem thống kê">
        <%-- lnkStatisticSelectionView: quay lại màn hình chọn loại thống kê --%>
        <a id="lnkStatisticSelectionView" href="StatisticSelectionView1.jsp">Quay lại</a>
    </div>
</form>
<% if (message != null) { %>
<p class="error"><%=message%></p>
<% } %>

<%-- Bước 14: hiển thị bảng thống kê cùng tổng số tài liệu và tổng số lượt mượn --%>
<% if (listMaterialStatistic != null) { %>
<table id="tblMaterialStatistic">
    <thead>
        <tr><th>STT</th><th>Tên tài liệu</th><th class="num">Lượt mượn</th></tr>
    </thead>
    <tbody>
    <% for (int i = 0; i < listMaterialStatistic.length; i++) { %>
        <tr>
            <td><%=i + 1%></td>
            <%-- Bước 15-16: click một tài liệu -> gọi trang MaterialBorrowingDetailsView1 kèm tài liệu đã chọn --%>
            <td><a class="lnkMaterialBorrowingDetails" href="MaterialBorrowingDetailsView1.jsp?index=<%=i%>"><%=listMaterialStatistic[i].getTitle()%></a></td>
            <td class="num"><%=listMaterialStatistic[i].getBorrowCount()%></td>
        </tr>
    <% } %>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="2">Tổng cộng: <span id="outTotalMaterial"><%=outTotalMaterial%></span> tài liệu</td>
            <td class="num"><span id="outTotalBorrowCount"><%=outTotalBorrowCount%></span></td>
        </tr>
    </tfoot>
</table>
<% } %>
<%@ include file="footer.jsp" %>
</body>
</html>
