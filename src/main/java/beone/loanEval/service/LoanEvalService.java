package beone.loanEval.service;

import beone.loanApp.vo.LoanAppVO;
import beone.loanEval.vo.LoanEvalVO;

public interface LoanEvalService {

//	void loanEvalApprove(LoanAppVO loanApp);
	
	void loanEvalRefuse(LoanAppVO loanApp, LoanEvalVO loanEval);
	
	void scndLoanEvalApprove(LoanAppVO loanApp, LoanEvalVO loanEval);
	
	void scndLoanEvalRefuse(LoanAppVO loanApp, LoanEvalVO loanEval);
	
	LoanEvalVO selectEvalComment(int appNo);
}
