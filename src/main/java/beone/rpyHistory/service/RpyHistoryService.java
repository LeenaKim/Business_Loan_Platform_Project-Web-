package beone.rpyHistory.service;

import java.util.List;
import java.util.Map;

import beone.rpyHistory.vo.RpyHistoryVO;

public interface RpyHistoryService {

	/** 
	 * 해당 대출의 모든 상환내역 출력 
	 * @param corp
	 * @return
	 */
	List<RpyHistoryVO> selectAllRpyHis(String loanNo);
	/**
	 * 중도상환수수료 체크 
	 * @param map
	 * @return
	 */
	int chkRpyFee(Map<String, Object> map);
	/**
	 * 새로운 상환내역이 들어올때 수행할 비즈니스 로직 
	 * @param rpyHistory
	 */
	void newRpyHistory(RpyHistoryVO rpyHistory);
}
