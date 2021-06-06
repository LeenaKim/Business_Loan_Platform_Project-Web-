package beone.loanHistory.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import beone.emp.vo.EmpVO;
import beone.loanHistory.dao.LoanHistoryDAO;
import beone.loanHistory.vo.LoanHistoryVO;
@Service
public class LoanHistoryServiceImpl implements LoanHistoryService {

	@Autowired
	private LoanHistoryDAO loanHistoryDAO;
	
	
	@Override
	public List<LoanHistoryVO> selectAllLoanHistory(String bizrNo) {
		List<LoanHistoryVO> list = loanHistoryDAO.selectAllLoanHistory(bizrNo);
		return list;
	}


	@Override
	public LoanHistoryVO selectByLoanNo(String loanNo) {
		LoanHistoryVO loanHis = loanHistoryDAO.selectByLoanNo(loanNo);
		return loanHis;
	}


	@Override
	public List<LoanHistoryVO> selectAllByEmpno(EmpVO emp) {
		List<LoanHistoryVO> loanHisList = loanHistoryDAO.selectAllByEmpno(emp);
		return loanHisList;
	}


	@Override
	public List<LoanHistoryVO> selectAllPerPage(Map<String, Object> map) {
		List<LoanHistoryVO> loanHisListPerPage = loanHistoryDAO.selectAllPerPage(map);
		return loanHisListPerPage;
	}


	@Override
	public int selectCnt(EmpVO emp) {
		int selectCnt = loanHistoryDAO.selectCnt(emp);
		return selectCnt;
	}

	/**
	 * 매일 밤 12시마다 대출 종료일이 지났고 대출 잔금이 0원이라면 
	 * loan_status 값을 'I'(진행중) -> 'C'(완료) 로 업데이트 
	 */
	@Scheduled(cron = "0 0 0 * * *")
	@Override
	public void updateLoanStatus() {
		System.out.println("대출상태 업데이트 스케쥴러 호출...");
		loanHistoryDAO.updateLoanStatusSch();
	}


	@Override
	public LoanHistoryVO selectOneLatest(String bizrNo) {
		LoanHistoryVO loanHis = loanHistoryDAO.selectOneLatest(bizrNo);
		return loanHis;
	}


	@Override
	public List<LoanHistoryVO> selectAllPagingByBizrNo(Map<String, Object> map) {
		List<LoanHistoryVO> loanHisList = loanHistoryDAO.selectAllPagingByBizrNo(map);
		return loanHisList;
	}


	@Override
	public int selectCntPagingByBizrNo(String bizrNo) {
		int cnt = loanHistoryDAO.selectCntPagingByBizrNo(bizrNo);
		return cnt;
	}


	@Override
	public void addFocusLoan(String loanNo) {
		loanHistoryDAO.updateFocusLoan(loanNo);
		
	}


	@Override
	public List<LoanHistoryVO> selectFocusLoan(String empno) {
		List<LoanHistoryVO> focusLoanList = loanHistoryDAO.selectAllFocusLoan(empno);
		return focusLoanList;
	}

	
	
	
}
