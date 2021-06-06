package beone.loanApp.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import beone.doc.dao.DocDAO;
import beone.doc.vo.DocVO;
import beone.emp.vo.EmpVO;
import beone.loanApp.dao.LoanAppDAO;
import beone.loanApp.vo.LoanAppVO;
import beone.loanDoc.dao.LoanDocDAO;

@Service
public class LoanAppServiceImpl implements LoanAppService {

	@Autowired
	private LoanAppDAO loanAppDAO;
	
	@Autowired
	private LoanDocDAO loanDocDAO;
	
	@Autowired
	private DocDAO docDAO;
	
	@Autowired
	private ServletContext servletContext;
	
	@Transactional
	@Override
	public void insertLoanApp(LoanAppVO loanApp, int[] docNo) {
		
		// 1. 신청 서류를 서류보관함에서 찾아 별도의 폴더에 복사 
		List<DocVO> docList = docDAO.selectByDocNoArr(docNo);
		System.out.println(docList);
		
				
		for(DocVO doc : docList) {
			String oriDir = servletContext.getRealPath("/docs/");
			oriDir = oriDir + doc.getDocType() + "/" + doc.getDocSaveName();
			String copyDir = servletContext.getRealPath("/loanDocs/");
			copyDir = copyDir + doc.getDocType() + "/" + doc.getDocSaveName();
				
			File oriFile = new File(oriDir);
			File copyFile = new File(copyDir);
					
			try {
				FileInputStream fis = new FileInputStream(oriFile); //읽을파일 
				FileOutputStream fos = new FileOutputStream(copyFile);//복사할파일 
						
				int fileByte = 0;
				while((fileByte = fis.read()) != -1) {
					fos.write(fileByte);
				}		
				// 자원사용종료
				fis.close();
				fos.close();
					
			} catch(Exception e) {
				e.printStackTrace();
			}
						
		}
				
		// 2. 신청 내역 저장 
		loanAppDAO.insertLoanApp(loanApp);
		
		// 3. 신청 번호 가져오기
		int CurrAppNo = loanAppDAO.selectCurSeqAppNo();
		
		// 4. 신청 서류 저장 - 신청시 선택한 서류가 몇개일지 모르므로 배열로 받아 하나씩 map에 넣어 insert.
		Map<String, Integer> map = new HashMap<>();
		map.put("appNo", CurrAppNo);
		for(int i = 0; i < docNo.length; i++) {
			System.out.println(i + "번째 신청서류 : " + docNo[i]);
			map.put("docNo", docNo[i]);
			loanDocDAO.insertLoanDoc(map);
		}
	}

	@Override
	public List<LoanAppVO> selectAllLoanApp(String bizrNo) {
		List<LoanAppVO> list = loanAppDAO.selectAllLoanApp(bizrNo);
		return list;
	}

	@Override
	public List<LoanAppVO> selectAllByEmpno(EmpVO emp) {
		List<LoanAppVO> loanAppList = loanAppDAO.selectAllByEmpno(emp);
		return loanAppList;
	}

	@Override
	public int selectCnt(EmpVO emp) {
		int loanAppCnt = loanAppDAO.selectCntEmp(emp);
		return loanAppCnt;
	}

	@Override
	public List<LoanAppVO> selectPerPage(Map<String, Object> map) {
		List<LoanAppVO> loanAppList = loanAppDAO.selectPerPage(map);
		return loanAppList;
	}

	@Override
	public LoanAppVO selectOneByAppNo(int appNo) {
		LoanAppVO loanApp = loanAppDAO.selectOneByAppNo(appNo);
		return loanApp;
	}
	
	

	

	
	
}
