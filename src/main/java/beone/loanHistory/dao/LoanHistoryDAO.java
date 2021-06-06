package beone.loanHistory.dao;

import java.util.List;
import java.util.Map;

import beone.emp.vo.EmpVO;
import beone.loanApp.vo.LoanAppVO;
import beone.loanHistory.vo.LoanHistoryVO;

public interface LoanHistoryDAO {

	List<LoanHistoryVO> selectAllLoanHistory(String bizrNo);
	
	void updateLeftAmt(Map<String, Object> map);
	
	LoanHistoryVO selectByLoanNo(String loanNo);
	
	List<LoanHistoryVO> selectAllByEmpno(EmpVO emp);
	
	List<LoanHistoryVO> selectAllPerPage(Map<String, Object> map);
	
	int selectCnt(EmpVO emp);
	
	void updateLoanStatusSch(); 
	
	LoanHistoryVO selectOneLatest(String bizrNo);
	
	void insertNewLoanHis(LoanAppVO loanApp);
	
	List<LoanHistoryVO> selectAllPagingByBizrNo(Map<String, Object> map);
	
	int selectCntPagingByBizrNo(String bizrNo);
	
	void updateFocusLoan(String loanNo);
	
	List<LoanHistoryVO> selectAllFocusLoan(String empno);
}
