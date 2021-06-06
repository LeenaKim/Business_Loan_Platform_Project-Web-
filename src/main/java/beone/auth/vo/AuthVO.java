package beone.auth.vo;

public class AuthVO {

	private String bizrNo;
	private String accNo;
	private String authReqDate;
	private String authDate;
	private String authStatus;
	private String name;
	
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getAccNo() {
		return accNo;
	}
	public void setAccNo(String accNo) {
		this.accNo = accNo;
	}
	public String getAuthReqDate() {
		return authReqDate;
	}
	public void setAuthReqDate(String authReqDate) {
		this.authReqDate = authReqDate;
	}
	public String getAuthDate() {
		return authDate;
	}
	public void setAuthDate(String authDate) {
		this.authDate = authDate;
	}
	public String getAuthStatus() {
		return authStatus;
	}
	public void setAuthStatus(String authStatus) {
		this.authStatus = authStatus;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "AuthVO [bizrNo=" + bizrNo + ", accNo=" + accNo + ", authReqDate=" + authReqDate + ", authDate="
				+ authDate + ", authStatus=" + authStatus + ", name=" + name + "]";
	}
	
	
	
	
}
