package beone.emp.vo;

public class EmpVO {

	private String empno;
	private String pw;
	private String branchNm;
	private String ename;
	private String deptno;
//	우리지점 대출왕용 카운트
	private int cnt;
	
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getBranchNm() {
		return branchNm;
	}
	public void setBranchNm(String branchNm) {
		this.branchNm = branchNm;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getDeptno() {
		return deptno;
	}
	public void setDeptno(String deptno) {
		this.deptno = deptno;
	}
	
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	@Override
	public String toString() {
		return "EmpVO [empno=" + empno + ", pw=" + pw + ", branchNm=" + branchNm + ", ename=" + ename + ", deptno="
				+ deptno + "]";
	}
	
}
