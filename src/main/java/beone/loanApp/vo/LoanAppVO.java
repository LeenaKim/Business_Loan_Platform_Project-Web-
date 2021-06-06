package beone.loanApp.vo;

public class LoanAppVO {

	private int appNo;
	private String loanType;
	private String loanAcnt;
	private String interestAcnt;
	private String assType;
	private String branchNm;
	private String appDate;
	private long appAmount;
	private int appMonth;
	private String loanAppStatus;
	private String prodNo;
	private String empno;
	private String bizrNo;
	//	가끔 쓸일이 있는 prodName
	private String prodName;
	// 추가
	private String interestDate;
	// 추가
	private String autoInterestTrans;
	// 추가 
	private float appInterest;
	
	public int getAppNo() {
		return appNo;
	}
	public void setAppNo(int appNo) {
		this.appNo = appNo;
	}
	public String getLoanType() {
		return loanType;
	}
	public void setLoanType(String loanType) {
		this.loanType = loanType;
	}
	public String getLoanAcnt() {
		return loanAcnt;
	}
	public void setLoanAcnt(String loanAcnt) {
		this.loanAcnt = loanAcnt;
	}
	public String getInterestAcnt() {
		return interestAcnt;
	}
	public void setInterestAcnt(String interestAcnt) {
		this.interestAcnt = interestAcnt;
	}
	public String getAssType() {
		return assType;
	}
	public void setAssType(String assType) {
		this.assType = assType;
	}
	public String getBranchNm() {
		return branchNm;
	}
	public void setBranchNm(String branchNm) {
		this.branchNm = branchNm;
	}
	public String getAppDate() {
		return appDate;
	}
	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}
	public long getAppAmount() {
		return appAmount;
	}
	public void setAppAmount(long appAmount) {
		this.appAmount = appAmount;
	}
//	public int getAppYear() {
//		return appMonth;
//	}
//	public void setAppYear(int appYear) {
//		this.appMonth = appYear;
//	}
	public String getLoanAppStatus() {
		return loanAppStatus;
	}
	public void setLoanAppStatus(String loanAppStatus) {
		this.loanAppStatus = loanAppStatus;
	}
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	
	public String getInterestDate() {
		return interestDate;
	}
	public void setInterestDate(String interestDate) {
		this.interestDate = interestDate;
	}
	public String getAutoInterestTrans() {
		return autoInterestTrans;
	}
	public void setAutoInterestTrans(String autoInterestTrans) {
		this.autoInterestTrans = autoInterestTrans;
	}
	
	public float getAppInterest() {
		return appInterest;
	}
	public void setAppInterest(float appInterest) {
		this.appInterest = appInterest;
	}
	
	public int getAppMonth() {
		return appMonth;
	}
	public void setAppMonth(int appMonth) {
		this.appMonth = appMonth;
	}
	@Override
	public String toString() {
		return "LoanAppVO [appNo=" + appNo + ", loanType=" + loanType + ", loanAcnt=" + loanAcnt + ", interestAcnt="
				+ interestAcnt + ", assType=" + assType + ", branchNm=" + branchNm + ", appDate=" + appDate
				+ ", appAmount=" + appAmount + ", appMonth=" + appMonth + ", loanAppStatus=" + loanAppStatus
				+ ", prodNo=" + prodNo + ", empno=" + empno + ", bizrNo=" + bizrNo + ", prodName=" + prodName
				+ ", interestDate=" + interestDate + ", autoInterestTrans=" + autoInterestTrans + ", appInterest="
				+ appInterest + "]";
	}

	
	
}
