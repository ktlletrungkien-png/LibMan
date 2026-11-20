package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.ReaderCard1;

public class ReaderCard1DAO extends ConnectionDAO1 {

    /**
     * Sequence Hình 3.9, bước 12-13: kiểm tra thành viên (theo mã sinh viên/cán bộ)
     * đã có thẻ bạn đọc hay chưa. true = đã có thẻ.
     */
    public boolean checkExistCard(String schoolId) {
        boolean exist = false;
        String sql = "SELECT COUNT(*) FROM ReaderCard1 rc "
                + "JOIN SchoolMember1 sm ON sm.id = rc.SchoolMember1id "
                + "WHERE sm.schoolId = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, schoolId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    exist = rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            exist = true;   // lỗi CSDL: không cho phép tạo thẻ
        }
        return exist;                                                   // bước 13
    }

    /**
     * Sequence Hình 3.9, bước 21-22: lưu thẻ bạn đọc vào CSDL và trả về số thẻ vừa cấp
     * (return card number). Trả về null nếu lưu thất bại.
     */
    public String saveReaderCard(ReaderCard1 readerCard) {
        String readerCardNumber = null;
        String sqlInsert = "INSERT INTO ReaderCard1(readerCardNumber, issueDate, expireDate, status, SchoolMember1id) "
                + "VALUES(?, ?, ?, ?, ?)";
        String sqlUpdate = "UPDATE ReaderCard1 SET readerCardNumber = ? WHERE id = ?";
        try {
            con.setAutoCommit(false);
            int id;
            try (PreparedStatement ps = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, "TMP-" + System.nanoTime());            // số thẻ tạm, sẽ cập nhật ngay bên dưới
                ps.setDate(2, readerCard.getIssueDate());
                ps.setDate(3, readerCard.getExpireDate());
                ps.setString(4, readerCard.getStatus());
                ps.setInt(5, readerCard.getSchoolMember().getId());
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    rs.next();
                    id = rs.getInt(1);
                }
            }
            // Số thẻ có dạng TV-<năm cấp>-<id 4 chữ số>, ví dụ TV-2026-0045
            String year = readerCard.getIssueDate().toString().substring(0, 4);
            readerCardNumber = String.format("TV-%s-%04d", year, id);
            try (PreparedStatement ps = con.prepareStatement(sqlUpdate)) {
                ps.setString(1, readerCardNumber);
                ps.setInt(2, id);
                ps.executeUpdate();
            }
            con.commit();
            readerCard.setId(id);
            readerCard.setReaderCardNumber(readerCardNumber);
        } catch (Exception e) {
            e.printStackTrace();
            readerCardNumber = null;
            try {
                con.rollback();
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return readerCardNumber;                                        // bước 22
    }
}
