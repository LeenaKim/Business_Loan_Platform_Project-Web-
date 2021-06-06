package beone.loanProd.vo;

public class LoanProdVO {

	private String prodNo;
	private String termMon;
	private String name;
	private String object;
	private float interest;
	private	String limit;
	private String interestCalMtd;
	private String cancleReMtd;
	private String repType;
	private String repMtd;
	private String notice;
	private float midRpyFeeRate;

	
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}
	public String getTermMon() {
		return termMon;
	}
	public void setTermMon(String termMon) {
		this.termMon = termMon;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getObject() {
		return object;
	}
	public void setObject(String object) {
		this.object = object;
	}
	public float getInterest() {
		return interest;
	}
	public void setInterest(float interest) {
		this.interest = interest;
	}
	public String getLimit() {
		return limit;
	}
	public void setLimit(String limit) {
		this.limit = limit;
	}
	public String getInterestCalMtd() {
		return interestCalMtd;
	}
	public void setInterestCalMtd(String interestCalMtd) {
		this.interestCalMtd = interestCalMtd;
	}
	public String getCancleReMtd() {
		return cancleReMtd;
	}
	public void setCancleReMtd(String cancleReMtd) {
		this.cancleReMtd = cancleReMtd;
	}
	public String getRepType() {
		return repType;
	}
	public void setRepType(String repType) {
		this.repType = repType;
	}
	public String getRepMtd() {
		return repMtd;
	}
	public void setRepMtd(String repMtd) {
		this.repMtd = repMtd;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public float getMidRpyFeeRate() {
		return midRpyFeeRate;
	}
	public void setMidRpyFeeRate(float midRpyFeeRate) {
		this.midRpyFeeRate = midRpyFeeRate;
	}
	@Override
	public String toString() {
		return "LoanProdVO [prodNo=" + prodNo + ", termMon=" + termMon + ", name=" + name + ", object=" + object
				+ ", interest=" + interest + ", limit=" + limit + ", interestCalMtd=" + interestCalMtd
				+ ", cancleReMtd=" + cancleReMtd + ", repType=" + repType + ", repMtd=" + repMtd + ", notice=" + notice
				+ ", midRpyFeeRate=" + midRpyFeeRate + "]";
	}
	
	
	
	
	
	
}
