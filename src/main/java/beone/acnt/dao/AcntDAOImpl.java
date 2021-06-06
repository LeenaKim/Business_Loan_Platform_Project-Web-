package beone.acnt.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.acnt.vo.AcntVO;
import beone.corp.vo.CorpVO;

@Repository
public class AcntDAOImpl implements AcntDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public AcntVO selectOneAcnt(String no) {
		AcntVO acnt = sqlSession.selectOne("acnt.dao.AcntDAO.selectOne", no);
		return acnt;
	}

	@Override
	public void updateBalance(Map<String, Object> map) {

		sqlSession.update("acnt.dao.AcntDAO.updateBalance", map);
	}

	@Override
	public List<AcntVO> selectAllAcnt(CorpVO corp) {
		List<AcntVO> acntList = sqlSession.selectList("acnt.dao.AcntDAO.selectAll", corp);
		return acntList;
	}

	@Override
	public AcntVO selectOneByRegDate(CorpVO corp) {
		AcntVO acnt = sqlSession.selectOne("acnt.dao.AcntDAO.selectOneByRegDate", corp);
		return acnt;
	}

	@Override
	public void deposit(Map<String, Object> map) {
		sqlSession.update("acnt.dao.AcntDAO.deposit", map);
		
	}

	@Override
	public void validate(String no) {

		sqlSession.update("acnt.dao.AcntDAO.validate", no);
	}

	
}
