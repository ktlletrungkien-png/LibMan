package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.SchoolMember1;

public class SchoolMember1DAO extends ConnectionDAO1 {

    /**
     * Sequence Hình 3.9, bước 6-9: lấy thành viên trường theo mã sinh viên/cán bộ,
     * đóng gói vào thực thể SchoolMember1 (bước 8: SchoolMember1()), trả về (bước 9-10).
     */
    public SchoolMember1 getSchoolMemberBySchoolId(String schoolId) {
        SchoolMember1 schoolMember = null;
        String sql = "SELECT id, schoolId, name, schoolEmail, role, dob, validUntil "
                + "FROM SchoolMember1 WHERE schoolId = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, schoolId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    schoolMember = new SchoolMember1();                 // bước 8
                    schoolMember.setId(rs.getInt("id"));
                    schoolMember.setSchoolId(rs.getString("schoolId"));
                    schoolMember.setName(rs.getString("name"));
                    schoolMember.setSchoolEmail(rs.getString("schoolEmail"));
                    schoolMember.setRole(rs.getString("role"));
                    schoolMember.setDob(rs.getDate("dob"));
                    schoolMember.setValidUntil(rs.getDate("validUntil"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            schoolMember = null;
        }
        return schoolMember;                                            // bước 9-10
    }
}
