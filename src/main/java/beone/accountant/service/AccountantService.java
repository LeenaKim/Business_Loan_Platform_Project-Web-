package beone.accountant.service;

import java.util.List;

import beone.accountant.vo.AccountantVO;
import beone.corp.vo.CorpVO;

public interface AccountantService {

	List<AccountantVO> selectAll(CorpVO corp);
	
	AccountantVO login(AccountantVO acc);
	
	List<CorpVO> selectAllCorp(String accNo);
}
