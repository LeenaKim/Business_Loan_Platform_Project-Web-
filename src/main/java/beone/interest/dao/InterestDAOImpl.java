package beone.interest.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.interest.vo.InterestVO;

@Repository
public class InterestDAOImpl implements InterestDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<InterestVO> selectPerPage(Map<String, Object> map) {
		List<InterestVO> intrList = sqlSession.selectList("interest.dao.InterestDAO.selectPerPage", map);
		return intrList;
	}

	@Override
	public int selectCnt(String loanNo) {
		int cnt = sqlSession.selectOne("interest.dao.InterestDAO.selectCnt", loanNo);
		return cnt;
	}

	@Override
	public void autoInterestPay(String mon) {
		sqlSession.insert("interest.dao.InterestDAO.autoInterestPay", mon);
		
	}

	@Override
	public List<InterestVO> selectAllByLoanNo(String loanNo) {
		List<InterestVO> intrList = sqlSession.selectList("interest.dao.InterestDAO.selectAllByLoanNo", loanNo);
		return intrList;
	}

	
}
