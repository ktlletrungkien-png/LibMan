<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*" %>
<%
    // Thuộc tính ẩn readerCard : ReaderCard1, nhận từ trang Confirm (bước 23)
    ReaderCard1 readerCard = (ReaderCard1) session.getAttribute("readerCard");
    if (readerCard == null) {
        response.sendRedirect("ReaderHomeView1.jsp");
        return;
    }
    String outReaderCardNumber = readerCard.getReaderCardNumber();

    // Kết thúc luồng đăng kí: dọn dữ liệu tạm trong session
    session.removeAttribute("schoolMember");
    session.removeAttribute("expireDate");
    session.removeAttribute("readerCard");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kết quả đăng ký</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/libman.css?v=2">
</head>
<body>
<%@ include file="topbar.jsp" %>
<h2>Kết quả đăng ký</h2>

<%-- Bước 24: hiển thị kết quả kèm số thẻ.
     ReaderCardResultView1: outReaderCardNumber : String, lnkHome : Link; thuộc tính ẩn: readerCard : ReaderCard1 --%>
<div class="card ok">Đăng ký thẻ bạn đọc thành công</div>
<div class="card"><div class="kv one">
    <div><span>Số thẻ bạn đọc</span><b id="outReaderCardNumber" style="font-size:25px;color:#17325C"><%=outReaderCardNumber%></b></div>
</div></div>
<%-- Bước 25-26: click Trở về trang chủ -> gọi trang Home --%>
<a id="lnkHome" href="ReaderHomeView1.jsp">Trở về trang chủ</a>
<%@ include file="footer.jsp" %>
</body>
</html>
