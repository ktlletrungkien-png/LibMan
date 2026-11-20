package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Account1;
import model.Member1;
import model.Role1;

/**
 * Chức năng đăng nhập (ngoài sơ đồ lớp của 2 module, theo thống nhất).
 * Mật khẩu lưu trong CSDL dạng SHA-256 (hex), so sánh bằng SHA2(?,256).
 */
public class Member1DAO extends ConnectionDAO1 {

    /**
     * Kiểm tra tài khoản. Trả về thành viên (kèm account và role) nếu đúng tên đăng nhập,
     * mật khẩu và tài khoản đang hoạt động; trả về null nếu sai.
     */
    public Member1 checkLogin(String username, String password) {
        Member1 member = null;
        String sql = "SELECT m.id, m.fullName, m.dob, m.gender, m.idCardNumber, m.address, m.email, m.phone, "
                + "       a.id AS accId, a.username, a.accountStatus, "
                + "       r.id AS roleId, r.roleName, r.permission "
                + "FROM Account1 a "
                + "JOIN Member1 m ON m.Account1id = a.id "
                + "JOIN Role1 r ON r.id = a.Role1id "
                + "WHERE a.username = ? AND a.password = SHA2(?, 256) AND a.accountStatus = 'active'";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    member = new Member1();
                    member.setId(rs.getInt("id"));
                    member.setFullName(rs.getString("fullName"));
                    member.setDob(rs.getDate("dob"));
                    member.setGender(rs.getString("gender"));
                    member.setIdCardNumber(rs.getString("idCardNumber"));
                    member.setAddress(rs.getString("address"));
                    member.setEmail(rs.getString("email"));
                    member.setPhone(rs.getString("phone"));
                    Role1 role = new Role1();
                    role.setId(rs.getInt("roleId"));
                    role.setRoleName(rs.getString("roleName"));
                    role.setPermission(rs.getString("permission"));
                    Account1 account = new Account1();
                    account.setId(rs.getInt("accId"));
                    account.setUsername(rs.getString("username"));
                    account.setAccountStatus(rs.getString("accountStatus"));
                    account.setRole(role);              // không nạp mật khẩu vào đối tượng
                    member.setAccount(account);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            member = null;
        }
        return member;
    }
}
