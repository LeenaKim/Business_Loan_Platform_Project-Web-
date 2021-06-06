package beone.corp.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import beone.corp.dao.CorpDAO;
import beone.corp.vo.CorpVO;
import beone.exception.AlreadyExistingCorpException;
import beone.rep.dao.RepDAO;
import beone.rep.vo.RepVO;

@Service
public class CorpServiceImpl implements CorpService {

	@Autowired
	private CorpDAO corpDAO;
	
	@Autowired
	private RepDAO repDAO;
	
	@Override
	public CorpVO login(CorpVO corp) {
		CorpVO userVO = corpDAO.login(corp);
		return userVO;
	}

	/**
	 * 해당 기업의 모든 대표 조회 
	 */
	@Override
	public List<RepVO> selectAllRep(CorpVO corp) {
		List<RepVO> list = repDAO.selectAll(corp);
		return list;
	}

	@Override
	public List<Map<String, BigDecimal>> selectAllFin(CorpVO corp) {
		List<Map<String, BigDecimal>> finList = corpDAO.selectAllFin(corp);
		return finList;
	}

	@Override
	public List<Map<String, String>> selectAllCredit(CorpVO corp) {
		List<Map<String, String>> creditList = corpDAO.selectAllCredit(corp);
		return creditList;
	}

	@Override
	public CorpVO selectOneByBizrNo(String bizrNo) {
		CorpVO corp = corpDAO.selectOneByBizrNo(bizrNo);
		return corp;
	}

	@Override
	public void registerNewCorp(CorpVO corp) {
		// 회원가입을 신청한 기업의 사업자번호로 DB에 이미 있는 사업자인지 검색 
		CorpVO duplicateCorp = corpDAO.selectOneByBizrNo(corp.getBizrNo());
		if(duplicateCorp != null) {
			// 만약 있는 사업자라면 사용자정의예외 던지기 
			throw new AlreadyExistingCorpException(corp.getBizrNo() + "는 중복된 사업자번호입니다.");
		}
		corpDAO.insertCorp(corp);
	}

	@Override
	public CorpVO updateCorp(CorpVO corp) {
		// 정보 수정 
		corpDAO.updateCorp(corp);
		// 다시 로그인 
		CorpVO corpVO = corpDAO.login(corp);
		return corpVO;
	}

	@Override
	public String selectCorpCode(String bizrNo) {
		String corpCode = corpDAO.selectCorpCode(bizrNo);
		return corpCode;
	}

	
	
	
	
}
