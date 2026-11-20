<%-- Banner của gói quanli, theo Hình 3.4: LibMan + tên người đăng nhập + nút Đăng xuất
     (không thuộc sơ đồ lớp, theo thống nhất). Mở khung trang, đóng ở footer.jsp. --%>
<div class="scr">
<div class="hd">
    <b>LibMan</b>
    <form name="frmLogout" action="<%=request.getContextPath()%>/view/thanhvien/Logout.jsp" method="post">
        <span>Nhân viên quản lí: <b style="font-size:15px"><%=loggedManager.getFullName()%></b></span>
        <input type="submit" id="subLogout" name="subLogout" value="Đăng xuất">
    </form>
</div>
<div class="bd">
