package beone.accountant.dao;

import java.util.List;

import beone.accountant.vo.AccountantVO;
import beone.corp.vo.CorpVO;

public interface AccountantDAO {

	List<AccountantVO> selectAll(CorpVO corp);
	
	AccountantVO login(AccountantVO acc);
	
	List<CorpVO> selectAllCorp(String accNo);
}
