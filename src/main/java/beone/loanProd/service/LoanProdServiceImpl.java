package beone.loanProd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import beone.loanProd.dao.LoanProdDAO;
import beone.loanProd.vo.LoanProdVO;

@Service
public class LoanProdServiceImpl implements LoanProdService {

	@Autowired
	private LoanProdDAO loanProdDAO;
	
	@Override
	public LoanProdVO selectOne(String prodNo) {
		LoanProdVO loanProd = loanProdDAO.selectOne(prodNo);
		return loanProd;
	}

}
