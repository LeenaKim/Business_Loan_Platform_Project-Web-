package beone.accountant.vo;

public class AccountantVO {

	private String accNo;
	private String name;
	private String pw;
	private String phone;
	
	public String getAccNo() {
		return accNo;
	}
	public void setAccNo(String accNo) {
		this.accNo = accNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	@Override
	public String toString() {
		return "AccountantVO [accNo=" + accNo + ", name=" + name + ", pw=" + pw + ", phone=" + phone + "]";
	}
	
	
}
