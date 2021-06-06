package beone.loanProd.dao;

import beone.loanProd.vo.LoanProdVO;

public interface LoanProdDAO {

	/**
	 * 상품 하나 가져오기 
	 * @param prodNo
	 * @return
	 */
	LoanProdVO selectOne(String prodNo);
	
	
}
