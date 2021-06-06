package beone.acnt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import beone.acnt.dao.AcntDAO;
import beone.acnt.vo.AcntVO;
import beone.corp.vo.CorpVO;
import beone.transaction.dao.TransactionDAO;
import beone.transaction.vo.TransactionVO;

@Service
public class AcntServiceImpl implements AcntService {

	@Autowired
	private AcntDAO acntDAO;
	
	@Autowired
	private TransactionDAO transactionDAO;
	
	@Override
	public AcntVO selectOne(String no) {
		AcntVO acnt = acntDAO.selectOneAcnt(no);
		return acnt;
	}

	@Override
	public void updateBalance(Map<String, Object> map) {
		acntDAO.updateBalance(map);
	}

	@Override
	public List<AcntVO> selectAll(CorpVO corp) {
		List<AcntVO> acntList = acntDAO.selectAllAcnt(corp);
		return acntList;
	}

	@Override
	public AcntVO selectOneByRegDate(CorpVO corp) {
		AcntVO acnt = acntDAO.selectOneByRegDate(corp);
		return acnt;
	}

	
	
}
