package beone.accountant.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import beone.accountant.dao.AccountantDAO;
import beone.accountant.vo.AccountantVO;
import beone.corp.vo.CorpVO;

@Service
public class AccountantServiceImpl implements AccountantService {

	@Autowired
	private AccountantDAO accountantDAO;
	
	@Override
	public List<AccountantVO> selectAll(CorpVO corp) {
		List<AccountantVO> accountantList = accountantDAO.selectAll(corp);
		return accountantList;
	}

	@Override
	public AccountantVO login(AccountantVO acc) {
		AccountantVO accVO = accountantDAO.login(acc);
		return accVO;
	}

	@Override
	public List<CorpVO> selectAllCorp(String accNo) {
		List<CorpVO> corpList = accountantDAO.selectAllCorp(accNo);
		return corpList;
	}

	
}
