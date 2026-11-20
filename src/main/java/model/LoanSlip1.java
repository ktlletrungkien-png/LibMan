package model;

import java.sql.Date;

public class LoanSlip1 {
    private int id;
    private Date date;
    private ReaderCard1 readerCard;
    private Librarian1 librarian;
    private LoanDetail1[] loanDetails;

    public LoanSlip1() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public ReaderCard1 getReaderCard() {
        return readerCard;
    }

    public void setReaderCard(ReaderCard1 readerCard) {
        this.readerCard = readerCard;
    }

    public Librarian1 getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian1 librarian) {
        this.librarian = librarian;
    }

    public LoanDetail1[] getLoanDetails() {
        return loanDetails;
    }

    public void setLoanDetails(LoanDetail1[] loanDetails) {
        this.loanDetails = loanDetails;
    }
}
