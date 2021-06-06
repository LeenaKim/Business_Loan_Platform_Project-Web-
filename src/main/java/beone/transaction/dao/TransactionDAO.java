package beone.transaction.dao;

import java.util.List;
import java.util.Map;

import beone.transaction.vo.TransactionVO;

public interface TransactionDAO {

	List<TransactionVO> selectAllTrans(String no);
	
	List<TransactionVO> selectMoreTrans(Map<String, Object> map);
	
	int selectCntLastThrMons(String no);
	
	List<TransactionVO> selectPerPage(Map<String, Object> map);
	
	int selectCntWithTerms(Map<String, Object> map);
	
	List<TransactionVO> selectPerPageWithTerm(Map<String, Object> map);
	
	int selectCntCustomTerm(Map<String, Object> map);
	
	List<TransactionVO> selectPerPageCustomTerm(Map<String, Object> map);
	
	void insertNewTransaction(TransactionVO transaction);
}
