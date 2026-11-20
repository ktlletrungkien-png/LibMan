<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.text.SimpleDateFormat,dao.*,model.*" %>
<%@ include file="auth.jsp" %>
<%
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

    // Thuộc tính ẩn loanDetail : LoanDetail1 - lần mượn đã chọn ở trang trước (bước 25)
    LoanDetail1 loanDetail = null;
    String strIndex = request.getParameter("subLoanSlipDetail");   // vị trí dòng của nút subLoanSlipDetail đã click
    if (strIndex != null) {
        LoanDetail1[] listLoanDetail = (LoanDetail1[]) session.getAttribute("listLoanDetail");
        if (listLoanDetail != null) {
            loanDetail = listLoanDetail[Integer.parseInt(strIndex)];
            session.setAttribute("loanDetail", loanDetail);
        }
    } else {
        loanDetail = (LoanDetail1) session.getAttribute("loanDetail");
    }
    if (loanDetail == null) {
        response.sendRedirect("StatisticSelectionView1.jsp");
        return;
    }

    // Bước 26-31: gọi LoanSlip1DAO.getLoanSlipByLoanDetail()
    LoanSlip1 outLoanSlip = (new LoanSlip1DAO()).getLoanSlipByLoanDetail(loanDetail);
    if (outLoanSlip == null) {
        response.sendRedirect("StatisticSelectionView1.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết phiếu mượn</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<%@ include file="topbar.jsp" %>
<h2>Chi tiết phiếu mượn</h2>

<%-- Bước 32: hiển thị chi tiết phiếu mượn.
     LoanSlipDetailsView1: outLoanSlip : LoanSlip1, lnkBorrowingDetailsView : Link, tblLoanDetail : Table;
     thuộc tính ẩn: loanDetail : LoanDetail1 --%>
<div class="card" id="outLoanSlip"><div class="kv">
    <div><span>Mã phiếu</span><%=outLoanSlip.getId()%></div>
    <div><span>Ngày mượn</span><%=df.format(outLoanSlip.getDate())%></div>
    <div><span>Bạn đọc</span><%=outLoanSlip.getReaderCard().getSchoolMember().getName()%></div>
    <div><span>Số thẻ</span><%=outLoanSlip.getReaderCard().getReaderCardNumber()%></div>
    <div class="full"><span>Nhân viên lập phiếu</span><%=outLoanSlip.getLibrarian().getFullName()%></div>
</div></div>

<table id="tblLoanDetail">
    <thead>
        <tr><th>Bản sao</th><th>Tài liệu</th><th>Hạn trả</th></tr>
    </thead>
    <tbody>
    <% for (LoanDetail1 ld : outLoanSlip.getLoanDetails()) { %>
        <tr>
            <td><%=ld.getMaterialCopy().getId()%></td>
            <td><%=ld.getMaterialCopy().getMaterial().getTitle()%></td>
            <td><%=ld.getExReturnDate() == null ? "—" : df.format(ld.getExReturnDate())%></td>
        </tr>
    <% } %>
    </tbody>
</table>

<p><a id="lnkBorrowingDetailsView" href="MaterialBorrowingDetailsView1.jsp">Quay lại</a></p>
<%@ include file="footer.jsp" %>
</body>
</html>
