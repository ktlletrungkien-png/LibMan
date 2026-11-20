package model;

import java.sql.Date;

public class ReaderCard1 {
    private int id;
    private String readerCardNumber;
    private SchoolMember1 schoolMember;
    private Date issueDate;
    private Date expireDate;
    private String status;

    public ReaderCard1() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getReaderCardNumber() {
        return readerCardNumber;
    }

    public void setReaderCardNumber(String readerCardNumber) {
        this.readerCardNumber = readerCardNumber;
    }

    public SchoolMember1 getSchoolMember() {
        return schoolMember;
    }

    public void setSchoolMember(SchoolMember1 schoolMember) {
        this.schoolMember = schoolMember;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
