package beone.corp.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.corp.vo.CorpVO;
import beone.doc.vo.DocVO;
import beone.finData.vo.FinDataVO;

@Repository
public class CorpDAOImpl implements CorpDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public CorpVO login(CorpVO corp) {
		CorpVO userVO = sqlSession.selectOne("corp.dao.CorpDAO.login", corp);
		return userVO;
	}

	@Override
	public List<Map<String, BigDecimal>> selectAllFin(CorpVO corp) {
		List<Map<String, BigDecimal>> finList = sqlSession.selectList("corp.dao.CorpDAO.analysis", corp);
		return finList;
	}

	@Override
	public List<Map<String, String>> selectAllCredit(CorpVO corp) {
		List<Map<String, String>> creditList = sqlSession.selectList("corp.dao.CorpDAO.selectCreditRnk", corp);
		return creditList;
	}

	@Override
	public CorpVO selectOneByBizrNo(String bizrNo) {
		CorpVO corp = sqlSession.selectOne("corp.dao.CorpDAO.selectOneByBizrNo", bizrNo);
		return corp;
	}

	@Override
	public void insertFinData(FinDataVO fd) {
		
		sqlSession.insert("corp.dao.CorpDAO.insertFinData", fd);
	}

	@Override
	public void deleteFinData(DocVO doc) {
		sqlSession.delete("corp.dao.CorpDAO.deleteFinData", doc);
	}

	@Override
	public void insertCorp(CorpVO corp) {
		sqlSession.insert("corp.dao.CorpDAO.insertCorp", corp);
	}

	@Override
	public void updateCorp(CorpVO corp) {
		sqlSession.update("corp.dao.CorpDAO.updateCorp", corp);
		
	}

	@Override
	public String selectCorpCode(String bizrNo) {
		String corpCode = sqlSession.selectOne("corp.dao.CorpDAO.selectCorpCode",  bizrNo);
		return corpCode;
	}

	
	

}
