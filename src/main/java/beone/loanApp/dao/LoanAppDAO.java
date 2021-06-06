package beone.loanApp.dao;

import java.util.List;
import java.util.Map;

import beone.emp.vo.EmpVO;
import beone.loanApp.vo.LoanAppVO;

public interface LoanAppDAO {

	void insertLoanApp(LoanAppVO loanApp);
	
	List<LoanAppVO> selectAllLoanApp(String bizrNo);
	
	int selectCurSeqAppNo();
	
	List<LoanAppVO> selectAllByEmpno(EmpVO emp);
	
	int selectCntEmp(EmpVO emp);
	
	List<LoanAppVO> selectPerPage(Map<String, Object> map);
	
	LoanAppVO selectOneByAppNo(int appNo);
	
	void updateLoanAppStatusC(int appNo);
	
	void updateLoanAppStatusR(int appNo);
}
