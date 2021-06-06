package beone.rpyHistory.vo;

import javax.validation.constraints.NotEmpty;

public class RpyHistoryVO {

	private String repNo;
	private String midRpyDate;
	private String loanNo;
	private int midRpyAmt;
	private int midRpyFee;
	private int balance;
	private String loanAcnt; // DB엔 loan_history 테이블에 있으나 비즈니스 로직상 같이 필요 
	
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	public String getRepNo() {
		return repNo;
	}
	public void setRepNo(String repNo) {
		this.repNo = repNo;
	}
	public String getMidRpyDate() {
		return midRpyDate;
	}
	public void setMidRpyDate(String midRpyDate) {
		this.midRpyDate = midRpyDate;
	}
	public String getLoanNo() {
		return loanNo;
	}
	public void setLoanNo(String loanNo) {
		this.loanNo = loanNo;
	}
	public int getMidRpyAmt() {
		return midRpyAmt;
	}
	public void setMidRpyAmt(int midRpyAmt) {
		this.midRpyAmt = midRpyAmt;
	}
	public int getMidRpyFee() {
		return midRpyFee;
	}
	public void setMidRpyFee(int midRpyFee) {
		this.midRpyFee = midRpyFee;
	}
	
	public String getLoanAcnt() {
		return loanAcnt;
	}
	public void setLoanAcnt(String loanAcnt) {
		this.loanAcnt = loanAcnt;
	}
	@Override
	public String toString() {
		return "RpyHistoryVO [repNo=" + repNo + ", midRpyDate=" + midRpyDate + ", loanNo=" + loanNo + ", midRpyAmt="
				+ midRpyAmt + ", midRpyFee=" + midRpyFee + ", balance=" + balance + ", loanAcnt=" + loanAcnt + "]";
	}
	
	
	
}
