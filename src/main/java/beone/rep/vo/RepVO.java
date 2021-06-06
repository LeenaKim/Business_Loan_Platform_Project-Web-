package beone.rep.vo;

public class RepVO {

	private String repName;
	private String bizrNo;
	public String getRepName() {
		return repName;
	}
	public void setRepName(String repName) {
		this.repName = repName;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	@Override
	public String toString() {
		return "RepVO [repName=" + repName + ", bizrNo=" + bizrNo + "]";
	}
	
	
}
