package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.MaterialBorrowingStatistics1;

public class MaterialBorrowingStatistics1DAO extends ConnectionDAO1 {

    public MaterialBorrowingStatistics1DAO() {
        super();
    }

    /**
     * Sequence Hình 3.10, bước 9-13: thống kê tài liệu theo số lần mượn trong [startDate, endDate].
     * Số lần mượn (borrowCount) và thứ tự giảm dần theo số lần mượn được tính ngay trong câu truy vấn;
     * mỗi dòng kết quả đóng gói vào một MaterialBorrowingStatistics1 (bước 11).
     * Tổng số tài liệu / tổng số lượt mượn KHÔNG tính ở đây mà tính ở trang
     * MaterialBorrowingStatisticsView1.jsp (outTotalMaterial, outTotalBorrowCount).
     */
    public MaterialBorrowingStatistics1[] getMaterialBorrowingStatistics(Date startDate, Date endDate) {
        ArrayList<MaterialBorrowingStatistics1> list = new ArrayList<>();
        String sql = "SELECT m.id, m.title, m.author, m.publisher, m.publishYear, m.description, "
                + "       COUNT(ld.id) AS borrowCount "
                + "FROM Material1 m "
                + "JOIN MaterialCopy1 mc ON mc.Material1id = m.id "
                + "JOIN LoanDetail1 ld ON ld.MaterialCopy1id = mc.id "
                + "JOIN LoanSlip1 ls ON ls.id = ld.LoanSlip1id "
                + "WHERE ls.`date` BETWEEN ? AND ? "
                + "GROUP BY m.id, m.title, m.author, m.publisher, m.publishYear, m.description "
                + "ORDER BY borrowCount DESC, m.title ASC";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MaterialBorrowingStatistics1 stat = new MaterialBorrowingStatistics1();   // bước 11
                    stat.setId(rs.getInt("id"));
                    stat.setTitle(rs.getString("title"));
                    stat.setAuthor(rs.getString("author"));
                    stat.setPublisher(rs.getString("publisher"));
                    stat.setPublishYear(rs.getInt("publishYear"));
                    stat.setDescription(rs.getString("description"));
                    stat.setBorrowCount(rs.getInt("borrowCount"));
                    stat.setStartDate(startDate);
                    stat.setEndDate(endDate);
                    list.add(stat);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.toArray(new MaterialBorrowingStatistics1[0]);       // bước 12-13
    }
}
