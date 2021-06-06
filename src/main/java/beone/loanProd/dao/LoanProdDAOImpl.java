package beone.loanProd.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.loanProd.vo.LoanProdVO;

@Repository
public class LoanProdDAOImpl implements LoanProdDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public LoanProdVO selectOne(String prodNo) {
		LoanProdVO loan = sqlSession.selectOne("loanProd.dao.loanProdDAO.selectOndProd", prodNo);
		return loan;
	}

}
