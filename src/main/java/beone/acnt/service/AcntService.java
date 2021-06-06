package beone.acnt.service;

import java.util.List;
import java.util.Map;

import beone.acnt.vo.AcntVO;
import beone.corp.vo.CorpVO;
import beone.transaction.vo.TransactionVO;

public interface AcntService {

	/**
	 * 계좌번호로 계좌 정보 검색 
	 * @param no
	 * @return
	 */
	public AcntVO selectOne(String no);
	
	/**
	 * 계좌 잔액 변경 
	 * @param map (계좌번호, 금액)
	 */
	void updateBalance(Map<String, Object> map);
	
	/**
	 * 유저 소유의 모든 계좌 조회
	 * @param corp
	 * @return
	 */
	List<AcntVO> selectAll(CorpVO corp);
	/**
	 * 가장 최근에 개설된 계좌 하나만 가져오기 
	 * @param corp
	 * @return
	 */
	AcntVO selectOneByRegDate(CorpVO corp);
}
