package beone.emp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import beone.emp.service.EmpService;
import beone.emp.vo.EmpVO;
import beone.loanApp.service.LoanAppService;
import beone.loanApp.vo.LoanAppVO;
import beone.loanHistory.service.LoanHistoryService;
import beone.loanHistory.vo.LoanHistoryVO;

@SessionAttributes("empVO")
@Controller
public class EmpController {

	@Autowired
	private EmpService empService;
	
	@Autowired
	private LoanAppService loanAppService;
	
	@Autowired
	private LoanHistoryService loanHistoyService;
	
	@GetMapping("/emp/login")
	public String loginForm() {
		
		return "emp/empLogin";
	}
	/**
	 * 메인 관리자 화면 보이기 
	 * @param session
	 * @param request
	 * @return
	 */
	@GetMapping("/emp")
	public ModelAndView getMainPage(HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("emp/empIndex");
		EmpVO empVO = (EmpVO)session.getAttribute("empVO");
		
	// 1. 신규 대출 신청 건수 불러오기
		// 쉬운 부분부터..	
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
		int boardCntPerPage = 5;
		int pageCntPerBlock = 5;
		
		// 블록의 시작 페이지와 끝 페이지 (등차수열 적용)
		int blockStartPageNo = 1 + pageCntPerBlock * (blockNo - 1);
		int blockEndPageNo = pageCntPerBlock * blockNo;
		
		//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		int totalBoardCnt = loanAppService.selectCnt(empVO);
		
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
		
		// 해당 페이지에서 필요한만큼의 게시글 데이터 얻어오기 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", pageNo);
		map.put("boardCntPerPage", boardCntPerPage);
		map.put("empno", empVO.getEmpno());
		
		List<LoanAppVO> loanAppList = loanAppService.selectPerPage(map);
		mav.addObject("loanAppList", loanAppList);
		
		mav.addObject("blockStartPageNo", blockStartPageNo);
		mav.addObject("blockEndPageNo", blockEndPageNo);
		mav.addObject("blockNo", blockNo);
		mav.addObject("totalBlockCnt", totalBlockCnt);
		mav.addObject("pageNo", pageNo);  
		mav.addObject("totalBoardCnt", totalBoardCnt);

		
		// 2. 심사 마감률 불러오기 
		
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
		int totalBoardCnt2 = loanHistoyService.selectCnt(empVO);
		
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
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("pageNo", pageNo2);
		map2.put("boardCntPerPage", boardCntPerPage2);
		map2.put("empno", empVO.getEmpno());
		
		List<LoanHistoryVO> loanHisList = loanHistoyService.selectAllPerPage(map2);
		mav.addObject("loanHisList", loanHisList);
		
		mav.addObject("blockStartPageNo2", blockStartPageNo2);
		mav.addObject("blockEndPageNo2", blockEndPageNo2);
		mav.addObject("blockNo2", blockNo2);
		mav.addObject("totalBlockCnt2", totalBlockCnt2);
		mav.addObject("pageNo2", pageNo2);  
		mav.addObject("totalBoardCnt2", totalBoardCnt2);
		
		
	// 그래프를 위한 월별 대출건수 계산하기
		// 행원이 담당하고있는 모든 대출 가져오기 
		List<LoanHistoryVO> loanHisListAll = loanHistoyService.selectAllByEmpno(empVO);
		System.out.println(loanHisListAll);
		Map<String, Integer> loanHisByMonMap = new HashMap<>();
		
		// 동적으로 변수 생성
		for(int i = 2; i < 10; i++) {
			loanHisByMonMap.put("mon" + i,  0);
		}
		// 모든 대출내역 돌며 해당 월인것 맵에 저장 
		for(int i = 2; i < 10; i++) {
			int cnt = 0;
			for(LoanHistoryVO loanHis : loanHisListAll) {
				if(loanHis.getStartDate().contains("-0" + i + "-")) {
					cnt++;
				}
			}
			loanHisByMonMap.put("mon" + i, cnt);
		}
		mav.addObject("loanHisByMonMap", loanHisByMonMap);
		
		
	// 4. 관심 대출 목록 가져오기 
		List<LoanHistoryVO> focusLoanHisList = loanHistoyService.selectFocusLoan(empVO.getEmpno());
		mav.addObject("focusLoanHisList", focusLoanHisList);
		
		
	// 5. 해당 지점 대출왕 목록 가져오기
		List<EmpVO> empList = empService.loanAppCntByEmp(empVO);
		mav.addObject("empList", empList);
		
		return mav;
		
		
		
	}
	
	/*
	 * loan app (대출신청) 페이지 번호 선택시 날아오는 ajax. 
	 * 클릭한 페이지에 해당하는 loan_app_list를 공유객체에 저장 후 별도의 jsp 페이지로 포워드 
	 */
	@ResponseBody
	@PostMapping("/emp/loanApp")
	public ModelAndView pagingAjax(HttpSession session, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("emp/loanAppTable");
		
		EmpVO empVO = (EmpVO)session.getAttribute("empVO");
		
		// 1. 신규 대출 신청 건수 불러오기
		// 쉬운 부분부터..	
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
		int boardCntPerPage = 5;
		int pageCntPerBlock = 5;
		
		// 블록의 시작 페이지와 끝 페이지 (등차수열 적용)
		int blockStartPageNo = 1 + pageCntPerBlock * (blockNo - 1);
		int blockEndPageNo = pageCntPerBlock * blockNo;
		
		//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		int totalBoardCnt = loanAppService.selectCnt(empVO);
		
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
		
		// 해당 페이지에서 필요한만큼의 게시글 데이터 얻어오기 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", pageNo);
		map.put("boardCntPerPage", boardCntPerPage);
		map.put("empno", empVO.getEmpno());
		
		List<LoanAppVO> loanAppList = loanAppService.selectPerPage(map);
		mav.addObject("loanAppList", loanAppList);
		
		mav.addObject("blockStartPageNo", blockStartPageNo);
		mav.addObject("blockEndPageNo", blockEndPageNo);
		mav.addObject("blockNo", blockNo);
		mav.addObject("totalBlockCnt", totalBlockCnt);
		mav.addObject("pageNo", pageNo);  
		mav.addObject("totalBoardCnt", totalBoardCnt);
		
		
		return mav;
	}
	/**
	 * 대출신청 '다음' 및 '이전'
	 * @param request
	 * @param session
	 * @return
	 */
	@GetMapping("/emp/loanApp")
	public ModelAndView loanAppPagingBeforeNext(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("emp/empIndex");
		
		EmpVO empVO = (EmpVO)session.getAttribute("empVO");
		
		// 1. 신규 대출 신청 건수 불러오기
		// 쉬운 부분부터..	
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
		int boardCntPerPage = 5;
		int pageCntPerBlock = 5;
		
		// 블록의 시작 페이지와 끝 페이지 (등차수열 적용)
		int blockStartPageNo = 1 + pageCntPerBlock * (blockNo - 1);
		int blockEndPageNo = pageCntPerBlock * blockNo;
		
		//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		int totalBoardCnt = loanAppService.selectCnt(empVO);
		
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
		
		// 해당 페이지에서 필요한만큼의 게시글 데이터 얻어오기 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", pageNo);
		map.put("boardCntPerPage", boardCntPerPage);
		map.put("empno", empVO.getEmpno());
		
		List<LoanAppVO> loanAppList = loanAppService.selectPerPage(map);
		mav.addObject("loanAppList", loanAppList);
		
		mav.addObject("blockStartPageNo", blockStartPageNo);
		mav.addObject("blockEndPageNo", blockEndPageNo);
		mav.addObject("blockNo", blockNo);
		mav.addObject("totalBlockCnt", totalBlockCnt);
		mav.addObject("pageNo", pageNo);  
		mav.addObject("totalBoardCnt", totalBoardCnt);
		

	// 신청목록은 blockNo = 1, pageNo = 1 디폴트로 공유영역에 올리기 	
		int boardCntPerPage2 = 5;
		int pageCntPerBlock2 = 5;
		int blockStartPageNo2 = 1;
		int blockEndPageNo2 = 5;
		int blockNo2 = 1;
		int pageNo2 = 1;
		
		int totalBoardCnt2 = loanHistoyService.selectCnt(empVO);
		
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
		Map<String, Object> loanHismap = new HashMap<String, Object>();
		loanHismap.put("pageNo", pageNo2);
		loanHismap.put("boardCntPerPage", boardCntPerPage2);
		loanHismap.put("empno", empVO.getEmpno());
				
		List<LoanHistoryVO> loanHisList = loanHistoyService.selectAllPerPage(loanHismap);
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
	 * 대출내역 페이징 ajax
	 * @param session
	 * @param request
	 * @return
	 */
	@ResponseBody
	@PostMapping("/emp/loanHis")
	public ModelAndView loanHisPaginAjax(HttpSession session, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("emp/loanHisTable");
		
		EmpVO empVO = (EmpVO)session.getAttribute("empVO");
		// 3. 담당 대출 건수 불러오기 
		// 쉬운 부분부터..	
		int blockNo;
		int pageNo;
		if(request.getParameter("blockNo2") == null || request.getParameter("pageNo2") == null) {
			blockNo = 1;
			pageNo = 1;
		} else {
			blockNo = Integer.parseInt(request.getParameter("blockNo2"));
			pageNo = Integer.parseInt(request.getParameter("pageNo2"));
		}
						
		// 임의 설정이 필요한 부분
		int boardCntPerPage = 5;
		int pageCntPerBlock = 5;
				
		// 블록의 시작 페이지와 끝 페이지 (등차수열 적용)
		int blockStartPageNo = 1 + pageCntPerBlock * (blockNo - 1);
		int blockEndPageNo = pageCntPerBlock * blockNo;
						
		//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		int totalBoardCnt = loanHistoyService.selectCnt(empVO);
						
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
						
		// 해당 페이지에서 필요한만큼의 게시글 데이터 얻어오기 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", pageNo);
		map.put("boardCntPerPage", boardCntPerPage);
		map.put("empno", empVO.getEmpno());
				
		List<LoanHistoryVO> loanHisList = loanHistoyService.selectAllPerPage(map);
		mav.addObject("loanHisList", loanHisList);
		mav.addObject("blockStartPageNo2", blockStartPageNo);
		mav.addObject("blockEndPageNo2", blockEndPageNo);
		mav.addObject("blockNo2", blockNo);
		mav.addObject("totalBlockCnt2", totalBlockCnt);
		mav.addObject("pageNo2", pageNo);  
		mav.addObject("totalBoardCnt2", totalBoardCnt);
					
		return mav;
				
	}
	/**
	 * 대출내역 페이징 '다음' 및 '이전' 
	 * @param request
	 * @param session
	 * @return
	 */
	@GetMapping("/emp/loanHis")
	public ModelAndView loanHisPagingBeforeNext(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView("emp/empIndex");
		
		EmpVO empVO = (EmpVO)session.getAttribute("empVO");
		
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
		int totalBoardCnt2 = loanHistoyService.selectCnt(empVO);
						
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
		map.put("empno", empVO.getEmpno());
				
		List<LoanHistoryVO> loanHisList = loanHistoyService.selectAllPerPage(map);
		mav.addObject("loanHisList", loanHisList);
						
		mav.addObject("blockStartPageNo2", blockStartPageNo2);
		mav.addObject("blockEndPageNo2", blockEndPageNo2);
		mav.addObject("blockNo2", blockNo2);
		mav.addObject("totalBlockCnt2", totalBlockCnt2);
		mav.addObject("pageNo2", pageNo2);  
		mav.addObject("totalBoardCnt2", totalBoardCnt2);

	// 신청목록은 blockNo = 1, pageNo = 1 디폴트로 공유영역에 올리기 
		
		int boardCntPerPage = 5;
		int pageCntPerBlock = 5;
		int blockStartPageNo = 1;
		int blockEndPageNo = 5;
		int blockNo = 1;
		int pageNo = 1;
		
		int totalBoardCnt = loanAppService.selectCnt(empVO);
		
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
		
		// 해당 페이지에서 필요한만큼의 게시글 데이터 얻어오기 
		Map<String, Object> loanAppMap = new HashMap<String, Object>();
		loanAppMap.put("pageNo", pageNo);
		loanAppMap.put("boardCntPerPage", boardCntPerPage);
		loanAppMap.put("empno", empVO.getEmpno());
		
		List<LoanAppVO> loanAppList = loanAppService.selectPerPage(loanAppMap);
		mav.addObject("loanAppList", loanAppList);
		
		mav.addObject("blockStartPageNo", blockStartPageNo);
		mav.addObject("blockEndPageNo", blockEndPageNo);
		mav.addObject("blockNo", blockNo);
		mav.addObject("totalBlockCnt", totalBlockCnt);
		mav.addObject("pageNo", pageNo);  
		mav.addObject("totalBoardCnt", totalBoardCnt);
		
			
		return mav;
	}
	/**
	 * 직원 로그인 
	 * @param emp
	 * @param session
	 * @param result
	 * @return
	 */
	@PostMapping("/emp/login")
	public ModelAndView login(EmpVO emp, HttpSession session, BindingResult result) {
		
		EmpVO empVO = empService.login(emp);
		ModelAndView mav = new ModelAndView();
		
		
		// 로그인 실패 
		if(empVO == null) {
			mav.setViewName("emp/empLogin");
			mav.addObject("loginResult", "* 없는 아이디거나 비밀번호가 맞지 않습니다.");
		} 
		else {
			// 어차피 관리자는 모든페이지가 관리자 로그인을 해야 들어갈 수 있으니까 
			// 로그인 성공 
//			if(session.getAttribute("dest") != null) {
//				mav.setViewName("redirect:/" + session.getAttribute("dest"));				
//				session.removeAttribute("dest");
//			} else {
				// 메인화면으로 리다이렉트 
				mav.setViewName("redirect:/emp");
//			}
			mav.addObject("empVO", empVO);			
		}
		
		return mav;
	}
	/**
	 * 직원 로그아웃 
	 * @param status
	 * @return
	 */
	@RequestMapping("/emp/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}
	
	/**
	 * 대출 대시보드로 이동 
	 * @return
	 */
	@GetMapping("/emp/loanDashboard")
	public String loanDashboard() {
		return "emp/loanDashboard";
	}
}
