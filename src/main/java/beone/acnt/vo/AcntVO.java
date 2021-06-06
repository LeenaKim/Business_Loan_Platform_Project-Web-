package beone.acnt.vo;

public class AcntVO {

	private String no;
	private long balance;
	private String nickname;
	private String regDate;
	private String bizrNo;
	private String valid;
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public long getBalance() {
		return balance;
	}
	public void setBalance(long balance) {
		this.balance = balance;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	
	public String getValid() {
		return valid;
	}
	public void setValid(String valid) {
		this.valid = valid;
	}
	@Override
	public String toString() {
		return "AcntVO [no=" + no + ", balance=" + balance + ", nickname=" + nickname + ", regDate=" + regDate
				+ ", bizrNo=" + bizrNo + ", valid=" + valid + "]";
	}
	
	
	
}
