package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.LoanDetail1;
import model.MaterialBorrowingStatistics1;
import model.MaterialCopy1;

public class LoanDetail1DAO extends ConnectionDAO1 {

    public LoanDetail1DAO() {
        super();
    }

    /**
     * Sequence Hình 3.10, bước 18-22: lấy các lần mượn (LoanDetail1) của tài liệu đã chọn
     * trong khoảng thời gian thống kê (startDate, endDate nằm sẵn trong materialBorrowingStat).
     */
    public LoanDetail1[] getLoanDetailsByMaterialBorrowingStatistics(MaterialBorrowingStatistics1 materialBorrowingStat) {
        ArrayList<LoanDetail1> list = new ArrayList<>();
        String sql = "SELECT ld.id, ld.exReturnDate, ld.realReturnDate, ld.extensionCount, ld.condLoan, ld.condReturn, "
                + "       mc.id AS copyId, mc.physicalCondition, mc.status, mc.note "
                + "FROM LoanDetail1 ld "
                + "JOIN MaterialCopy1 mc ON mc.id = ld.MaterialCopy1id "
                + "JOIN LoanSlip1 ls ON ls.id = ld.LoanSlip1id "
                + "WHERE mc.Material1id = ? AND ls.`date` BETWEEN ? AND ? "
                + "ORDER BY ls.`date`, ld.id";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, materialBorrowingStat.getId());
            ps.setDate(2, materialBorrowingStat.getStartDate());
            ps.setDate(3, materialBorrowingStat.getEndDate());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LoanDetail1 loanDetail = new LoanDetail1();                           // bước 20
                    loanDetail.setId(rs.getInt("id"));
                    loanDetail.setExReturnDate(rs.getDate("exReturnDate"));
                    loanDetail.setRealReturnDate(rs.getDate("realReturnDate"));
                    loanDetail.setExtensionCount(rs.getInt("extensionCount"));
                    loanDetail.setCondLoan(rs.getString("condLoan"));
                    loanDetail.setCondReturn(rs.getString("condReturn"));
                    MaterialCopy1 copy = new MaterialCopy1();
                    copy.setId(rs.getInt("copyId"));
                    copy.setPhysicalCondition(rs.getString("physicalCondition"));
                    copy.setStatus(rs.getString("status"));
                    copy.setNote(rs.getString("note"));
                    copy.setMaterial(materialBorrowingStat);   // MaterialBorrowingStatistics1 là một Material1
                    loanDetail.setMaterialCopy(copy);
                    list.add(loanDetail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.toArray(new LoanDetail1[0]);                        // bước 21-22
    }
}
