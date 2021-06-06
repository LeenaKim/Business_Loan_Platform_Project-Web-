package beone.corp.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;

public class CorpVO {

//	@NotEmpty(message = "사업자등록번호를 입력해주세요.")
//	@Pattern(regexp = "[0-9]+", message = "숫자만 입력해주세요.")
	private String bizrNo;
//	@Pattern(regexp = "^.*(?=^.{12,20}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$", message = "특수문자/문자/숫자 포함 형태의 12 - 20자리 비밀번호를 입력해주세요. ")
	private String pw;
	private String pwConfirm;
//	@NotEmpty(message = "기업체명을 입력해주세요.")
	private String name;
	private String nameEng;
	private String jurirNo;
	private String corpCls;
	private String indutyCode;
	private String adres;
	private String hmUrl;
	private String countryCode;
	private String phnNo;
	private String countryCodeFax;
	private String faxNo;
	private String estDt;
	private String accMt;
	
	// 비밀번호 확인 메소드 
	public boolean isPwEqualToPwConfirm() {
		return pw.equals(pwConfirm);
	}
		
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNameEng() {
		return nameEng;
	}
	public void setNameEng(String nameEng) {
		this.nameEng = nameEng;
	}
	public String getJurirNo() {
		return jurirNo;
	}
	public void setJurirNo(String jurirNo) {
		this.jurirNo = jurirNo;
	}
	public String getCorpCls() {
		return corpCls;
	}
	public void setCorpCls(String corpCls) {
		this.corpCls = corpCls;
	}
	public String getIndutyCode() {
		return indutyCode;
	}
	public void setIndutyCode(String indutyCode) {
		this.indutyCode = indutyCode;
	}
	public String getAdres() {
		return adres;
	}
	public void setAdres(String adres) {
		this.adres = adres;
	}
	public String getHmUrl() {
		return hmUrl;
	}
	public void setHmUrl(String hmUrl) {
		this.hmUrl = hmUrl;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	public String getPhnNo() {
		return phnNo;
	}
	public void setPhnNo(String phnNo) {
		this.phnNo = phnNo;
	}
	public String getCountryCodeFax() {
		return countryCodeFax;
	}
	public void setCountryCodeFax(String countryCodeFax) {
		this.countryCodeFax = countryCodeFax;
	}
	public String getFaxNo() {
		return faxNo;
	}
	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}
	public String getEstDt() {
		return estDt;
	}
	public void setEstDt(String estDt) {
		this.estDt = estDt;
	}
	public String getAccMt() {
		return accMt;
	}
	public void setAccMt(String accMt) {
		this.accMt = accMt;
	}
	
	public String getPwConfirm() {
		return pwConfirm;
	}

	public void setPwConfirm(String pwConfirm) {
		this.pwConfirm = pwConfirm;
	}

	@Override
	public String toString() {
		return "CorpVO [bizrNo=" + bizrNo + ", pw=" + pw + ", name=" + name + ", nameEng=" + nameEng + ", jurirNo="
				+ jurirNo + ", corpCls=" + corpCls + ", indutyCode=" + indutyCode + ", adres=" + adres + ", hmUrl="
				+ hmUrl + ", countryCode=" + countryCode + ", phnNo=" + phnNo + ", countryCodeFax=" + countryCodeFax
				+ ", faxNo=" + faxNo + ", estDt=" + estDt + ", accMt=" + accMt + "]";
	}
	
	
}
