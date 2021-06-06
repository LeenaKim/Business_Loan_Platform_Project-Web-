package beone.rpyHistory.dao;

import java.util.List;
import java.util.Map;

import beone.loanHistory.vo.LoanHistoryVO;
import beone.rpyHistory.vo.RpyHistoryVO;

public interface RpyHistoryDAO {

	List<RpyHistoryVO> selectAll(String loanNo);
	/**
	 * 중도상환수수료 체크 
	 * @param loanNo 대촐 번호 
	 * @param midRpyAmt 중도상환금액 
	 * @return
	 */
	int chkRpyFee(Map<String, Object> map);
	/**
	 * 새로운 상환내역 저장 
	 * @param rpyHistory
	 */
	void insertNewRpyHis(RpyHistoryVO rpyHistory);
	
}
