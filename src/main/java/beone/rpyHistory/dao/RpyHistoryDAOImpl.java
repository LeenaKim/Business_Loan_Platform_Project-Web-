package beone.rpyHistory.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.loanHistory.vo.LoanHistoryVO;
import beone.rpyHistory.vo.RpyHistoryVO;

@Repository
public class RpyHistoryDAOImpl implements RpyHistoryDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<RpyHistoryVO> selectAll(String loanNo) {
		List<RpyHistoryVO> rpyHisList = sqlSession.selectList("rpyHistory.dao.RpyHistoryDAO.selectAll", loanNo);
		
		return rpyHisList;
	}

	@Override
	public int chkRpyFee(Map<String, Object> map) {
		int midRpyFee = sqlSession.selectOne("rpyHistory.dao.RpyHistoryDAO.chkRpyFee", map);
		System.out.println("DAO midRpyFee : " + midRpyFee);
		return midRpyFee;
	}

	@Override
	public void insertNewRpyHis(RpyHistoryVO rpyHistory) {
		sqlSession.insert("rpyHistory.dao.RpyHistoryDAO.insertOne", rpyHistory);
	}

	
	

	
}
