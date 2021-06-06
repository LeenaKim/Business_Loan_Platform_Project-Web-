package beone.auth.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.accountant.vo.AccountantVO;
import beone.auth.vo.AuthVO;
import beone.corp.vo.CorpVO;

@Repository
public class AuthDAOImpl implements AuthDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/**
	 * 새로운 인증 요청 
	 */
	@Override
	public void insertNewAuth(AuthVO auth) {
		sqlSession.insert("auth.dao.AuthDAO.insertNewAuth", auth);
		
	}

	/**
	 * 대기중인 모든 리스트 가져오기 
	 */
	@Override
	public List<AuthVO> selectAllAuthWaiting(AccountantVO accountant) {
		List<AuthVO> authList = sqlSession.selectList("auth.dao.AuthDAO.selectAllAuthWaiting", accountant);
		return authList;
	}

	@Override
	public List<AuthVO> selectAllAuthWaitingCorpSide(CorpVO corp) {
		List<AuthVO> authList = sqlSession.selectList("auth.dao.AuthDAO.selectAllAuthWaitingCorpSide", corp);
		return authList;
	}

	@Override
	public void updateAuthStatus(AuthVO auth) {
		sqlSession.update("auth.dao.AuthDAO.updateAuthStatus", auth);
		
	}

	@Override
	public void deleteAuth(AuthVO auth) {

		sqlSession.delete("auth.dao.AuthDAO.deleteAuth", auth);
	}

	
	
}
