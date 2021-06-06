package beone.loanEval.controller;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.PumpStreamHandler;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.python.core.PyFunction;
import org.python.core.PyInteger;
import org.python.core.PyLong;
import org.python.core.PyObject;
import org.python.util.PythonInterpreter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import beone.corp.service.CorpService;
import beone.corp.vo.CorpVO;
import beone.doc.service.DocService;
import beone.doc.vo.DocVO;
import beone.interest.service.InterestService;
import beone.interest.vo.InterestVO;
import beone.loanApp.service.LoanAppService;
import beone.loanApp.vo.LoanAppVO;
import beone.loanEval.service.LoanEvalService;
import beone.loanEval.vo.LoanEvalVO;
import beone.loanHistory.service.LoanHistoryService;
import beone.loanHistory.vo.LoanHistoryVO;
import beone.loanProd.service.LoanProdService;
import beone.loanProd.vo.LoanProdVO;
import beone.rep.vo.RepVO;
import beone.rpyHistory.service.RpyHistoryService;
import beone.rpyHistory.vo.RpyHistoryVO;
import beone.sendSms.SendSmSTwilio;

@Controller
public class LoanEvalController {

	@Autowired
	private LoanAppService loanAppService;
	
	@Autowired
	private CorpService corpService;
	
	@Autowired
	private LoanHistoryService loanHistoryService;
	
	@Autowired
	private DocService docService;
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	private RpyHistoryService rpyHistoryService;
	
	@Autowired
	private LoanProdService loapProdService;
	
	@Autowired
	private LoanEvalService loanEvalService;
	
	@Autowired
	private InterestService interestService;
	
	/**
	 * 기업 코드 조회 및 다트 재무제표 보고서 번호 조회를 위한 ajax 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@CrossOrigin("*")
	@ResponseBody
	@PostMapping("/emp/loanEval")
	public String dartAPI(HttpServletRequest request) throws Exception {
		// 최종적으로 반환할 보고서 번호 
		String rcept_no = "";

		// 파라미터값 받아오기 
		String bizrNo = request.getParameter("bizrNo");
		int year = Integer.parseInt(request.getParameter("year"));
		
		// 
		year = year + 1;
		// 해당 기업의 기업코드 받아오기 
		String corpCode = corpService.selectCorpCode(bizrNo);
		System.out.println("corpCode : " + corpCode);
		System.out.println("bizrNo : " + bizrNo);
		System.out.println("year : " + year);
		
		
		String result = "";
		try {
			String urlStr = "https://opendart.fss.or.kr/api/list.json?" +
							"crtfc_key=" + "f494a3020128060351c817cabf5b1b4a851e0737" +
							"&corp_code=" + corpCode +
							"&bgn_de=" + year + "0101" +
							"&end_de=" + year + "0601" +
							"&pblntf_ty=" + "A";
			
			URL url = new URL(urlStr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
			
			String returnLine;
			while((returnLine = br.readLine()) != null) {
				result = result + returnLine + "\n";
			}
			System.out.println(result);
			urlconnection.disconnect();
			
			// JSON 파싱
			JSONParser jsonParse = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParse.parse(result);
			JSONArray listArray = (JSONArray) jsonObj.get("list");
			
			
			for(int i = 0; i < listArray.size(); i++) {
				JSONObject listObject = (JSONObject) listArray.get(i);
				rcept_no = (String)listObject.get("rcept_no");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return rcept_no;
	}
	
	/**
	 * 대출심사 페이지 로드 
	 * @param appNo1
	 * @return
	 */
	@GetMapping("/emp/loanEval/{appNo}")
	public ModelAndView evalMain(@PathVariable("appNo") String appNo1, HttpServletRequest request, HttpSession session) {
		int appNo = Integer.parseInt(appNo1);
		ModelAndView mav = new ModelAndView("emp/loanEval");
	
	// 1. 대출 신청 데이터 끌어오기
		LoanAppVO loanApp = loanAppService.selectOneByAppNo(appNo);
			// 사업자등록번호 저장
		String bizrNo = loanApp.getBizrNo();
	// 2. 신청시 서류 끌어오기
		List<DocVO> docList = docService.selectByAppNo(appNo);

	// 3. 기업 개황 & 대표자 데이터 불러오기
		CorpVO corp = corpService.selectOneByBizrNo(bizrNo);
		List<RepVO> repList = corpService.selectAllRep(corp);
		
	// 4. 기업 분석 데이터 & 신용 이력 불러오기
		List<Map<String, BigDecimal>> finList = corpService.selectAllFin(corp);
		// 디폴트 형이 BigDeciaml 이므로 Float형으로 변환한 리스트를 반환 
		List<Map<String, Float>> finList2 = new ArrayList<Map<String, Float>>();
				
		for(int i = 0; i < finList.size(); i++){
			Map<String, BigDecimal> map = finList.get(i);
			Map<String, Float> newMap = new HashMap<>();
			for(Map.Entry<String, BigDecimal> entry : map.entrySet()){
				String key = entry.getKey();
			    Float value = Float.valueOf(String.valueOf(entry.getValue()));
			    newMap.put(key, value);
			}
			finList2.add(i, newMap);
		}
				
		List<Map<String, String>> creditRnkList = corpService.selectAllCredit(corp);
				
		
	// 5. 기존 대출 내역 불러오기
		
		
		int blockNo2;
		int pageNo2;
		if(request.getParameter("blockNo2") == null || request.getParameter("pageNo2") == null) {
			blockNo2 = 1;
			pageNo2 = 1;
		} else {
			blockNo2 = Integer.parseInt(request.getParameter("blockNo2"));
			pageNo2 = Integer.parseInt(request.getParameter("pageNo2"));
		}
		
		
		// 임의 설정이 필요한 부분
		int boardCntPerPage2 = 5;
		int pageCntPerBlock2 = 5;
		
		// 블록의 시작 페이지와 끝 페이지 (등차수열 적용)
		int blockStartPageNo2 = 1 + pageCntPerBlock2 * (blockNo2 - 1);
		int blockEndPageNo2 = pageCntPerBlock2 * blockNo2;
		
		//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		int totalBoardCnt2 = loanHistoryService.selectCntPagingByBizrNo(bizrNo);
		
		//// 전체 페이지 수 구하는 코드
		int totalPageCnt2 = totalBoardCnt2 / boardCntPerPage2;
		if(totalBoardCnt2 % boardCntPerPage2 > 0) {
			totalPageCnt2++; // 나머지가 있으면 페이지가 다 돌고 남은 게시글이 있는 것이기에 전체 페이지 수에 +1 해줌
		}
		
		//// 만약 위 연산으로 계산한 해당 블록 끝 번호가 전체 페이지 번호 수 보다 크다면 블록 끝 번호는 전체 페이지 번호 수 (블록 끝 번호가 계속 전체 페이지 번호수보다 작다가 마지막에만 커지거나 같아짐)
		if (blockEndPageNo2 > totalPageCnt2) {
			blockEndPageNo2 = totalPageCnt2;
		}
		
		// 전체 블록 개수 구하기 (다음 버튼 기능을 구현해주기 위해)
		int totalBlockCnt2 = totalPageCnt2 / pageCntPerBlock2;
		if (totalPageCnt2 % pageCntPerBlock2 > 0) {
			totalBlockCnt2++;
		}
		
		// 해당 페이지에서 필요한만큼의 게시글 데이터 얻어오기 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", pageNo2);
		map.put("boardCntPerPage", boardCntPerPage2);
		map.put("bizrNo", bizrNo);
		
		List<LoanHistoryVO> loanHisList = loanHistoryService.selectAllPagingByBizrNo(map);
		
		mav.addObject("blockStartPageNo2", blockStartPageNo2);
		mav.addObject("blockEndPageNo2", blockEndPageNo2);
		mav.addObject("blockNo2", blockNo2);
		mav.addObject("totalBlockCnt2", totalBlockCnt2);
		mav.addObject("pageNo2", pageNo2);  
		mav.addObject("totalBoardCnt2", totalBoardCnt2);
	

		mav.addObject("loanApp", loanApp);	// 대출 신청 
		mav.addObject("docList", docList); // 신청 서류 
		mav.addObject("corp", corp); // 기업 개황 
		mav.addObject("repList", repList); // 대표자 
		mav.addObject("finList", finList2); // 재무정보 
		mav.addObject("creditRnkList", creditRnkList); // 신용정보 
		mav.addObject("loanHisList", loanHisList);// 대출내역 

	// 6. 이자납입내역을 위한 전체 대출 내역 불러오기
		List<LoanHistoryVO> loanHisListAll = loanHistoryService.selectAllLoanHistory(corp.getBizrNo());
		mav.addObject("loanHisListAll", loanHisListAll);
		return mav;
	}
	/**
	 * 대출내역 페이징 ajax
	 * @return
	 */
	@ResponseBody
	@PostMapping("/emp/loanEval/loanHis")
	public ModelAndView loanHisPagingAjax(HttpServletRequest request, HttpSession session) {
		
		ModelAndView mav = new ModelAndView("emp/loanHisTableInLoanEval");
		
		String bizrNo = request.getParameter("bizrNo");
		
		int blockNo2;
		int pageNo2;
		if(request.getParameter("blockNo2") == null || request.getParameter("pageNo2") == null) {
			blockNo2 = 1;
			pageNo2 = 1;
		} else {
			blockNo2 = Integer.parseInt(request.getParameter("blockNo2"));
			pageNo2 = Integer.parseInt(request.getParameter("pageNo2"));
		}
		System.out.println("blockNo2 : " + blockNo2);
		System.out.println("pageNo2 : " + pageNo2);
		
		// 임의 설정이 필요한 부분
		int boardCntPerPage2 = 5;
		int pageCntPerBlock2 = 5;
		
		// 블록의 시작 페이지와 끝 페이지 (등차수열 적용)
		int blockStartPageNo2 = 1 + pageCntPerBlock2 * (blockNo2 - 1);
		int blockEndPageNo2 = pageCntPerBlock2 * blockNo2;
		
		//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		int totalBoardCnt2 = loanHistoryService.selectCntPagingByBizrNo(bizrNo);
		
		//// 전체 페이지 수 구하는 코드
		int totalPageCnt2 = totalBoardCnt2 / boardCntPerPage2;
		if(totalBoardCnt2 % boardCntPerPage2 > 0) {
			totalPageCnt2++; // 나머지가 있으면 페이지가 다 돌고 남은 게시글이 있는 것이기에 전체 페이지 수에 +1 해줌
		}
		
		//// 만약 위 연산으로 계산한 해당 블록 끝 번호가 전체 페이지 번호 수 보다 크다면 블록 끝 번호는 전체 페이지 번호 수 (블록 끝 번호가 계속 전체 페이지 번호수보다 작다가 마지막에만 커지거나 같아짐)
		if (blockEndPageNo2 > totalPageCnt2) {
			blockEndPageNo2 = totalPageCnt2;
		}
		
		// 전체 블록 개수 구하기 (다음 버튼 기능을 구현해주기 위해)
		int totalBlockCnt2 = totalPageCnt2 / pageCntPerBlock2;
		if (totalPageCnt2 % pageCntPerBlock2 > 0) {
			totalBlockCnt2++;
		}
		
		// 해당 페이지에서 필요한만큼의 게시글 데이터 얻어오기 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", pageNo2);
		map.put("boardCntPerPage", boardCntPerPage2);
		map.put("bizrNo", bizrNo);
		
		List<LoanHistoryVO> loanHisList = loanHistoryService.selectAllPagingByBizrNo(map);
		
		mav.addObject("blockStartPageNo2", blockStartPageNo2);
		mav.addObject("blockEndPageNo2", blockEndPageNo2);
		mav.addObject("blockNo2", blockNo2);
		mav.addObject("totalBlockCnt2", totalBlockCnt2);
		mav.addObject("pageNo2", pageNo2);  
		mav.addObject("totalBoardCnt2", totalBoardCnt2);
	

		mav.addObject("loanHisList", loanHisList);// 대출내역 

		return mav;
	}
	
	
	/**
	 * 대출내역 페이징 '다음' 및 '이전' 
	 * @param request
	 * @param session
	 * @return
	 */
	@GetMapping("/emp/loanEval/loanHis")
	public ModelAndView loanHisPagingBeforeNext(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("emp/loanEval");
		
		String bizrNo = request.getParameter("bizrNo");
		
		// 3. 담당 대출 건수 불러오기 
		// 쉬운 부분부터..	
		int blockNo2;
		int pageNo2;
		if(request.getParameter("blockNo2") == null || request.getParameter("pageNo2") == null) {
			blockNo2 = 1;
			pageNo2 = 1;
		} else {
			blockNo2 = Integer.parseInt(request.getParameter("blockNo2"));
			pageNo2 = Integer.parseInt(request.getParameter("pageNo2"));
		}
						
		// 임의 설정이 필요한 부분
		int boardCntPerPage2 = 5;
		int pageCntPerBlock2 = 5;
				
		// 블록의 시작 페이지와 끝 페이지 (등차수열 적용)
		int blockStartPageNo2 = 1 + pageCntPerBlock2 * (blockNo2 - 1);
		int blockEndPageNo2 = pageCntPerBlock2 * blockNo2;
						
		//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		int totalBoardCnt2 = loanHistoryService.selectCntPagingByBizrNo(bizrNo);
						
		//// 전체 페이지 수 구하는 코드
		int totalPageCnt2 = totalBoardCnt2 / boardCntPerPage2;
		if(totalBoardCnt2 % boardCntPerPage2 > 0) {
			totalPageCnt2++; // 나머지가 있으면 페이지가 다 돌고 남은 게시글이 있는 것이기에 전체 페이지 수에 +1 해줌
		}
						
		//// 만약 위 연산으로 계산한 해당 블록 끝 번호가 전체 페이지 번호 수 보다 크다면 블록 끝 번호는 전체 페이지 번호 수 (블록 끝 번호가 계속 전체 페이지 번호수보다 작다가 마지막에만 커지거나 같아짐)
		if (blockEndPageNo2 > totalPageCnt2) {
			blockEndPageNo2 = totalPageCnt2;
		}
						
		// 전체 블록 개수 구하기 (다음 버튼 기능을 구현해주기 위해)
		int totalBlockCnt2 = totalPageCnt2 / pageCntPerBlock2;
		if (totalPageCnt2 % pageCntPerBlock2 > 0) {
			totalBlockCnt2++;
		}
						
		// 해당 페이지에서 필요한만큼의 게시글 데이터 얻어오기 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", pageNo2);
		map.put("boardCntPerPage", boardCntPerPage2);
		map.put("bizrNo", bizrNo);
				
		List<LoanHistoryVO> loanHisList = loanHistoryService.selectAllPagingByBizrNo(map);
		mav.addObject("loanHisList", loanHisList);
						
		mav.addObject("blockStartPageNo2", blockStartPageNo2);
		mav.addObject("blockEndPageNo2", blockEndPageNo2);
		mav.addObject("blockNo2", blockNo2);
		mav.addObject("totalBlockCnt2", totalBlockCnt2);
		mav.addObject("pageNo2", pageNo2);  
		mav.addObject("totalBoardCnt2", totalBoardCnt2);

		return mav;
	}
	
	
	
	/**
	 * 대출 내역에 해당하는 상환 내역 불러오는 ajax 
	 * @param loanNo
	 * @param request
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping("/emp/rpy/{loanNo}")
	public ModelAndView selectAllRpyHistory(@PathVariable("loanNo") String loanNo, HttpServletRequest request, Model model) {
		List<RpyHistoryVO> rpyHisList = rpyHistoryService.selectAllRpyHis(loanNo);
		
		ModelAndView mav = new ModelAndView("emp/rpyHistory");
		mav.addObject("rpyHisList", rpyHisList);
		return mav;
	}
	
	/**
	 * 대출 심사 페이지에 신청 서류 다운로드 
	 * @param docNo
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/emp/doc/{docNo}")
	public void downloadDoc(@PathVariable("docNo") int docNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 다운하려는 파일 정보 가져오기 
		DocVO doc = docService.selectOneDoc(docNo);
		//===전달 받은 정보를 가지고 파일객체 생성(S)===//
        
        String f = doc.getDocSaveName(); //저장된 파일이름
//        String of = doc.getDocOriName(); //원래 파일이름
        f = new String(f.getBytes("ISO8859_1"),"UTF-8"); 
        //서버설정(server.xml)에 따로 인코딩을 지정하지 않았기 때문에 get방식으로 받은 값에 대해 인코딩 변환
        
        
        //웹사이트 루트디렉토리의 실제 디스크상의 경로 알아내기.
        String path = servletContext.getRealPath("/loanDocs/") + "/" + doc.getDocType() + "/" + doc.getDocSaveName();
        //String path = request.getSession().getServletContext().getRealPath("upload");
        //String path = WebUtils.getRealPath(request.getServletContext(), "upload");        
        //String path = "D:\\upload\\";        
        
        
        File downloadFile = new File(path);
        
        //===전달 받은 정보를 가지고 파일객체 생성(E)===//
        
        
        //파일 다운로드를 위해 컨테츠 타입을 application/download 설정
        response.setContentType("application/download; charset=utf-8");
                
        //파일 사이즈 지정
        response.setContentLength((int)downloadFile.length());
        
        //다운로드 창을 띄우기 위한 헤더 조작
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename="
                                        + new String(f.getBytes(), "ISO8859_1"));
        
        response.setHeader("Content-Transfer-Encoding","binary");
        /*
         * Content-disposition 속성
         * 1) "Content-disposition: attachment" 브라우저 인식 파일확장자를 포함하여 모든 확장자의 파일들에 대해
         *                          , 다운로드시 무조건 "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성이다
         * 2) "Content-disposition: inline" 브라우저 인식 파일확장자를 가진 파일들에 대해서는 
         *                                  웹브라우저 상에서 바로 파일을 열고, 그외의 파일들에 대해서는 
         *                                  "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성이다.
         */
        
        FileInputStream fin = new FileInputStream(downloadFile);
        ServletOutputStream sout = response.getOutputStream();

        byte[] buf = new byte[1024];
        int size = -1;

        while ((size = fin.read(buf, 0, buf.length)) != -1) {
            sout.write(buf, 0, size);
        }
        fin.close();
        sout.close();
	}
	
	/**
	 * 대출 선택시 이자납입내역 및 대출 정보를 보여주는 ajax 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@PostMapping("/emp/loanEval/interest")
	public ModelAndView interestAjax(@RequestParam("loanNo") String loanNo, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("emp/interestTable");
		
		// 대출번호에 해당하는 대출정보 가져오기 
		LoanHistoryVO loanHis = loanHistoryService.selectByLoanNo(request.getParameter("loanNo"));
		
		// 페이징 
		int blockNo;
		int pageNo;
		if(request.getParameter("blockNo") == null || request.getParameter("pageNo") == null) {
			blockNo = 1;
			pageNo = 1;
		} else {
			blockNo = Integer.parseInt(request.getParameter("blockNo"));
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		}
		
				
		// 임의 설정이 필요한 부분
		int boardCntPerPage = 10;
		int pageCntPerBlock = 5;
				
		// 블록의 시작 페이지와 끝 페이지 (등차수열 적용)
		int blockStartPageNo = 1 + pageCntPerBlock * (blockNo - 1);
		int blockEndPageNo = pageCntPerBlock * blockNo;
				
		//// 해당 대출의 이자납부내역 건수 가져오기 
		int totalBoardCnt = interestService.selectCnt(loanNo);
				
		//// 전체 페이지 수 구하는 코드
		int totalPageCnt = totalBoardCnt / boardCntPerPage;
		if(totalBoardCnt % boardCntPerPage > 0) {
			totalPageCnt++; // 나머지가 있으면 페이지가 다 돌고 남은 게시글이 있는 것이기에 전체 페이지 수에 +1 해줌
		}
				
		//// 만약 위 연산으로 계산한 해당 블록 끝 번호가 전체 페이지 번호 수 보다 크다면 블록 끝 번호는 전체 페이지 번호 수 (블록 끝 번호가 계속 전체 페이지 번호수보다 작다가 마지막에만 커지거나 같아짐)
		if (blockEndPageNo > totalPageCnt) {
			blockEndPageNo = totalPageCnt;
		}
				
		// 전체 블록 개수 구하기 (다음 버튼 기능을 구현해주기 위해)
		int totalBlockCnt = totalPageCnt / pageCntPerBlock;
		if (totalPageCnt % pageCntPerBlock > 0) {
			totalBlockCnt++;
		}
			
		// 3. 해당 페이지에서 필요한만큼의 이자납부내역 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", pageNo);
		map.put("boardCntPerPage", boardCntPerPage);
		map.put("loanNo", loanNo);
		
		List<InterestVO> intrList = interestService.selectPerPage(map);
		
		request.setAttribute("blockStartPageNo", blockStartPageNo);
		request.setAttribute("blockEndPageNo", blockEndPageNo);
		request.setAttribute("blockNo", blockNo);
		request.setAttribute("totalBlockCnt", totalBlockCnt);
		request.setAttribute("pageNo", pageNo);  
		request.setAttribute("totalBoardCnt", totalBoardCnt);
		
		mav.addObject("loanHis", loanHis);
		mav.addObject("intrList", intrList);
		
		return mav;
	}
	/**
	 * 대출 간편 승인 
	 * @param appNo
	 * @return
	@GetMapping("/emp/loanEvalApprove/{appNo}")
	public String loanEvalApprove(@PathVariable("appNo") int appNo) {
		
		// 신청번호로 신청정보 가져오기 
		LoanAppVO loanApp = loanAppService.selectOneByAppNo(appNo);
		// 신청정보의 상품번호로 상품정보 가져오기 
		LoanProdVO loanProd = loapProdService.selectOne(loanApp.getProdNo());
		// 간편 대출 승인의 경우 상품의 최저금리로 신청 금리 세팅 
		loanApp.setAppInterest(loanProd.getInterest());
		// 서비스단에서 모든 로직 구현 
		loanEvalService.loanEvalApprove(loanApp);
		
		return "redirect:/emp";
	}
	 */
	
	/**
	 * 대출 간편 기각 (STEP1)
	 * @param appNo
	 * @return
	 */
	@GetMapping("/emp/loanEvalRefuse/{appNo}/{reason}")
	public String loanEvalRefuse(@PathVariable("appNo") int appNo, @PathVariable("reason") String reason) {
		
		// 신청번호로 신청정보 가져오기 
		LoanAppVO loanApp = loanAppService.selectOneByAppNo(appNo);
		System.out.println(loanApp);
		
		// 사업자번호로 회사 가져오기
		CorpVO corp = corpService.selectOneByBizrNo(loanApp.getBizrNo());
		
		// 신청번호의 상태 '기각'으로 변경 & 심사테이블 업데이트 
		LoanEvalVO loanEval = new LoanEvalVO();
		loanEval.setAppNo(appNo);
		loanEval.setEvalResult("N");
		loanEval.setEvalComment(reason);
		System.out.println(loanEval);
		
		loanEvalService.loanEvalRefuse(loanApp, loanEval);
		
		// 대출 기각 메세지 보내기 
		String msg = corp.getName() + "님, 대출이 거절되었습니다. 자세한 사항은 BEONE 홈페이지를 참고해주세요.";
		SendSmSTwilio.sendDirectSMS(msg);
		
		return "redirect:/emp";
	}
	/**
	 * 2차심사 대출 승인 
	 * @param appNo
	 * @param evalResult
	 * @param interest
	 * @param pcplAmt
	 * @return
	@ResponseBody
	@PostMapping("/emp/scndEvalApprove")
	public String scndEvalApprove(@RequestParam("appNo") int appNo, @RequestParam("evalResult") String evalResult, 
									@RequestParam("interest") float interest, @RequestParam("pcplAmt") long pcplAmt) {
		// 신청번호로 신청정보 가져오기 
		LoanAppVO loanApp = loanAppService.selectOneByAppNo(appNo);
		// 2차대출의 경우 날라온 금리와 한도 파라미터로 세팅
		loanApp.setAppInterest(interest);
		loanApp.setAppAmount(pcplAmt);
		
		// 심사테이블 VO 설정
		LoanEvalVO loanEval = new LoanEvalVO();
		loanEval.setAppNo(appNo);
		loanEval.setEvalResult(evalResult);
		
		// 서비스단에서 모든 로직 구현 
		loanEvalService.scndLoanEvalApprove(loanApp, loanEval);
		
		return "approved";
	}
	 */
	/**
	 * 2차심사 기각 
	 * @param loanEval
	 * @return
	@ResponseBody
	@PostMapping("/emp/scndEvalRefuse")
	public String scndEvalRefuse(LoanEvalVO loanEval) {
		
		// 신청번호로 신청정보 가져오기 
		LoanAppVO loanApp = loanAppService.selectOneByAppNo(loanEval.getAppNo());
		
		// 신청번호의 상태 '기각'으로 변경
		loanEvalService.scndLoanEvalRefuse(loanApp, loanEval);
		
		return "refused";
	}
	 */
	/**
	 * 대출금리 계산 파이썬 스크립트 실행 
	 * @param param_busi_profits
	 * @param param_net_incm
	 * @param param_ttl_liab
	 * @param param_credit_rnk
	 */
	@ResponseBody
	@GetMapping("/emp/ML")
	public float runPythonML(@RequestParam("param_busi_profits") long param_busi_profits, @RequestParam("param_net_incm") long param_net_incm, @RequestParam("param_ttl_liab") long param_ttl_liab, @RequestParam("param_credit_rnk") int param_credit_rnk) {

		
		String s = null;
		String interestStr = null;
		
		// 명령어 및 매개변수 정해주기 
        String[] command = new String[6];
        command[0] = "python";
        command[1] = "/Users/linakim/spring-workspace/Beone/src/main/webapp/WEB-INF/jsp/emp/ML_func(12).py";
        command[2] = String.valueOf(param_busi_profits);
        command[3] = String.valueOf(param_net_incm);
        command[4] = String.valueOf(param_ttl_liab);
        command[5] = String.valueOf(param_credit_rnk);

        try {
        	
            Runtime rt = Runtime.getRuntime();
        	Process process = rt.exec(command);
        	
        	BufferedReader stdInput = new BufferedReader(new InputStreamReader(process.getInputStream()));
        	BufferedReader stdError = new BufferedReader(new InputStreamReader(process.getErrorStream()));
        	
        	// interest를 print한것 가져오기 
        	System.out.println("python should be run.");
        	while((s = stdInput.readLine()) != null) {
        		interestStr = s;
        	}
       	
        	// 파이썬 에러메세지 출력 
        	System.out.println("Here is the standard error of the command.");
        	while((s = stdError.readLine()) != null) {
        		System.out.println(s);
        	}
        	
            
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		float interestFlt = Float.parseFloat(interestStr);
		System.out.println("interest : " + interestFlt);
		
		return interestFlt;
	}
	 
	/**
	 * 최종 대출 승인 
	 * @param appNo
	 * @param evalResult
	 * @param interest
	 * @param pcplAmt
	 * @return
	 */
	@PostMapping("/emp/loanEvalSubmit")
	public String loanEvalSubmit(@RequestParam("appNo") int appNo, @RequestParam("evalResult") String evalResult, 
			@RequestParam("interest") float interest, @RequestParam("limit") long pcplAmt) {
		
		// 신청번호로 신청정보 가져오기 
		LoanAppVO loanApp = loanAppService.selectOneByAppNo(appNo);
		// 2차대출의 경우 날라온 금리와 한도 파라미터로 세팅
		loanApp.setAppInterest(interest);
		loanApp.setAppAmount(pcplAmt);
		
		// 사업자번호로 회사 가져오기
		CorpVO corp = corpService.selectOneByBizrNo(loanApp.getBizrNo());
				
				
		// 심사테이블 VO 설정
		LoanEvalVO loanEval = new LoanEvalVO();
		loanEval.setAppNo(appNo);
		loanEval.setEvalResult(evalResult);
		
		System.out.println(loanApp);
		System.out.println(loanEval);
		
		// 서비스단에서 모든 로직 구현 
		loanEvalService.scndLoanEvalApprove(loanApp, loanEval);
		
		// 대출 승인 문자보내기
		String msg = corp.getName() + "님, 대출이 승인되었습니다. 자세한 사항은 BEONE 홈페이지를 참고해주세요.";
		SendSmSTwilio.sendDirectSMS(msg);
		return "redirect:/emp";
	}
}
