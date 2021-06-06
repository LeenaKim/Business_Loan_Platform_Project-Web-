package beone.acnt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import beone.acnt.service.AcntService;
import beone.acnt.vo.AcntVO;
import beone.corp.vo.CorpVO;
import beone.loanProd.vo.LoanProdVO;
import beone.transaction.service.TransactionService;
import beone.transaction.vo.TransactionVO;

@Controller
public class AcntController {

	@Autowired
	private AcntService acntService;
	
	@Autowired
	private TransactionService transactionService;
	
	@ResponseBody
	@RequestMapping("/corp/chkBalance")
	public long selectOneAcnt(@RequestParam("no") String no) {
		AcntVO acnt = acntService.selectOne(no);
		return acnt.getBalance();
	}
	/**
	 * 대출 계좌 조회
	 * @param session
	 * @return
	 */
	@RequestMapping("/corp/viewAcnt")
	public ModelAndView viewAllAcnt(HttpSession session) {
		
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		
		ModelAndView mav = new ModelAndView("corp/viewAcnt");
		List<AcntVO> acntList = acntService.selectAll(corp);

		mav.addObject("acntList", acntList);
		
		return mav;
	}
	/**
	 * 계좌 상세내역 페이지 (이체내역)
	 * @param no
	 * @return
	 */
	@GetMapping("/corp/acntDetail/{no}")
	public ModelAndView viewAcntDetail(@PathVariable("no") String no, HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("corp/acntDetail");
		// 전체 계좌 리스트 가져오기
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		List<AcntVO> acntList = acntService.selectAll(corp);
		
		// 계좌 상세내역 가져오기 
		AcntVO acnt = acntService.selectOne(no);
		
		
		////////////////// 페이징 //////////////////
		
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
				
		//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		int totalBoardCnt = transactionService.selectCntLastThrMons(acnt.getNo());
				
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
		map.put("no", acnt.getNo());
		
		List<TransactionVO> transList = transactionService.viewPerPage(map);
		
		request.setAttribute("blockStartPageNo", blockStartPageNo);
		request.setAttribute("blockEndPageNo", blockEndPageNo);
		request.setAttribute("blockNo", blockNo);
		request.setAttribute("totalBlockCnt", totalBlockCnt);
		request.setAttribute("pageNo", pageNo);  
		request.setAttribute("totalBoardCnt", totalBoardCnt);
		
		mav.addObject("acntList", acntList);
		mav.addObject("acnt", acnt);
		mav.addObject("transList", transList);
		
		return mav;
	}
	/**
	 * 조회 기간 설정 
	 * @param no
	 * @param term
	 * @param session
	 * @param request
	 * @return
	 */
	@GetMapping("/corp/acntDetailTerm/{no}/{term}")
	public ModelAndView viewAcntDetail(@PathVariable("no") String no, @PathVariable("term") int term, HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("corp/acntDetail");
		
		// 전체 계좌 리스트 가져오기
				CorpVO corp = (CorpVO)session.getAttribute("userVO");
				List<AcntVO> acntList = acntService.selectAll(corp);
				
				// 계좌 상세내역 가져오기 
				AcntVO acnt = acntService.selectOne(no);
				
				
				////////////////// 페이징 //////////////////
				
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
						
				//// term 기간동안의 전체 거래내역 건수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
				Map<String, Object> termMap = new HashMap<String, Object>();
				termMap.put("no", no); // 계좌번호 
				termMap.put("term", term); // 기간 일수 
				
				int totalBoardCnt = transactionService.selectCntWithTerms(termMap);
						
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
				termMap.put("pageNo", pageNo);
				termMap.put("boardCntPerPage", boardCntPerPage);
				
				List<TransactionVO> transList = transactionService.viewPerPageWithTerm(termMap);
				
				request.setAttribute("blockStartPageNo", blockStartPageNo);
				request.setAttribute("blockEndPageNo", blockEndPageNo);
				request.setAttribute("blockNo", blockNo);
				request.setAttribute("totalBlockCnt", totalBlockCnt);
				request.setAttribute("pageNo", pageNo);  
				request.setAttribute("totalBoardCnt", totalBoardCnt);
				
				mav.addObject("acntList", acntList);
				mav.addObject("acnt", acnt);
				mav.addObject("transList", transList);
				mav.addObject("term", term);
				
				return mav;
	}
	/**
	 * 조건설정한 거래내역 조회 
	 * @param no
	 * @param start
	 * @param end
	 * @param session
	 * @param request
	 * @return
	 */
	@GetMapping("/corp/acntDetailCustomTerm/{no}/{start}/{end}")
	public ModelAndView viewAcntDetail(@PathVariable("no") String no, @PathVariable("start") String start, @PathVariable("end") String end, HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("corp/acntDetail");
		
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		// 전체 계좌 리스트 가져오기
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		List<AcntVO> acntList = acntService.selectAll(corp);
		
		// 계좌 상세내역 가져오기 
		AcntVO acnt = acntService.selectOne(no);
		
		
		////////////////// 페이징 //////////////////
		
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
		
		//// term 기간동안의 전체 거래내역 건수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		Map<String, Object> termMap = new HashMap<String, Object>();
		termMap.put("no", no); // 계좌번호 
		termMap.put("start", start); // 시작일  
		termMap.put("end", end); // 종료일 
		
		int totalBoardCnt = transactionService.selectCntCustomTerm(termMap);
		
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
		termMap.put("pageNo", pageNo);
		termMap.put("boardCntPerPage", boardCntPerPage);
		
		List<TransactionVO> transList = transactionService.selectPerPageCustomTerm(termMap);
		
		request.setAttribute("blockStartPageNo", blockStartPageNo);
		request.setAttribute("blockEndPageNo", blockEndPageNo);
		request.setAttribute("blockNo", blockNo);
		request.setAttribute("totalBlockCnt", totalBlockCnt);
		request.setAttribute("pageNo", pageNo);  
		request.setAttribute("totalBoardCnt", totalBoardCnt);
		
		mav.addObject("acntList", acntList);
		mav.addObject("acnt", acnt);
		mav.addObject("transList", transList);
		mav.addObject("start", start);
		mav.addObject("end", end);
		
		return mav;
	}
	
	
	/**
	 * 헤더, 인덱스 메뉴에서 계좌 거래내역 페이지 이동 
	 * @param session
	 * @return
	 */
	@RequestMapping("/corp/acntDetail")
	public ModelAndView viewAcntDetail(HttpSession session, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("corp/acntDetail");
		// 전체 계좌 리스트 가져오기
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		List<AcntVO> acntList = acntService.selectAll(corp);
		
		// 전체 계좌 조회가 아니라, 메뉴에서 거래내역 조회로 접속했을경우
		// 가장 최근 개설된 계좌의 상세내역 가져오기 
		AcntVO acnt = acntService.selectOneByRegDate(corp);
		
		
		
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
						
				//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
				int totalBoardCnt = transactionService.selectCntLastThrMons(acnt.getNo());
						
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
				map.put("no", acnt.getNo());
				
				List<TransactionVO> transList = transactionService.viewPerPage(map);
				
				request.setAttribute("blockStartPageNo", blockStartPageNo);
				request.setAttribute("blockEndPageNo", blockEndPageNo);
				request.setAttribute("blockNo", blockNo);
				request.setAttribute("totalBlockCnt", totalBlockCnt);
				request.setAttribute("pageNo", pageNo);  
				request.setAttribute("totalBoardCnt", totalBoardCnt);
				
		mav.addObject("acntList", acntList);
		mav.addObject("acnt", acnt);
		mav.addObject("transList", transList);
		
		return mav;
	}
	
	/**
	 * 계좌 거래내역에서 더보기 클릭 
	 * @return
	 */
	@ResponseBody
	@PostMapping("/corp/acntDetail")
	public ModelAndView viewMoreTrans(@RequestParam("no") String no, @RequestParam("lastTransNo") String lastTransNo){
		
		ModelAndView mav = new ModelAndView("corp/acntDetailNext");
		
		System.out.println("no : " + no);
		System.out.println("lastTransNo : " + lastTransNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("lastTransNo", lastTransNo);
		
		List<TransactionVO> transList = transactionService.viewNextTrans(map);
		mav.addObject("transListNext", transList);
		return mav;
	}
}
