package beone.loanApp.service;

import java.util.List;
import java.util.Map;

import beone.emp.vo.EmpVO;
import beone.loanApp.vo.LoanAppVO;

public interface LoanAppService {

	void insertLoanApp(LoanAppVO loanApp, int[] docNo);
	
	List<LoanAppVO> selectAllLoanApp(String bizrNo);
	
	List<LoanAppVO> selectAllByEmpno(EmpVO emp);
	
	int selectCnt(EmpVO emp);
	
	List<LoanAppVO> selectPerPage(Map<String, Object> map);
	
	LoanAppVO selectOneByAppNo(int appNo);
}
