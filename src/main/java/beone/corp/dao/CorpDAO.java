package beone.corp.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import beone.corp.vo.CorpVO;
import beone.doc.vo.DocVO;
import beone.finData.vo.FinDataVO;

public interface CorpDAO {

	CorpVO login(CorpVO corp);
	
	List<Map<String, BigDecimal>> selectAllFin(CorpVO corp);
	
	List<Map<String, String>> selectAllCredit(CorpVO corp);
	
	CorpVO selectOneByBizrNo(String bizrNo);
	
	void insertFinData(FinDataVO fd);
	
	void deleteFinData(DocVO doc);
	
	void insertCorp(CorpVO corp);
	
	void updateCorp(CorpVO corp);
	
	String selectCorpCode(String bizrNo);
}
