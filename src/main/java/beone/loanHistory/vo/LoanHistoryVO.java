package beone.loanHistory.vo;

public class LoanHistoryVO {

	private String loanNo;
	private String loanType;
	private String startDate;
	private String finDate;
	private long pcplAmt;
	private float interest;
	private String loanAcnt;
	private String interestAcnt;
	private String interestDate;
	private String assType;
	private String loanStatus;
	private String empno;
	private String prodNo;
	private String bizrNo;
	private long leftAmt;
	private String prodName;
	private int interestAmt;
	private float rpyRate;
	
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public String getLoanAcnt() {
		return loanAcnt;
	}
	public void setLoanAcnt(String loanAcnt) {
		this.loanAcnt = loanAcnt;
	}
	public String getLoanType() {
		return loanType;
	}
	public void setLoanType(String loanType) {
		this.loanType = loanType;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getFinDate() {
		return finDate;
	}
	public void setFinDate(String finDate) {
		this.finDate = finDate;
	}
	public float getRpyRate() {
		return rpyRate;
	}
	public void setRpyRate(float rpyRate) {
		this.rpyRate = rpyRate;
	}
	public long getLeftAmt() {
		return leftAmt;
	}
	public void setLeftAmt(long leftAmt) {
		this.leftAmt = leftAmt;
	}
	public long getPcplAmt() {
		return pcplAmt;
	}
	public void setPcplAmt(long pcplAmt) {
		this.pcplAmt = pcplAmt;
	}
	public float getInterest() {
		return interest;
	}
	public void setInterest(float interest) {
		this.interest = interest;
	}
	public String getInterestAcnt() {
		return interestAcnt;
	}
	public void setInterestAcnt(String interestAcnt) {
		this.interestAcnt = interestAcnt;
	}
	public String getInterestDate() {
		return interestDate;
	}
	public void setInterestDate(String interestDate) {
		this.interestDate = interestDate;
	}
	public String getAssType() {
		return assType;
	}
	public void setAssType(String assType) {
		this.assType = assType;
	}
	public int getInterestAmt() {
		return interestAmt;
	}
	public void setInterestAmt(int interestAmt) {
		this.interestAmt = interestAmt;
	}
	
	public String getLoanNo() {
		return loanNo;
	}
	public void setLoanNo(String loanNo) {
		this.loanNo = loanNo;
	}
	public String getLoanStatus() {
		return loanStatus;
	}
	public void setLoanStatus(String loanStatus) {
		this.loanStatus = loanStatus;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	@Override
	public String toString() {
		return "LoanHistoryVO [loanNo=" + loanNo + ", loanType=" + loanType + ", startDate=" + startDate + ", finDate="
				+ finDate + ", pcplAmt=" + pcplAmt + ", interest=" + interest + ", loanAcnt=" + loanAcnt
				+ ", interestAcnt=" + interestAcnt + ", interestDate=" + interestDate + ", assType=" + assType
				+ ", loanStatus=" + loanStatus + ", empno=" + empno + ", prodNo=" + prodNo + ", bizrNo=" + bizrNo
				+ ", leftAmt=" + leftAmt + ", prodName=" + prodName + ", interestAmt=" + interestAmt + ", rpyRate="
				+ rpyRate + "]";
	}
	
	
}
