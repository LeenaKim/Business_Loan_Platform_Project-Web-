package beone.loanEval.vo;

public class LoanEvalVO {

	private int appNo;
	private String evalDate;
	private String evalResult;
	private String evalComment;
	public int getAppNo() {
		return appNo;
	}
	public void setAppNo(int appNo) {
		this.appNo = appNo;
	}
	public String getEvalDate() {
		return evalDate;
	}
	public void setEvalDate(String evalDate) {
		this.evalDate = evalDate;
	}
	public String getEvalResult() {
		return evalResult;
	}
	public void setEvalResult(String evalResult) {
		this.evalResult = evalResult;
	}
	public String getEvalComment() {
		return evalComment;
	}
	public void setEvalComment(String evalComment) {
		this.evalComment = evalComment;
	}
	@Override
	public String toString() {
		return "LoanEvalVO [appNo=" + appNo + ", evalDate=" + evalDate + ", evalResult=" + evalResult + ", evalComment="
				+ evalComment + "]";
	}
	
	
	
}
