package beone.rpyHistory.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import beone.acnt.dao.AcntDAO;
import beone.loanHistory.dao.LoanHistoryDAO;
import beone.rpyHistory.dao.RpyHistoryDAO;
import beone.rpyHistory.vo.RpyHistoryVO;

@Service
public class RpyHistoryServiceImpl implements RpyHistoryService {

	@Autowired
	private RpyHistoryDAO rpyHistoryDAO;
	
	@Autowired
	private AcntDAO acntDAO;
	
	@Autowired
	private LoanHistoryDAO loanHistoryDAO;
	
	@Override
	public List<RpyHistoryVO> selectAllRpyHis(String loanNo) {
		List<RpyHistoryVO> rpyHisList = rpyHistoryDAO.selectAll(loanNo);
		return rpyHisList;
	}

	@Override
	public int chkRpyFee(Map<String, Object> map) {
		int midRpyFee = rpyHistoryDAO.chkRpyFee(map);
		return midRpyFee;
	}

	/**
	 * 대출금 상환 로직 
	 */
	@Transactional
	@Override
	public void newRpyHistory(RpyHistoryVO rpyHistory) {
		// 1. 대출 잔금 수정 - loanHistory (필요 파라미터 : 대출번호, 상환금액) => DB 트리거로 대체 
//		Map<String, Object> loanHisMap = new HashMap<>();
//		loanHisMap.put("loanNo", rpyHistory.getLoanNo());
//		loanHisMap.put("amt", rpyHistory.getMidRpyAmt());
//		loanHistoryDAO.updateLeftAmt(loanHisMap);
		
		// 2. 계좌에서 잔액 수정 - acnt (필요 파라미터 : 계좌번호, 상환금액)
		Map<String, Object> acntMap = new HashMap<>();
		acntMap.put("no", rpyHistory.getLoanAcnt());
		acntMap.put("amt", rpyHistory.getMidRpyAmt());
		acntDAO.updateBalance(acntMap);
		
		// 3. 상환내역 저장 
		rpyHistoryDAO.insertNewRpyHis(rpyHistory);
		
	}
	
	

}
