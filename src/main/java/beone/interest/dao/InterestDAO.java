package beone.interest.dao;

import java.util.List;
import java.util.Map;

import beone.interest.vo.InterestVO;

public interface InterestDAO {

	List<InterestVO> selectPerPage(Map<String, Object> map);
	
	int selectCnt(String loanNo);
	
	void autoInterestPay(String mon);
	
	List<InterestVO> selectAllByLoanNo(String loanNo);
}
