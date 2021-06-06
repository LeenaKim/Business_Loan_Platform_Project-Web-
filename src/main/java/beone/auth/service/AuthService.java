package beone.auth.service;

import java.util.List;

import beone.accountant.vo.AccountantVO;
import beone.auth.vo.AuthVO;
import beone.corp.vo.CorpVO;

public interface AuthService {

	void insertNewAuth(AuthVO auth);
	
	List<AuthVO> selectAllAuthWaiting(AccountantVO accountant);
	
	List<AuthVO> selectAllAuthWaitingCorpSide(CorpVO corp);
	
	void confirmAuth(AuthVO auth);
	
	void deleteAuth(AuthVO auth);
}
