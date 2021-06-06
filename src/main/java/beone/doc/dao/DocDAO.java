package beone.doc.dao;

import java.util.List;
import java.util.Map;

import beone.corp.vo.CorpVO;
import beone.doc.vo.DocVO;

public interface DocDAO {

	/**
	 * 기업이 소유한 모든 서류 출력 
	 * @param corp
	 * @return
	 */
	List<DocVO> selectAll(CorpVO corp);
	
	/**
	 * 서류 업로드 
	 * @param doc
	 */
	void insert(DocVO doc);
	
	/**
	 * 서류 삭제 
	 * @param docNo
	 */
	void delete(int docNo);
	
	/**
	 * 서류 하나 선택 
	 * @param docNo
	 * @return
	 */
	DocVO selectOne(int docNo);
	
	/**
	 * 대출 신청 번호로 신청 서류 검색 
	 * @param appNo
	 * @return
	 */
	List<DocVO> selectByAppNo(int appNo);
	/**
	 * 서류번호 배열로 서류값 가져오기 
	 * @param docNo
	 * @return
	 */
	List<DocVO> selectByDocNoArr(int[] docNo);
}
