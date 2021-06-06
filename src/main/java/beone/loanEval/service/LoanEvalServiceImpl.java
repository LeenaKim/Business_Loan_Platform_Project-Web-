package beone.loanEval.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import beone.acnt.dao.AcntDAO;
import beone.acnt.vo.AcntVO;
import beone.loanApp.dao.LoanAppDAO;
import beone.loanApp.vo.LoanAppVO;
import beone.loanEval.dao.LoanEvalDAO;
import beone.loanEval.vo.LoanEvalVO;
import beone.loanHistory.dao.LoanHistoryDAO;
import beone.transaction.dao.TransactionDAO;
import beone.transaction.vo.TransactionVO;

@Service
public class LoanEvalServiceImpl implements LoanEvalService {

	@Autowired
	private LoanAppDAO loanAppDAO;
	
	@Autowired
	private LoanHistoryDAO loanHistoryDAO;
	
	@Autowired
	private AcntDAO acntDAO;
	
	@Autowired
	private TransactionDAO transactionDAO;
	
	@Autowired
	private LoanEvalDAO loanEvalDAO;
	/**
	 * 간편 대출 심사 승인 
	@Transactional
	@Override
	public void loanEvalApprove(LoanAppVO loanApp) {
		
		// 1. 대출신청 테이블 loan_app_status 업데이트
		loanAppDAO.updateLoanAppStatusC(loanApp.getAppNo());
		
		// 2. 대출 내역에 추가 
		loanHistoryDAO.insertNewLoanHis(loanApp);
		
		// 3. 대출금 입금 
		AcntVO loanAcnt = acntDAO.selectOneAcnt(loanApp.getInterestAcnt());
			// 만약 계좌가 유효하지 않다면(신규개설) 유효하게 먼저 바꿔줌
		if(loanAcnt.getValid().equals("I")) {
			acntDAO.validate(loanAcnt.getNo());
		}
		Map<String, Object> map = new HashMap<>();
		map.put("amount", loanApp.getAppAmount());
		map.put("no", loanApp.getLoanAcnt());
		acntDAO.deposit(map);
		
		// 4. 거래내역 추가 
		TransactionVO transaction = new TransactionVO();
		transaction.setSummary("하나 대출금 입금");
		transaction.setMainAcntNo(loanAcnt.getNo());
		transaction.setObjName("하나은행");
		transaction.setdAmount(loanApp.getAppAmount());
		transaction.setCorr("하나");
		transaction.setBalance(loanAcnt.getBalance() + loanApp.getAppAmount());
		
		transactionDAO.insertNewTransaction(transaction);
	}
	 */
	/**
	 * 간편 대출 심사 기각 
	 */
	@Transactional
	@Override
	public void loanEvalRefuse(LoanAppVO loanApp, LoanEvalVO loanEval) {
		// 대출신청 테이블 loan_app_status 업데이트 
		loanAppDAO.updateLoanAppStatusR(loanApp.getAppNo());
		// 심사테이블 인서트 
		loanEvalDAO.insertNewLoanEval(loanEval);
	}
	/**
	 * 2차 대출 심사 승인 
	 */
	@Transactional
	@Override
	public void scndLoanEvalApprove(LoanAppVO loanApp, LoanEvalVO loanEval) {
		
		// 1. 대출신청 테이블 loan_app_status 업데이트
		loanAppDAO.updateLoanAppStatusC(loanApp.getAppNo());
		
		// 2. 대출 내역에 추가 
		loanHistoryDAO.insertNewLoanHis(loanApp);
		
		// 3. 대출금 입금 
		AcntVO loanAcnt = acntDAO.selectOneAcnt(loanApp.getInterestAcnt());
			// 만약 계좌가 유효하지 않다면(신규개설) 유효하게 먼저 바꿔줌
		if(loanAcnt.getValid().equals("I")) {
			acntDAO.validate(loanAcnt.getNo());
		}
		Map<String, Object> map = new HashMap<>();
		map.put("amount", loanApp.getAppAmount());
		map.put("no", loanApp.getLoanAcnt());
		acntDAO.deposit(map);
		
		// 4. 거래내역 추가 
		TransactionVO transaction = new TransactionVO();
		transaction.setSummary("하나 대출금 입금");
		transaction.setMainAcntNo(loanAcnt.getNo());
		transaction.setObjName("하나은행");
		transaction.setdAmount(loanApp.getAppAmount());
		transaction.setCorr("하나");
		transaction.setBalance(loanAcnt.getBalance() + loanApp.getAppAmount());
		
		transactionDAO.insertNewTransaction(transaction);
		
		// 5. 대출심사테이블에 업데이트 
		loanEvalDAO.insertNewLoanEval(loanEval);
	}
	/**
	 * 2차 대출 심사 기각 
	 */
	@Transactional
	@Override
	public void scndLoanEvalRefuse(LoanAppVO loanApp, LoanEvalVO loanEval) {
		// 대출신청 테이블 loan_app_status 업데이트 
		loanAppDAO.updateLoanAppStatusR(loanApp.getAppNo());

		// 대출심사테이블에 업데이트 
		loanEvalDAO.insertNewLoanEval(loanEval);
		
	}
	
	@Override
	public LoanEvalVO selectEvalComment(int appNo) {
		LoanEvalVO loanEval = loanEvalDAO.selectEvalComment(appNo);
		return loanEval;
	}
	
	

}
