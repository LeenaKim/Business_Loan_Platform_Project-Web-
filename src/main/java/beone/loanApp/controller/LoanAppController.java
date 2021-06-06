package beone.loanApp.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import beone.acnt.service.AcntService;
import beone.acnt.vo.AcntVO;
import beone.corp.vo.CorpVO;
import beone.doc.service.DocService;
import beone.doc.vo.DocVO;
import beone.loanApp.service.LoanAppService;
import beone.loanApp.vo.LoanAppVO;
import beone.loanEval.service.LoanEvalService;
import beone.loanEval.vo.LoanEvalVO;
import beone.loanProd.service.LoanProdService;
import beone.loanProd.vo.LoanProdVO;
import beone.sendSms.SendSmSTwilio;
import beone.util.Logback;

@Controller
public class LoanAppController {

	@Autowired
	private LoanAppService loanAppService;

	@Autowired
	private LoanProdService loanProdService;
	
	@Autowired
	private DocService docService;
	
	@Autowired
	private AcntService acntService;
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private Logback logback;
	
	@Autowired
	private LoanEvalService loanEvalService;
	
	/**
	 * 기업 : 대출 신청 페이지 
	 * @param prodNo
	 * @param session
	 * @return
	 */
	@GetMapping("/corp/loanApp")
	public ModelAndView loanApplyForm(@RequestParam("prodNo") String prodNo, HttpSession session) {
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		System.out.println(corp);
		
		// '가입' 버튼 클릭시 기업 기본정보가 모두 채워져있는지 확인
		ModelAndView mav = new ModelAndView("/corp/loanApply");
		
		// 신청 페이지를 불러오기 위한 작업
		// 1. 선택한 상품에 대한 정보
		LoanProdVO loan = loanProdService.selectOne(prodNo);
		mav.addObject("loanProd", loan);
		
		// 2. 유저가 보관하고있는 서류에 대한 정보 
		List<DocVO> docList = docService.selectAllDoc(corp);
		mav.addObject("docList", docList);
		
		// 3. 유저 명의의 계좌 정보 
		List<AcntVO> acntList = acntService.selectAll(corp);
		mav.addObject("acntList", acntList);
		
		return mav;
	}
	/**
	 * 기업 : 대출 신청 프로세스 
	 * @param loanApp
	 * @param prodNo
	 * @param assTypeM
	 * @param assTypeW
	 * @param docNo
	 * @return
	 */
	@PostMapping("/corp/loanApp")
	public String insertLoanApp(LoanAppVO loanApp, @RequestParam("prodNo") String prodNo, 
			@RequestParam("assTypeM") String assTypeM, @RequestParam("assTypeW") String assTypeW,
			@RequestParam("docNo") int[] docNo, HttpSession session) {
		
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		
		// 대출 유형 : 물적 담보 
		if(!assTypeM.equals("선택")) {
			loanApp.setAssType(assTypeM);
		// 대출 유형 : 보증서 담보 
		} else if(!assTypeW.equals("선택")){
			loanApp.setAssType(assTypeW);
		// 대출 유형 : 신용 담보 
		} else {
			loanApp.setAssType(null);
		}
		
		// null로 바꿔줘야 db에서 트리거에 의해 계좌 생성함 
		if(loanApp.getLoanAcnt().equals("신규 개설")) {
			loanApp.setLoanAcnt(null);
		}
		
		if(loanApp.getInterestAcnt().equals("계좌 없음")) {
			loanApp.setInterestAcnt(null);
		}
		System.out.println("interestData : " + loanApp.getInterestDate());
		
		// 신청 서류 등록
		loanAppService.insertLoanApp(loanApp, docNo);
		
		// 신청완료 문자 보내기 
		String msg = corp.getName() + "님, 대출 신청이 완료되었습니다.";
		SendSmSTwilio.sendDirectSMS(msg);
		
		// 신청 로그 찍기
		String logMsg = corp.getBizrNo() + " completed loan apply";
		logback.loanAppLog(logMsg);
		
		return "corp/loanAppDone";
		
	}
	/**
	 * 기업 : 대출 신청 현황 페이지 
	 * @param session
	 * @return
	 */
	@RequestMapping("/corp/loanAppStatus")
	public ModelAndView selectAllLoanApp(HttpSession session) {
		CorpVO userVO = (CorpVO)session.getAttribute("userVO");
		List<LoanAppVO> list = loanAppService.selectAllLoanApp(userVO.getBizrNo());
		
		ModelAndView mav = new ModelAndView("corp/loanAppStatus");
		for(LoanAppVO la : list) {
			System.out.println(la);
		}
		mav.addObject("loanAppList", list);
		
		return mav;
		
	}
	/**
	 * 기업 : 대출 거절 사유 가져오기 
	 * @param appNo
	 * @return
	 */
	@ResponseBody
	@GetMapping("/corp/refusalRsn")
	public String getRefusalRsn(@RequestParam("appNo") int appNo) {
		System.out.println("진입...");
		LoanEvalVO loanEval = loanEvalService.selectEvalComment(appNo);
		return loanEval.getEvalComment();
	}
	
}
