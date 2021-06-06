package beone.loanHistory.service;

import java.util.List;
import java.util.Map;

import beone.emp.vo.EmpVO;
import beone.loanHistory.vo.LoanHistoryVO;

public interface LoanHistoryService {

	List<LoanHistoryVO> selectAllLoanHistory(String bizrNo);
	
	LoanHistoryVO selectByLoanNo(String loanNo);
	
	List<LoanHistoryVO> selectAllByEmpno(EmpVO emp);
	
	List<LoanHistoryVO> selectAllPerPage(Map<String, Object> map);
	
	int selectCnt(EmpVO emp);
	
	void updateLoanStatus();
	
	LoanHistoryVO selectOneLatest(String bizrNo);
	
	List<LoanHistoryVO> selectAllPagingByBizrNo(Map<String, Object> map);
	
	int selectCntPagingByBizrNo(String bizrNo);
	
	void addFocusLoan(String loanNo);
	
	List<LoanHistoryVO> selectFocusLoan(String empno);
}
