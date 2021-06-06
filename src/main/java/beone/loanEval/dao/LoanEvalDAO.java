package beone.loanEval.dao;

import beone.loanEval.vo.LoanEvalVO;

public interface LoanEvalDAO {

	void insertNewLoanEval(LoanEvalVO loanEval);
	
	LoanEvalVO selectEvalComment(int appNo);
}
