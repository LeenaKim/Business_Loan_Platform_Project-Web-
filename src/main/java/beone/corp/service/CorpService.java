package beone.corp.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import beone.corp.vo.CorpVO;
import beone.rep.vo.RepVO;


public interface CorpService {

	CorpVO login(CorpVO corp);
	/**
	 * 해당 기업의 모든 대표 조회 
	 * @param corp
	 * @return
	 */
	List<RepVO> selectAllRep(CorpVO corp);
	/**
	 * 해당 기업의 3개년 재무제표 조회 
	 * @param corp
	 * @return
	 */
	List<Map<String, BigDecimal>> selectAllFin(CorpVO corp);
	
	/**
	 * 해당 기업의 신용등급 이력 조회
	 * @param corp
	 * @return
	 */
	List<Map<String, String>> selectAllCredit(CorpVO corp);
	/**
	 * 사업자등록번호로 기업 조회 
	 * @param bizrNo
	 * @return
	 */
	CorpVO selectOneByBizrNo(String bizrNo);
	/**
	 * 새 기업 회원가입 
	 * @param corp
	 */
	void registerNewCorp(CorpVO corp);
	
	/**
	 * 기업 정보 수정
	 * @param corp
	 * @return
	 */
	CorpVO updateCorp(CorpVO corp);
	/**
	 * 다트 재무제표 조회를 위한 기업 코드 조회 
	 * @param bizrNo
	 * @return
	 */
	String selectCorpCode(String bizrNo);
	
}
