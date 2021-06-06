package beone.auth.dao;


import java.util.List;

import beone.accountant.vo.AccountantVO;
import beone.auth.vo.AuthVO;
import beone.corp.vo.CorpVO;

public interface AuthDAO {

	void insertNewAuth(AuthVO auth);
	
	List<AuthVO> selectAllAuthWaiting(AccountantVO accountant);
	
	List<AuthVO> selectAllAuthWaitingCorpSide(CorpVO corp);
	
	void updateAuthStatus(AuthVO auth);
	
	void deleteAuth(AuthVO auth);
}
