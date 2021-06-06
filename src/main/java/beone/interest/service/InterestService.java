package beone.interest.service;

import java.util.List;
import java.util.Map;

import beone.interest.vo.InterestVO;

public interface InterestService {

	List<InterestVO> selectPerPage(Map<String, Object> map);
	
	int selectCnt(String loanNo);
	
	void autoPayInterest3();
	void autoPayInterest12();
	void autoPayInterest23();
	
	List<InterestVO> selectAllByLoanNo(String loanNo);
}
