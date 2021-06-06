package beone.loanApp.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.emp.vo.EmpVO;
import beone.loanApp.vo.LoanAppVO;

@Repository
public class LoanAppDAOImpl implements LoanAppDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public void insertLoanApp(LoanAppVO loanApp) {

		sqlSession.insert("loanApp.dao.LoanAppDAO.insertLoanApp", loanApp);
	}

	@Override
	public List<LoanAppVO> selectAllLoanApp(String bizrNo) {
		List<LoanAppVO> list = sqlSession.selectList("loanApp.dao.LoanAppDAO.selectAll", bizrNo);
		
		return list;
	}

	@Override
	public int selectCurSeqAppNo() {
		int currAppNo = sqlSession.selectOne("loanApp.dao.LoanAppDAO.CurrSeqAppNo");
		return currAppNo;
	}

	/**
	 * 직원 번호로 담당 대출 신청 내역 조회
	 */
	@Override
	public List<LoanAppVO> selectAllByEmpno(EmpVO emp) {
		List<LoanAppVO> loanAppList = sqlSession.selectList("loanApp.dao.LoanAppDAO.selectAllByEmpno", emp);
		return loanAppList;
	}

	/**
	 * 해당 행원이 담당중인 신규 대출 건수 
	 */
	@Override
	public int selectCntEmp(EmpVO emp) {
		int loanAppCnt = sqlSession.selectOne("loanApp.dao.LoanAppDAO.selectCnt", emp);
		return loanAppCnt;
	}

	@Override
	public List<LoanAppVO> selectPerPage(Map<String, Object> map) {
		List<LoanAppVO> loanAppList = sqlSession.selectList("loanApp.dao.LoanAppDAO.selectPerPage", map);
		return loanAppList;
	}

	@Override
	public LoanAppVO selectOneByAppNo(int appNo) {
		LoanAppVO loanApp = sqlSession.selectOne("loanApp.dao.LoanAppDAO.selectOneByAppNo", appNo);
		return loanApp;
	}

	@Override
	public void updateLoanAppStatusC(int appNo) {
		sqlSession.update("loanApp.dao.LoanAppDAO.loanEvalApprove", appNo);
		
	}

	@Override
	public void updateLoanAppStatusR(int appNo) {
		// TODO Auto-generated method stub
		sqlSession.update("loanApp.dao.LoanAppDAO.loanEvalRefuse", appNo);
		
	}
	
	

}
