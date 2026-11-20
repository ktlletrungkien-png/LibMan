package model;

import java.sql.Date;

public class MaterialBorrowingStatistics1 extends Material1 {
    private int borrowCount;
    private Date startDate;
    private Date endDate;

    public MaterialBorrowingStatistics1() {
        super();
    }

    public int getBorrowCount() {
        return borrowCount;
    }

    public void setBorrowCount(int borrowCount) {
        this.borrowCount = borrowCount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
