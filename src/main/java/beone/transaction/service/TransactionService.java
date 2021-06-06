package beone.transaction.service;

import java.util.List;
import java.util.Map;

import beone.transaction.vo.TransactionVO;

public interface TransactionService {

	/**
	 * 해당 계좌의 모든 거래내역 조회
	 * @param no
	 * @return
	 */
	List<TransactionVO> viewAllTransaction(String no);
	/**
	 * 다음 20개 내역 조회 
	 * @param map
	 * @return
	 */
	List<TransactionVO> viewNextTrans(Map<String, Object> map);
	/**
	 * 최근 3개월 거래내역 총 건수 
	 * @param no
	 * @return
	 */
	int selectCntLastThrMons(String no);
	/**
	 * 페이지당 거래내역 조회 
	 * @param map
	 * @return
	 */
	List<TransactionVO> viewPerPage(Map<String, Object> map);
	/**
	 * 기간 안에 일어난 거래내역 건수 
	 * @param no
	 * @return
	 */
	int selectCntWithTerms(Map<String, Object> map);
	/**
	 * 기간 안에 일어난 거래내역 페이지당 조회 
	 * @param map
	 * @return
	 */
	List<TransactionVO> viewPerPageWithTerm(Map<String, Object> map);
	/**
	 * 상세 조건 검색 기간내 일어난 거래내역 건수 
	 * @param map
	 * @return
	 */
	int selectCntCustomTerm(Map<String, Object> map);
	/**
	 * 상세 조건 검색 기간내 일어난 거래내역 리스트 
	 * @param map
	 * @return
	 */
	List<TransactionVO> selectPerPageCustomTerm(Map<String, Object> map);
}
