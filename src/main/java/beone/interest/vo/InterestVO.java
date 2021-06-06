package beone.interest.vo;

public class InterestVO {

	private int payNo;
	private String loanNo;
	private long payAmt;
	private String payDate;
	private long nextMonAmt;
	public int getPayNo() {
		return payNo;
	}
	public void setPayNo(int payNo) {
		this.payNo = payNo;
	}
	public String getLoanNo() {
		return loanNo;
	}
	public void setLoanNo(String loanNo) {
		this.loanNo = loanNo;
	}
	public long getPayAmt() {
		return payAmt;
	}
	public void setPayAmt(long payAmt) {
		this.payAmt = payAmt;
	}
	public String getPayDate() {
		return payDate;
	}
	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}
	public long getNextMonAmt() {
		return nextMonAmt;
	}
	public void setNextMonAmt(long nextMonAmt) {
		this.nextMonAmt = nextMonAmt;
	}
	@Override
	public String toString() {
		return "InterestVO [payNo=" + payNo + ", loanNo=" + loanNo + ", payAmt=" + payAmt + ", payDate=" + payDate
				+ ", nextMonAmt=" + nextMonAmt + "]";
	}
	
	
}
