package beone.acnt.dao;

import java.util.List;
import java.util.Map;

import beone.acnt.vo.AcntVO;
import beone.corp.vo.CorpVO;

public interface AcntDAO {

	public AcntVO selectOneAcnt(String no);
	
	public void updateBalance(Map<String, Object> map);
	
	List<AcntVO> selectAllAcnt(CorpVO corp);
	
	AcntVO selectOneByRegDate(CorpVO corp);
	
	void deposit(Map<String, Object> map);
	
	void validate(String no);
}
