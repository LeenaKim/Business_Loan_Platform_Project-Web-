package beone.accountant.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.accountant.vo.AccountantVO;
import beone.corp.vo.CorpVO;

@Repository
public class AccountantDAOImpl implements AccountantDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<AccountantVO> selectAll(CorpVO corp) {
		List<AccountantVO> accountantList = sqlSession.selectList("accountant.dao.AccountantDAO.selectAll", corp);
		return accountantList;
	}

	@Override
	public AccountantVO login(AccountantVO acc) {
		AccountantVO accVO = sqlSession.selectOne("accountant.dao.AccountantDAO.login", acc);
		return accVO;
	}

	@Override
	public List<CorpVO> selectAllCorp(String accNo) {
		List<CorpVO> corpList = sqlSession.selectList("accountant.dao.AccountantDAO.selectAllCorp", accNo);
		return corpList;
	}

	
	
}
