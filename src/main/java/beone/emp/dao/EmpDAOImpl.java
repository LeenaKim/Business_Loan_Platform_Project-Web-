package beone.emp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.emp.vo.EmpVO;

@Repository
public class EmpDAOImpl implements EmpDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public EmpVO login(EmpVO emp) {
		EmpVO empVO = sqlSession.selectOne("emp.dao.EmpDAO.login", emp);
		return empVO;
	}

	@Override
	public List<EmpVO> loanAppCntByEmp(EmpVO emp) {
		List<EmpVO> empList = sqlSession.selectList("emp.dao.EmpDAO.loanAppCntByEmp", emp);
		return empList;
	}

	
}
