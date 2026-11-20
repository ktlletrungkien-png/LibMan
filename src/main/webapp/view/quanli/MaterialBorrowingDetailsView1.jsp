<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.Date,java.text.SimpleDateFormat,dao.*,model.*" %>
<%@ include file="auth.jsp" %>
<%
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

    // Thuộc tính ẩn: borrowingStatistic : MaterialBorrowingStatistics1, listLoanDetail : LoanDetail1[]
    MaterialBorrowingStatistics1 borrowingStatistic = null;
    LoanDetail1[] listLoanDetail = null;

    String strIndex = request.getParameter("index");
    if (strIndex != null) {
        // Bước 16: nhận "tài liệu thống kê đã chọn" từ trang thống kê
        MaterialBorrowingStatistics1[] listMaterialStatistic =
                (MaterialBorrowingStatistics1[]) session.getAttribute("listMaterialStatistic");
        if (listMaterialStatistic != null) {
            borrowingStatistic = listMaterialStatistic[Integer.parseInt(strIndex)];
            // Bước 17-22: gọi LoanDetail1DAO.getLoanDetailsByMaterialBorrowingStatistics()
            listLoanDetail = (new LoanDetail1DAO()).getLoanDetailsByMaterialBorrowingStatistics(borrowingStatistic);
            session.setAttribute("borrowingStatistic", borrowingStatistic);
            session.setAttribute("listLoanDetail", listLoanDetail);
        }
    } else {
        // Quay lại từ trang chi tiết phiếu mượn: dùng lại dữ liệu đã lấy
        borrowingStatistic = (MaterialBorrowingStatistics1) session.getAttribute("borrowingStatistic");
        listLoanDetail = (LoanDetail1[]) session.getAttribute("listLoanDetail");
    }
    if (borrowingStatistic == null || listLoanDetail == null) {
        response.sendRedirect("StatisticSelectionView1.jsp");
        return;
    }
    String outMaterialTitle = borrowingStatistic.getTitle();
    // Khoảng thời gian thống kê được giữ trong borrowingStatistic, dùng cho link quay lại
    String backUrl = "MaterialBorrowingStatisticsView1.jsp?inStartDate=" + borrowingStatistic.getStartDate()
            + "&inEndDate=" + borrowingStatistic.getEndDate() + "&subViewStatistic=1";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Các lần tài liệu được mượn</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<%@ include file="topbar.jsp" %>
<h2>Các lần tài liệu được mượn</h2>

<%-- Bước 23: hiển thị danh sách các lần mượn.
     MaterialBorrowingDetailsView1: outMaterialTitle : String, tblLoanDetail : Table, subLoanSlipDetail : submit (mỗi dòng của bảng có 1 nút),
     lnkStatisticSelectionView : Link, lnkBack : Link; thuộc tính ẩn: borrowingStatistic, listLoanDetail --%>
<div class="card"><div class="kv one">
    <div><span>Tên tài liệu</span><b id="outMaterialTitle"><%=outMaterialTitle%></b></div>
</div></div>

<form name="frmLoanDetail" action="LoanSlipDetailsView1.jsp" method="get">
<table id="tblLoanDetail">
    <thead>
        <tr><th>STT</th><th>Bản sao</th><th>Hạn trả</th><th>Ngày trả</th><th></th></tr>
    </thead>
    <tbody>
    <% for (int i = 0; i < listLoanDetail.length; i++) { %>
        <tr>
            <td><%=i + 1%></td>
            <td><%=listLoanDetail[i].getMaterialCopy().getId()%></td>
            <td><%=listLoanDetail[i].getExReturnDate() == null ? "—" : df.format(listLoanDetail[i].getExReturnDate())%></td>
            <td><%=listLoanDetail[i].getRealReturnDate() == null ? "—" : df.format(listLoanDetail[i].getRealReturnDate())%></td>
            <%-- Bước 24-25: click nút subLoanSlipDetail ở dòng của một lần mượn -> gọi trang LoanSlipDetailsView1
                 kèm lần mượn (LoanDetail1) đã chọn (giá trị của nút = vị trí dòng trong listLoanDetail) --%>
            <td><button type="submit" class="subLoanSlipDetail" name="subLoanSlipDetail" value="<%=i%>">Xem phiếu mượn</button></td>
        </tr>
    <% } %>
    </tbody>
</table>
</form>

<p class="nav">
    <a id="lnkBack" href="<%=backUrl%>">Quay lại</a>
    <a id="lnkStatisticSelectionView" href="StatisticSelectionView1.jsp">Chọn loại thống kê</a>
</p>
<%@ include file="footer.jsp" %>
</body>
</html>
