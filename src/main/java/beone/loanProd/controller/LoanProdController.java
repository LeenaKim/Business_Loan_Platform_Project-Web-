package beone.loanProd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import beone.loanProd.vo.LoanProdVO;

@Controller
public class LoanProdController {

	@Autowired
	private SqlSessionTemplate session;
	
	
	@RequestMapping("/corp/loanProd")
	public String loanProdPaging(HttpServletRequest request) {
		
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
		int boardCntPerPage = 10;
		int pageCntPerBlock = 5;
				
		// 블록의 시작 페이지와 끝 페이지 (등차수열 적용)
		int blockStartPageNo = 1 + pageCntPerBlock * (blockNo - 1);
		int blockEndPageNo = pageCntPerBlock * blockNo;
				
		//// 전체 게시글 수 구하는 코드(dao로 db에 접근해서 cnt 얻어옴)
		int totalBoardCnt = session.selectOne("loanProd.dao.loanProdDAO.selectCnt");
				
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
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("pageNo", pageNo);
		map.put("boardCntPerPage", boardCntPerPage);
		
		List<LoanProdVO> list = session.selectList("loanProd.dao.loanProdDAO.selectPerPage", map);
		
		request.setAttribute("blockStartPageNo", blockStartPageNo);
		request.setAttribute("blockEndPageNo", blockEndPageNo);
		request.setAttribute("blockNo", blockNo);
		request.setAttribute("totalBlockCnt", totalBlockCnt);
		request.setAttribute("pageNo", pageNo);  
		request.setAttribute("totalBoardCnt", totalBoardCnt);
		request.setAttribute("loanProd", list);
				
		return "/corp/loanProdList";
	}
	
	@RequestMapping("/corp/loanProd/comp")
	public ModelAndView selectMulProd(@RequestParam("no[]") List<String> no) {
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		map.put("list", no);
		
		List<LoanProdVO> list = session.selectList("loanProd.dao.loanProdDAO.selectMulProd", map);
		
		ModelAndView mav = new ModelAndView("/corp/loanProdComp");
		mav.addObject("loanProdComp", list);
		
		return mav;
	}
	
	@RequestMapping("/corp/loanDetail")
	public ModelAndView laonDetail(@RequestParam("no") String no) {
		LoanProdVO loan = session.selectOne("loanProd.dao.loanProdDAO.selectOndProd", no);
		
		ModelAndView mav = new ModelAndView("/corp/loanDetail");
		mav.addObject("loanProd", loan);
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/corp/loanProd/test")
	public String interestTest(@RequestParam("loanType") String loanType, @RequestParam("standard") String standard) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("loanType", loanType);
		map.put("standard", standard);
		
		float interestFloat = session.selectOne("loanProd.dao.loanProdDAO.selectInterest", map);
		String interest = String.valueOf(interestFloat);
		return interest;
	}
	
	
	
}
