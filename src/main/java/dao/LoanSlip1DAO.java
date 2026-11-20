package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Librarian1;
import model.LoanDetail1;
import model.LoanSlip1;
import model.Material1;
import model.MaterialCopy1;
import model.ReaderCard1;
import model.SchoolMember1;

public class LoanSlip1DAO extends ConnectionDAO1 {

    public LoanSlip1DAO() {
        super();
    }

    /**
     * Sequence Hình 3.10, bước 27-31: lấy phiếu mượn chứa lần mượn loanDetail,
     * kèm bạn đọc (thẻ + thành viên trường), thủ thư lập phiếu và các lần mượn của phiếu.
     */
    public LoanSlip1 getLoanSlipByLoanDetail(LoanDetail1 loanDetail) {
        LoanSlip1 loanSlip = null;
        String sqlSlip = "SELECT ls.id, ls.`date`, "
                + "       rc.id AS rcId, rc.readerCardNumber, rc.issueDate, rc.expireDate, rc.status, "
                + "       sm.id AS smId, sm.schoolId, sm.name AS smName, sm.schoolEmail, sm.role, sm.dob AS smDob, sm.validUntil, "
                + "       lib.id AS libId, lib.fullName, lib.dob AS libDob, lib.gender, lib.idCardNumber, lib.address, lib.email, lib.phone "
                + "FROM LoanDetail1 ld "
                + "JOIN LoanSlip1 ls ON ls.id = ld.LoanSlip1id "
                + "JOIN ReaderCard1 rc ON rc.id = ls.ReaderCard1id "
                + "JOIN SchoolMember1 sm ON sm.id = rc.SchoolMember1id "
                + "JOIN Member1 lib ON lib.id = ls.librarianId "
                + "WHERE ld.id = ?";
        String sqlDetails = "SELECT ld.id, ld.exReturnDate, ld.realReturnDate, ld.extensionCount, ld.condLoan, ld.condReturn, "
                + "       mc.id AS copyId, mc.physicalCondition, mc.status, mc.note, "
                + "       m.id AS mId, m.title "
                + "FROM LoanDetail1 ld "
                + "JOIN MaterialCopy1 mc ON mc.id = ld.MaterialCopy1id "
                + "JOIN Material1 m ON m.id = mc.Material1id "
                + "WHERE ld.LoanSlip1id = ? ORDER BY ld.id";
        try (PreparedStatement ps = con.prepareStatement(sqlSlip)) {
            ps.setInt(1, loanDetail.getId());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    loanSlip = new LoanSlip1();                                            // bước 29
                    loanSlip.setId(rs.getInt("id"));
                    loanSlip.setDate(rs.getDate("date"));

                    SchoolMember1 sm = new SchoolMember1();
                    sm.setId(rs.getInt("smId"));
                    sm.setSchoolId(rs.getString("schoolId"));
                    sm.setName(rs.getString("smName"));
                    sm.setSchoolEmail(rs.getString("schoolEmail"));
                    sm.setRole(rs.getString("role"));
                    sm.setDob(rs.getDate("smDob"));
                    sm.setValidUntil(rs.getDate("validUntil"));
                    ReaderCard1 rc = new ReaderCard1();
                    rc.setId(rs.getInt("rcId"));
                    rc.setReaderCardNumber(rs.getString("readerCardNumber"));
                    rc.setIssueDate(rs.getDate("issueDate"));
                    rc.setExpireDate(rs.getDate("expireDate"));
                    rc.setStatus(rs.getString("status"));
                    rc.setSchoolMember(sm);
                    loanSlip.setReaderCard(rc);

                    Librarian1 lib = new Librarian1();
                    lib.setId(rs.getInt("libId"));
                    lib.setFullName(rs.getString("fullName"));
                    lib.setDob(rs.getDate("libDob"));
                    lib.setGender(rs.getString("gender"));
                    lib.setIdCardNumber(rs.getString("idCardNumber"));
                    lib.setAddress(rs.getString("address"));
                    lib.setEmail(rs.getString("email"));
                    lib.setPhone(rs.getString("phone"));
                    loanSlip.setLibrarian(lib);
                }
            }
            if (loanSlip != null) {
                ArrayList<LoanDetail1> details = new ArrayList<>();
                try (PreparedStatement ps2 = con.prepareStatement(sqlDetails)) {
                    ps2.setInt(1, loanSlip.getId());
                    try (ResultSet rs2 = ps2.executeQuery()) {
                        while (rs2.next()) {
                            LoanDetail1 ld = new LoanDetail1();
                            ld.setId(rs2.getInt("id"));
                            ld.setExReturnDate(rs2.getDate("exReturnDate"));
                            ld.setRealReturnDate(rs2.getDate("realReturnDate"));
                            ld.setExtensionCount(rs2.getInt("extensionCount"));
                            ld.setCondLoan(rs2.getString("condLoan"));
                            ld.setCondReturn(rs2.getString("condReturn"));
                            MaterialCopy1 copy = new MaterialCopy1();
                            copy.setId(rs2.getInt("copyId"));
                            copy.setPhysicalCondition(rs2.getString("physicalCondition"));
                            copy.setStatus(rs2.getString("status"));
                            copy.setNote(rs2.getString("note"));
                            Material1 material = new Material1();
                            material.setId(rs2.getInt("mId"));
                            material.setTitle(rs2.getString("title"));
                            copy.setMaterial(material);
                            ld.setMaterialCopy(copy);
                            details.add(ld);
                        }
                    }
                }
                loanSlip.setLoanDetails(details.toArray(new LoanDetail1[0]));
            }
        } catch (Exception e) {
            e.printStackTrace();
            loanSlip = null;
        }
        return loanSlip;                                                // bước 30-31
    }
}
