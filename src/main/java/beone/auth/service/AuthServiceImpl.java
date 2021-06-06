package beone.auth.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import beone.accountant.vo.AccountantVO;
import beone.auth.dao.AuthDAO;
import beone.auth.vo.AuthVO;
import beone.corp.vo.CorpVO;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private AuthDAO authDAO;
	
	@Override
	public void insertNewAuth(AuthVO auth) {
		authDAO.insertNewAuth(auth);
	}

	@Override
	public List<AuthVO> selectAllAuthWaiting(AccountantVO accountant) {
		List<AuthVO> authList = authDAO.selectAllAuthWaiting(accountant);
		return authList;
	}

	@Override
	public List<AuthVO> selectAllAuthWaitingCorpSide(CorpVO corp) {
		List<AuthVO> authList = authDAO.selectAllAuthWaitingCorpSide(corp);
		return authList;
	}

	@Override
	public void confirmAuth(AuthVO auth) {
		authDAO.updateAuthStatus(auth);
		
	}

	@Override
	public void deleteAuth(AuthVO auth) {

		authDAO.deleteAuth(auth);
	}

	
	
}
