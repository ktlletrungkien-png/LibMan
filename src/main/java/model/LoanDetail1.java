package model;

import java.sql.Date;

public class LoanDetail1 {
    private int id;
    private Date exReturnDate;
    private Date realReturnDate;
    private int extensionCount;
    private String condLoan;
    private String condReturn;
    private MaterialCopy1 materialCopy;

    public LoanDetail1() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getExReturnDate() {
        return exReturnDate;
    }

    public void setExReturnDate(Date exReturnDate) {
        this.exReturnDate = exReturnDate;
    }

    public Date getRealReturnDate() {
        return realReturnDate;
    }

    public void setRealReturnDate(Date realReturnDate) {
        this.realReturnDate = realReturnDate;
    }

    public int getExtensionCount() {
        return extensionCount;
    }

    public void setExtensionCount(int extensionCount) {
        this.extensionCount = extensionCount;
    }

    public String getCondLoan() {
        return condLoan;
    }

    public void setCondLoan(String condLoan) {
        this.condLoan = condLoan;
    }

    public String getCondReturn() {
        return condReturn;
    }

    public void setCondReturn(String condReturn) {
        this.condReturn = condReturn;
    }

    public MaterialCopy1 getMaterialCopy() {
        return materialCopy;
    }

    public void setMaterialCopy(MaterialCopy1 materialCopy) {
        this.materialCopy = materialCopy;
    }
}
