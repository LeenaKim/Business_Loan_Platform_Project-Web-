package beone.doc.service;

import java.util.List;

import beone.corp.vo.CorpVO;
import beone.doc.vo.DocVO;
import beone.finData.vo.FinDataVO;

public interface DocService {

	List<DocVO> selectAllDoc(CorpVO corp);
	
	void insertDoc(DocVO doc);
	
	void insertFinDoc(DocVO doc, FinDataVO fd);
	
	void deleteDoc(int docNo);
	
	DocVO selectOneDoc(int docNo);
	
	List<DocVO> selectByAppNo(int appNo);
	
	List<DocVO> selectByDocNoArr(int[] docNo);
	
	void deleteFinData(DocVO doc);
}
