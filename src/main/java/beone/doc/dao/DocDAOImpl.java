package beone.doc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.corp.vo.CorpVO;
import beone.doc.vo.DocVO;

@Repository
public class DocDAOImpl implements DocDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<DocVO> selectAll(CorpVO corp) {
		
		List<DocVO> list = sqlSession.selectList("doc.dao.DocDAO.selectAll", corp);
		return list;
	}

	@Override
	public void insert(DocVO doc) {

		sqlSession.insert("doc.dao.DocDAO.insert", doc);
	}

	@Override
	public void delete(int docNo) {
		sqlSession.delete("doc.dao.DocDAO.delete", docNo);
	}

	@Override
	public DocVO selectOne(int docNo) {
		
		DocVO doc = sqlSession.selectOne("doc.dao.DocDAO.selectOne", docNo);
		return doc;
	}

	@Override
	public List<DocVO> selectByAppNo(int appNo) {
		List<DocVO> docList = sqlSession.selectList("doc.dao.DocDAO.selectByAppNo", appNo);
		return docList;
	}

	@Override
	public List<DocVO> selectByDocNoArr(int[] docNo) {
		List<DocVO> docList = sqlSession.selectList("doc.dao.DocDAO.selectByDocNoArr", docNo);
		return docList;
	}
	
	
	
	

}
