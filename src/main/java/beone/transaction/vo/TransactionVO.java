package beone.transaction.vo;

public class TransactionVO {

	private String no;
	private String occurTime;
	private String summary;
	private String mainAcntNo;
	private String objAcntNo;
	private String objName;
	private long wAmount;
	private long dAmount;
	private String corr;
	private long balance;
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getOccurTime() {
		return occurTime;
	}
	public void setOccurTime(String occurTime) {
		this.occurTime = occurTime;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getMainAcntNo() {
		return mainAcntNo;
	}
	public void setMainAcntNo(String mainAcntNo) {
		this.mainAcntNo = mainAcntNo;
	}
	public String getObjAcntNo() {
		return objAcntNo;
	}
	public void setObjAcntNo(String objAcntNo) {
		this.objAcntNo = objAcntNo;
	}
	public String getObjName() {
		return objName;
	}
	public void setObjName(String objName) {
		this.objName = objName;
	}
	public long getwAmount() {
		return wAmount;
	}
	public void setwAmount(long wAmount) {
		this.wAmount = wAmount;
	}
	public long getdAmount() {
		return dAmount;
	}
	public void setdAmount(long dAmount) {
		this.dAmount = dAmount;
	}
	public String getCorr() {
		return corr;
	}
	public void setCorr(String corr) {
		this.corr = corr;
	}
	
	public long getBalance() {
		return balance;
	}
	public void setBalance(long balance) {
		this.balance = balance;
	}
	@Override
	public String toString() {
		return "TransactionVO [no=" + no + ", occurTime=" + occurTime + ", summary=" + summary + ", mainAcntNo="
				+ mainAcntNo + ", objAcntNo=" + objAcntNo + ", objName=" + objName + ", wAmount=" + wAmount
				+ ", dAmount=" + dAmount + ", corr=" + corr + ", balance=" + balance + "]";
	}
	
	
	
}
