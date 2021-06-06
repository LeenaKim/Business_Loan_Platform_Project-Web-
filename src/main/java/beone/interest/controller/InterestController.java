package beone.interest.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import beone.corp.vo.CorpVO;
import beone.interest.service.InterestService;
import beone.interest.vo.InterestVO;
import beone.loanHistory.service.LoanHistoryService;
import beone.loanHistory.vo.LoanHistoryVO;

@Controller
public class InterestController {
	
	@Autowired
	private LoanHistoryService loanHistoryService;
	
	@Autowired
	private InterestService interestService;
	
	@RequestMapping("/corp/interest")
	public ModelAndView viewInterest(HttpSession session, HttpServletRequest request) {
		CorpVO corp = (CorpVO)session.getAttribute("userVO");

		// 1. 대출내역 리스트 
		List<LoanHistoryVO> loanHisList = loanHistoryService.selectAllLoanHistory(corp.getBizrNo());
		
		ModelAndView mav = new ModelAndView("corp/viewInterest");
		
		// 2. 대출 내역중 가장 최근 대출 끌어오기
		LoanHistoryVO loanHis = null;
		if(request.getParameter("loanNo") == null) {
			// 대출번호가 파라미터로 날라오지 않았으면 가장 최근 대출 끌어오기 
			loanHis = loanHistoryService.selectOneLatest(corp.getBizrNo());			
		} else {
			// 대출번호가 파라미터로 날라왔다면 해당 대출 끌어오기 
			loanHis = loanHistoryService.selectByLoanNo(request.getParameter("loanNo"));
		}
		
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
		int totalBoardCnt = interestService.selectCnt(loanHis.getLoanNo());
				
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
		map.put("loanNo", loanHis.getLoanNo());
		
		List<InterestVO> intrList = interestService.selectPerPage(map);
		
		request.setAttribute("blockStartPageNo", blockStartPageNo);
		request.setAttribute("blockEndPageNo", blockEndPageNo);
		request.setAttribute("blockNo", blockNo);
		request.setAttribute("totalBlockCnt", totalBlockCnt);
		request.setAttribute("pageNo", pageNo);  
		request.setAttribute("totalBoardCnt", totalBoardCnt);
		
		mav.addObject("loanHis", loanHis);
		mav.addObject("loanHisList", loanHisList);
		mav.addObject("intrList", intrList);
		
		return mav;
	}
	
	
}
