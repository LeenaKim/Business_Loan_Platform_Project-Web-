package beone.transaction.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.transaction.vo.TransactionVO;

@Repository
public class TransactionDAOImpl implements TransactionDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<TransactionVO> selectAllTrans(String no) {
		List<TransactionVO> transList = sqlSession.selectList("transaction.dao.TransactionDAO.selectAll", no);
		return transList;
	}

	@Override
	public List<TransactionVO> selectMoreTrans(Map<String, Object> map) {
		List<TransactionVO> transList = sqlSession.selectList("transaction.dao.TransactionDAO.selectNextAll", map);
		return transList;
	}

	@Override
	public int selectCntLastThrMons(String no) {
		int cnt = sqlSession.selectOne("transaction.dao.TransactionDAO.selectCntLastThrMons", no);
		return cnt;
	}

	@Override
	public List<TransactionVO> selectPerPage(Map<String, Object> map) {
		List<TransactionVO> transList = sqlSession.selectList("transaction.dao.TransactionDAO.selectPerPage", map);
		return transList;
	}

	@Override
	public int selectCntWithTerms(Map<String, Object> map) {
		int cnt = sqlSession.selectOne("transaction.dao.TransactionDAO.selectCntWithTerms", map);
		return cnt;
	}

	@Override
	public List<TransactionVO> selectPerPageWithTerm(Map<String, Object> map) {
		List<TransactionVO> transList = sqlSession.selectList("transaction.dao.TransactionDAO.selectPerPageWithTerm", map);
		return transList;
	}
	
	@Override
	public int selectCntCustomTerm(Map<String, Object> map) {
		int cnt = sqlSession.selectOne("transaction.dao.TransactionDAO.selectCntCustomTerm", map);
		return cnt;
	}
	
	@Override
	public List<TransactionVO> selectPerPageCustomTerm(Map<String, Object> map) {
		List<TransactionVO> transList = sqlSession.selectList("transaction.dao.TransactionDAO.selectPerPageCustomTerm", map);
		return transList;
	}

	@Override
	public void insertNewTransaction(TransactionVO transaction) {
		sqlSession.insert("transaction.dao.TransactionDAO.insertNewTrans", transaction);
	}
	
}
