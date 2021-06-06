package beone.loanHistory.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import beone.corp.vo.CorpVO;
import beone.loanHistory.service.LoanHistoryService;
import beone.loanHistory.vo.LoanHistoryVO;

@Controller
public class LoanHistoryController {

	@Autowired
	private LoanHistoryService loanHistoryService;
	
	@RequestMapping("/corp/loanHistory")
	public ModelAndView selectAllLoanHistory(HttpSession session) {
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		// 세션 구현 후 세션의 bizrNo를 받아다 파라미터로 넘기기
		
		List<LoanHistoryVO> list = loanHistoryService.selectAllLoanHistory(corp.getBizrNo());
	
		ModelAndView mav = new ModelAndView("corp/loanHistory");
		
		mav.addObject("loanHistoryList", list);
		return mav;
	}
	
	
}
