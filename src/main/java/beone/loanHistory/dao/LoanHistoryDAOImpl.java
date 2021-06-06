package beone.loanHistory.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.emp.vo.EmpVO;
import beone.loanApp.vo.LoanAppVO;
import beone.loanHistory.vo.LoanHistoryVO;

@Repository
public class LoanHistoryDAOImpl implements LoanHistoryDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<LoanHistoryVO> selectAllLoanHistory(String bizrNo) {
		List<LoanHistoryVO> list = sqlSession.selectList("loanHistory.dao.LoanHistoryDAO.selectAll", bizrNo);
		return list;
	}

	@Override
	public void updateLeftAmt(Map<String, Object> map) {
		sqlSession.update("oanHistory.dao.LoanHistoryDAO.updateLeftAmt", map);
	}

	@Override
	public LoanHistoryVO selectByLoanNo(String loanNo) {
		LoanHistoryVO loanHis = sqlSession.selectOne("loanHistory.dao.LoanHistoryDAO.selectOne", loanNo);
		return loanHis;
	}

	@Override
	public List<LoanHistoryVO> selectAllByEmpno(EmpVO emp) {
		List<LoanHistoryVO> loanHisList = sqlSession.selectList("loanHistory.dao.LoanHistoryDAO.selectAllByEmpno", emp);
		return loanHisList;
	}

	@Override
	public List<LoanHistoryVO> selectAllPerPage(Map<String, Object> map) {
		List<LoanHistoryVO> loanHisListPerPage = sqlSession.selectList("loanHistory.dao.LoanHistoryDAO.selectPerPage", map);
		return loanHisListPerPage;
	}

	@Override
	public int selectCnt(EmpVO emp) {
		int loanHisCnt = sqlSession.selectOne("loanHistory.dao.LoanHistoryDAO.selectCnt", emp);
		return loanHisCnt;
	}

	@Override
	public void updateLoanStatusSch() {
		sqlSession.update("loanHistory.dao.LoanHistoryDAO.updateLoanStatusSch");
	}

	@Override
	public LoanHistoryVO selectOneLatest(String bizrNo) {
		LoanHistoryVO loanHis = sqlSession.selectOne("loanHistory.dao.LoanHistoryDAO.selectOneLatest", bizrNo);
		return loanHis;
	}

	@Override
	public void insertNewLoanHis(LoanAppVO loanApp) {

		sqlSession.insert("loanHistory.dao.LoanHistoryDAO.insertNewLoanHis", loanApp);
	}

	@Override
	public List<LoanHistoryVO> selectAllPagingByBizrNo(Map<String, Object> map) {
		List<LoanHistoryVO> loanHisList = sqlSession.selectList("loanHistory.dao.LoanHistoryDAO.selectAllPaging", map);
		return loanHisList;
	}

	@Override
	public int selectCntPagingByBizrNo(String bizrNo) {
		int cnt = sqlSession.selectOne("loanHistory.dao.LoanHistoryDAO.selectCntPaging", bizrNo);
		return cnt;
	}

	@Override
	public void updateFocusLoan(String loanNo) {
		sqlSession.update("loanHistory.dao.LoanHistoryDAO.updateFocusLoan", loanNo);
		
	}

	@Override
	public List<LoanHistoryVO> selectAllFocusLoan(String empno) {
		List<LoanHistoryVO> focusLoanList = sqlSession.selectList("loanHistory.dao.LoanHistoryDAO.selectFocusLoan", empno);
		return focusLoanList;
	}

	
	
	
}
