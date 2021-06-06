package beone.loanEval.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.loanEval.vo.LoanEvalVO;

@Repository
public class LoanEvalImpl implements LoanEvalDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void insertNewLoanEval(LoanEvalVO loanEval) {

		sqlSession.insert("loanEval.dao.LoanEvalDAO.insertNewLoanEval", loanEval);
	}

	@Override
	public LoanEvalVO selectEvalComment(int appNo) {
		LoanEvalVO loanEval = sqlSession.selectOne("loanEval.dao.LoanEvalDAO.selectEvalComment", appNo);
		return loanEval;
	}

	
}
