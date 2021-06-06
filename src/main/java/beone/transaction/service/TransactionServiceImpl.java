package beone.transaction.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import beone.transaction.dao.TransactionDAO;
import beone.transaction.vo.TransactionVO;

@Service
public class TransactionServiceImpl implements TransactionService {

	@Autowired
	private TransactionDAO transactionDAO;
	
	@Override
	public List<TransactionVO> viewAllTransaction(String no) {
		List<TransactionVO> transList = transactionDAO.selectAllTrans(no);
		return transList;
	}

	@Override
	public List<TransactionVO> viewNextTrans(Map<String, Object> map) {
		List<TransactionVO> transList = transactionDAO.selectMoreTrans(map);
		return transList;
	}

	@Override
	public int selectCntLastThrMons(String no) {
		int cnt = transactionDAO.selectCntLastThrMons(no);
		return cnt;
	}

	@Override
	public List<TransactionVO> viewPerPage(Map<String, Object> map) {
		List<TransactionVO> transList = transactionDAO.selectPerPage(map);
		return transList;
	}

	@Override
	public int selectCntWithTerms(Map<String, Object> map) {
		int cnt = transactionDAO.selectCntWithTerms(map);
		return cnt;
	}

	@Override
	public List<TransactionVO> viewPerPageWithTerm(Map<String, Object> map) {
		List<TransactionVO> transList = transactionDAO.selectPerPageWithTerm(map);
		return transList;
	}
	@Override
	public int selectCntCustomTerm(Map<String, Object> map) {
		int cnt = transactionDAO.selectCntCustomTerm(map);
		return cnt;
	}
	
	@Override
	public List<TransactionVO> selectPerPageCustomTerm(Map<String, Object> map) {
		List<TransactionVO> transList = transactionDAO.selectPerPageCustomTerm(map);
		return transList;
	}
	
}
