package beone.loanDoc.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoanDocDAOImpl implements LoanDocDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/**
	 * 새로운 신청 서류 등록 
	 */
	@Override
	public void insertLoanDoc(Map<String, Integer> map) {

		sqlSession.insert("loanDoc.dao.loanDocDAO.insert", map);
	}

}
