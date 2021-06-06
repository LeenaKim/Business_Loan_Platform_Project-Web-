package beone.doc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import beone.corp.dao.CorpDAO;
import beone.corp.vo.CorpVO;
import beone.doc.dao.DocDAO;
import beone.doc.vo.DocVO;
import beone.finData.vo.FinDataVO;

@Service
public class DocServiceImpl implements DocService {

	@Autowired
	private DocDAO docDAO;
	
	@Autowired
	private CorpDAO corpDAO;
	
	@Override
	public List<DocVO> selectAllDoc(CorpVO corp) {
		List<DocVO> list = docDAO.selectAll(corp);
		System.out.println(list);
		return list;
	}

	@Override
	public void insertDoc(DocVO doc) {
		docDAO.insert(doc);
	}
	
	
	@Transactional
	@Override
	public void insertFinDoc(DocVO doc, FinDataVO fd) {
		docDAO.insert(doc);
		corpDAO.insertFinData(fd);
	}

	@Override
	public void deleteDoc(int docNo) {
		docDAO.delete(docNo);
	}

	@Override
	public DocVO selectOneDoc(int docNo) {
		DocVO doc = docDAO.selectOne(docNo);
		return doc;
	}

	@Override
	public List<DocVO> selectByAppNo(int appNo) {
		List<DocVO> docList = docDAO.selectByAppNo(appNo);
		return docList;
	}

	@Override
	public List<DocVO> selectByDocNoArr(int[] docNo) {
		List<DocVO> docList = docDAO.selectByDocNoArr(docNo);
		return docList;
	}

	@Transactional
	@Override
	public void deleteFinData(DocVO doc) {
		docDAO.delete(doc.getDocNo());
		corpDAO.deleteFinData(doc);
	}
	
	
	

	
}
