package beone.finData.vo;

public class FinDataVO {

	private String bizrNo;
	private String turn;
	private long currAst;
	private long nonCurrAst;
	private long ttlAst;
	private long currLiab;
	private long nonCurrLiab;
	private long ttlLiab;
	private long capital;
	private long erndSplus;
	private long ttlCapital;
	private long salesCf;
	private long finCf;
	private long invstCf;
	private long sales;
	private long busiProfits;
	private long netIncm;
	private String issueDate;
	
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getTurn() {
		return turn;
	}
	public void setTurn(String turn) {
		this.turn = turn;
	}
	public long getCurrAst() {
		return currAst;
	}
	public void setCurrAst(long currAst) {
		this.currAst = currAst;
	}
	public long getNonCurrAst() {
		return nonCurrAst;
	}
	public void setNonCurrAst(long nonCurrAst) {
		this.nonCurrAst = nonCurrAst;
	}
	public long getTtlAst() {
		return ttlAst;
	}
	public void setTtlAst(long ttlAst) {
		this.ttlAst = ttlAst;
	}
	public long getCurrLiab() {
		return currLiab;
	}
	public void setCurrLiab(long currLiab) {
		this.currLiab = currLiab;
	}
	public long getNonCurrLiab() {
		return nonCurrLiab;
	}
	public void setNonCurrLiab(long nonCurrLiab) {
		this.nonCurrLiab = nonCurrLiab;
	}
	public long getTtlLiab() {
		return ttlLiab;
	}
	public void setTtlLiab(long ttlLiab) {
		this.ttlLiab = ttlLiab;
	}
	public long getCapital() {
		return capital;
	}
	public void setCapital(long capital) {
		this.capital = capital;
	}
	public long getErndSplus() {
		return erndSplus;
	}
	public void setErndSplus(long erndSplus) {
		this.erndSplus = erndSplus;
	}
	public long getTtlCapital() {
		return ttlCapital;
	}
	public void setTtlCapital(long ttlCapital) {
		this.ttlCapital = ttlCapital;
	}
	public long getSalesCf() {
		return salesCf;
	}
	public void setSalesCf(long salesCf) {
		this.salesCf = salesCf;
	}
	public long getFinCf() {
		return finCf;
	}
	public void setFinCf(long finCf) {
		this.finCf = finCf;
	}
	public long getInvstCf() {
		return invstCf;
	}
	public void setInvstCf(long invstCf) {
		this.invstCf = invstCf;
	}
	public long getSales() {
		return sales;
	}
	public void setSales(long sales) {
		this.sales = sales;
	}
	public long getBusiProfits() {
		return busiProfits;
	}
	public void setBusiProfits(long busiProfits) {
		this.busiProfits = busiProfits;
	}
	public long getNetIncm() {
		return netIncm;
	}
	public void setNetIncm(long netIncm) {
		this.netIncm = netIncm;
	}
	
	public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	@Override
	public String toString() {
		return "FinDataVO [bizrNo=" + bizrNo + ", turn=" + turn + ", currAst=" + currAst + ", nonCurrAst=" + nonCurrAst
				+ ", ttlAst=" + ttlAst + ", currLiab=" + currLiab + ", nonCurrLiab=" + nonCurrLiab + ", ttlLiab="
				+ ttlLiab + ", capital=" + capital + ", erndSplus=" + erndSplus + ", ttlCapital=" + ttlCapital
				+ ", salesCf=" + salesCf + ", finCf=" + finCf + ", invstCf=" + invstCf + ", sales=" + sales
				+ ", busiProfits=" + busiProfits + ", netIncm=" + netIncm + ", issueDate=" + issueDate + "]";
	}
	
	
	
	
}
