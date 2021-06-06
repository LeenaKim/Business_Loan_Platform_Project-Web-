package beone.accountant.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import beone.accountant.service.AccountantService;
import beone.accountant.vo.AccountantVO;
import beone.auth.service.AuthService;
import beone.auth.vo.AuthVO;
import beone.corp.service.CorpService;
import beone.corp.vo.CorpVO;
import beone.doc.service.DocService;
import beone.doc.vo.DocVO;
import beone.finData.vo.FinDataVO;

@SessionAttributes("accVO")
@Controller
public class AccountantController {

	@Autowired
	private AccountantService accountantService;
	
	@Autowired
	private CorpService corpService;
	
	@Autowired
	private DocService docService;
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private AuthService authService;
	
	/**
	 * 세무사 로그인 페이지로 이동 
	 * @return
	 */
	@GetMapping("/loginAcc")
	public String loginAcc() {
		return "login/loginAcc";
	}
	
	
	/**
	 * 세무사 로그인 기능 
	 * @param corp
	 * @param session
	 * @param result
	 * @return
	 */
//	@RequestMapping(value="/login", method = RequestMethod.POST)
	@PostMapping("/loginAcc")
	public ModelAndView login(AccountantVO acc, HttpSession session, BindingResult result) {
		
//		CorpVO userVO = corpService.login(corp);
		AccountantVO accVO = accountantService.login(acc);
		ModelAndView mav = new ModelAndView();
		
		// 로그인 실패 
		if(accVO == null) {
			mav.setViewName("login/loginAcc");
			mav.addObject("loginResult", "* 없는 아이디거나 비밀번호가 맞지 않습니다.");
		} 
		else {
			// 로그인 성공 
			if(session.getAttribute("dest") != null) {
				System.out.println(session.getAttribute("dest"));
				mav.setViewName("redirect:/" + session.getAttribute("dest"));				
				session.removeAttribute("dest");
			} else {
				mav.setViewName("redirect:/");		
			}
			mav.addObject("accVO", accVO);			
		}
		
		return mav;
	}
	
	/**
	 * 세무사 마이페이지 
	 * @return
	 */
	@GetMapping("/acc/mypage")
	public ModelAndView accMyPage(HttpSession session) {
		
		AccountantVO acc = (AccountantVO)session.getAttribute("accVO");
		ModelAndView mav = new ModelAndView("acc/mypage");
		
		// 담당하고있는 기업정보 가져오기 
		List<CorpVO> corpList = accountantService.selectAllCorp(acc.getAccNo());
		// 기다리는 모든 인증리스트 가져오기 
		List<AuthVO> authList = authService.selectAllAuthWaiting(acc);
		mav.addObject("corpList", corpList);
		mav.addObject("authList", authList);
		
		return mav;
	}
	/**
	 * 세무사 서류보관함 페이지 로드 
	 * @return
	 */
	@GetMapping("/acc/docUpload/{bizrNo}")
	public ModelAndView accDocUpload(@PathVariable("bizrNo") String bizrNo) {
		ModelAndView mav = new ModelAndView("acc/docUploadAcc");
		CorpVO corp = corpService.selectOneByBizrNo(bizrNo);
		mav.addObject("corp", corp);
		return mav;
	}
	
	/**
	 * 보유한 서류 조회 
	 * @param session
	 * @return
	 */
	@ResponseBody
	@GetMapping("/acc/doc")
	public List<DocVO> goDocUpload(HttpSession session, @RequestParam("bizrNo") String bizrNo) {
		CorpVO corp = corpService.selectOneByBizrNo(bizrNo);
		
		List<DocVO> list = docService.selectAllDoc(corp);
		return list;
	}
	
	/**
	 * 파일 업로드 후 서버에 저장   
	 * @param mRequest
	 * @param session
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/acc/doc")
	public void fileUpload(MultipartHttpServletRequest mRequest, HttpSession session) throws Exception {
		
		// 접속중인 세무사 정보 뽑아오기 
		AccountantVO accVO = (AccountantVO)session.getAttribute("accVO");
		
//		CorpVO corp = (CorpVO)session.getAttribute("userVO");
//		String bizrNo = corp.getBizrNo();
		String bizrNo = mRequest.getParameter("bizrNo");
		
		String docType = mRequest.getParameter("docType");
		String issueDate = mRequest.getParameter("issueDate");
		
		// 실행되는 웹어플리케이션의 실제 경로 가져와 서류 종류에 따라 저장 경로 다르게 설정 
		String uploadDir = servletContext.getRealPath("/docs/");
		uploadDir = uploadDir + docType + "/";
		
		Iterator<String> iter = mRequest.getFileNames();
		
		String formFileName = iter.next();
		// 폼에서 파일을 선택하지 않아도 객체 생성됨
		MultipartFile mFile = mRequest.getFile(formFileName);
		
		// 원본 파일명
		String docOriName = mFile.getOriginalFilename();
		System.out.println("원본 파일명 : " + docOriName);
		
		if(docOriName != null && !docOriName.equals("")) {
		
			// 확장자 처리
			String ext = "";
			// 뒤쪽에 있는 . 의 위치 
			int index = docOriName.lastIndexOf(".");
			if (index != -1) {
				// 파일명에서 확장자명(.포함)을 추출
				ext = docOriName.substring(index);
			}
			
			// 파일 사이즈
			long docSize = mFile.getSize();
			System.out.println("파일 사이즈 : " + docSize);
			
			// 고유한 파일명 만들기	
				// 현재시간 가져오기 
			SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd_HH:mm:ss");
					
			Calendar time = Calendar.getInstance();
			       
			String currTime = format1.format(time.getTime());
			
			// 저장 파일 이름 형식 : 사업자등록번호_서류타입_등록시간 
			String docSaveName = bizrNo + "_" + docType + "_" + currTime + ext;
			
			System.out.println("저장 파일명 : " + docSaveName);
			
			// 임시저장된 파일을 원하는 경로에 저장
			mFile.transferTo(new File(uploadDir + docSaveName));
			
			// doc 객체에 저장  
			DocVO doc = new DocVO();
			doc.setBizrNo(bizrNo);
			doc.setDocOriName(docOriName);
			doc.setDocSaveName(docSaveName);
			doc.setDocSize(docSize);
			doc.setDocType(docType);
			doc.setissueDate(issueDate);
			doc.setUploader(accVO.getAccNo()); // 세무사 번호로 세팅 
			
			
			// 재무제표일경우 함수 호출
			if(docType.equals("재무제표")) {
				// 엑셀에서 읽은 데이터를 맵으로 가져오기 
//				Map<String, Object> excelData = readExcel(uploadDir, docSaveName);
				FinDataVO excelData = readExcel(uploadDir, docSaveName);
//				excelData.put("bizr_no", corp.getBizrNo());
//				excelData.put("issue_date", issueDate);
				excelData.setBizrNo(bizrNo);
				excelData.setIssueDate(issueDate);
//				
//				Iterator<String> iter2 = excelData.keySet().iterator();
//				
//				while(iter2.hasNext()) {
//					String key = iter2.next();
//					Object value = (Object)excelData.get(key);
//					System.out.println(key + " : " + value);
//				}
				System.out.println(excelData);
				
				// 재무제표일경우 doc 테이블의 목록과 재무제표 테이블 둘 다 업데이트 
				docService.insertFinDoc(doc, excelData);
			} else {
				docService.insertDoc(doc);
				
			}
		} 
		
	}
	
	/**
	 * 인증대기목록 불러오기 
	 * @return
	@ResponseBody
	@GetMapping("/acc/getAuthWaitingList")
	public List<AuthVO> getAuthWaitingList(HttpSession session) {
		AccountantVO acc = (AccountantVO)session.getAttribute("accVO");
		
		List<AuthVO> authList = authService.selectAllAuthWaiting(acc);
		return authList;
	}
	 */
	
	/**
	 * 엑셀파일 읽기 
	 * @return
	 */
	public FinDataVO readExcel(String uploadDir, String docSaveName) {
		
		String path = uploadDir + docSaveName;
		System.out.println("path : " + path);
		
		Map<String, Object> map = new HashMap<>(); // 데이터를 담을 Map
		FinDataVO fd = new FinDataVO();
		
        try {
            File file = new File(path);
            FileInputStream inputStream = new FileInputStream(file);
            XSSFWorkbook xworkbook = new XSSFWorkbook(inputStream);
            
            XSSFSheet curSheet; // 현재 sheet
            XSSFCell curCell; // 현재 cell
            XSSFRow curRow; // 현재 row
 
            int sheetNumber = xworkbook.getNumberOfSheets(); // 엑셀 Sheet 총 갯수
            System.out.println("sheetNumber : "+sheetNumber);  //Sheet 갯수 확인
            
            while (sheetNumber != 0) {
                sheetNumber--;
 
                curSheet = xworkbook.getSheetAt(sheetNumber);
               
                fd.setTurn(String.valueOf(curSheet.getRow(3).getCell(4)));
                
                fd.setCurrAst((long)curSheet.getRow(5).getCell(3).getNumericCellValue());
                fd.setCurrAst((long)curSheet.getRow(5).getCell(3).getNumericCellValue());
                fd.setNonCurrAst((long)curSheet.getRow(6).getCell(3).getNumericCellValue());
                fd.setTtlAst((long)curSheet.getRow(7).getCell(3).getNumericCellValue());
                fd.setCurrLiab((long)curSheet.getRow(8).getCell(3).getNumericCellValue());
                fd.setNonCurrLiab((long)curSheet.getRow(9).getCell(3).getNumericCellValue());
                fd.setTtlLiab((long)curSheet.getRow(10).getCell(3).getNumericCellValue());
                fd.setCapital((long)curSheet.getRow(11).getCell(3).getNumericCellValue());
                fd.setErndSplus((long)curSheet.getRow(12).getCell(3).getNumericCellValue());
                fd.setTtlCapital((long)curSheet.getRow(13).getCell(3).getNumericCellValue());
                fd.setSalesCf((long)curSheet.getRow(14).getCell(3).getNumericCellValue());
                fd.setFinCf((long)curSheet.getRow(15).getCell(3).getNumericCellValue());
                fd.setInvstCf((long)curSheet.getRow(16).getCell(3).getNumericCellValue());
                fd.setSales((long)curSheet.getRow(17).getCell(3).getNumericCellValue());
                fd.setBusiProfits((long)curSheet.getRow(18).getCell(3).getNumericCellValue());
                fd.setNetIncm((long)curSheet.getRow(19).getCell(3).getNumericCellValue());
                
            }
 
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
 
        return fd;
    }
	
}



