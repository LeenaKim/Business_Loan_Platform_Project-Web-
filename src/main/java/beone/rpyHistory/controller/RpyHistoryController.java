package beone.rpyHistory.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import beone.loanHistory.service.LoanHistoryService;
import beone.loanHistory.vo.LoanHistoryVO;
import beone.rpyHistory.service.RpyHistoryService;
import beone.rpyHistory.vo.RpyHistoryVO;

@Controller
public class RpyHistoryController {

	@Autowired
	private RpyHistoryService rpyHistoryService;
	
	@Autowired
	private LoanHistoryService loanHistoryService;
	
	@GetMapping("/corp/repay/{loanNo}")
	public ModelAndView selectAllRpyHistory(@PathVariable("loanNo") String loanNo, HttpServletRequest request, Model model) {
		List<RpyHistoryVO> rpyHisList = rpyHistoryService.selectAllRpyHis(loanNo);
		
		// 대출계좌까지 넘겨야 상환내역이 아예 없을때도 계좌를 출력할 수 있음.
		LoanHistoryVO loanHis = loanHistoryService.selectByLoanNo(loanNo);
		
		ModelAndView mav = new ModelAndView("corp/rpyHistory2");
		mav.addObject("rpyHisList", rpyHisList);
		mav.addObject("loanHis", loanHis);
		System.out.println(loanHis);
		return mav;
	}
	
	
	/**
	 * 중도상환수수료 계산 ajax 
	 * @param loanNo 대출번호 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/corp/chkRpyFee")
	public int chkRpyFee(@RequestParam("loanNo") String loanNo, @RequestParam("midRpyAmt") int midRpyAmt) {
		Map<String, Object> map = new HashMap<>();
		map.put("loanNo", loanNo);
		map.put("midRpyAmt", midRpyAmt);
		System.out.println("loanNo : " + loanNo);
		System.out.println("midRpyAmt : " + midRpyAmt);
		int midRpyFee = rpyHistoryService.chkRpyFee(map);
		System.out.println("controller midRpyFee : " + midRpyFee);
		return midRpyFee;
	}
	/**
	 * 상환하기 
	 * @param rpyHistory
	 */
	@PostMapping("/corp/repay")
	public String insertNewRpyHistory(RpyHistoryVO rpyHistory) {
		// 잔액변경, 잔금변경, 상환내역 저장
		rpyHistoryService.newRpyHistory(rpyHistory);
		
		return "redirect:/corp/repay/" + rpyHistory.getLoanNo();
	}
}
