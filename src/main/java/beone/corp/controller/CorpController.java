package beone.corp.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import beone.accountant.service.AccountantService;
import beone.accountant.vo.AccountantVO;
import beone.auth.service.AuthService;
import beone.auth.vo.AuthVO;
import beone.corp.service.CorpService;
import beone.corp.vo.CorpVO;
import beone.doc.service.DocService;
import beone.doc.vo.DocVO;
import beone.exception.AlreadyExistingCorpException;
import beone.loanApp.service.LoanAppService;
import beone.loanApp.vo.LoanAppVO;
import beone.loanHistory.service.LoanHistoryService;
import beone.loanHistory.vo.LoanHistoryVO;
import beone.rep.vo.RepVO;
import beone.sendSms.SendSmSTwilio;
import beone.util.Logback;
import beone.util.RegisterRequestValidator;

@SessionAttributes({"userVO", "accVO"})
@Controller
public class CorpController {

	@Autowired 
	private CorpService corpService;
	
	@Autowired
	private AccountantService accountantService;
	
	@Autowired
	private LoanAppService loanAppService;
	
	@Autowired
	private LoanHistoryService loanHistoryService;
	
	@Autowired
	private DocService docService;
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private AuthService authService;
	
	@Autowired
	private Logback logback;
	
	/**
	 * 전체 로그인 화면으로 이동 
	 * @return
	 */
//	@RequestMapping(value="/login", method = RequestMethod.GET)
	@GetMapping("/login")
	public String loginForm() {
		
		return "login/login";
	}
	/**
	 * 기업 로그인 화면으로 이동 
	 * @return
	 */
	@GetMapping("/loginCorp")
	public String loginCorp() {
		return "login/loginCorp";
	}
	/**
	 * 회원가입 화면으로 이동 
	 * @return
	@GetMapping("/signup")
	public String signUpForm(Model model) {
		model.addAttribute("corpVO", new CorpVO());
		
		return "login/signupForm";
	}
	 */
	/**
	 * 회원가입 2단계 : 사업자 등록정보로 이동 (GET)
	 * @return
	 */
	@GetMapping("/signupForm2")
	public String signUpGet(Model model) {
		model.addAttribute("corp", new CorpVO());
		return "login/signupForm2";
	}
	/**
	 * 회원가입 2단계 완료 (POST)
	 * @param corpVO
	 * @return
	 */
	@PostMapping("/signupForm2")
	public String signUp(@ModelAttribute("corp")CorpVO corp, Errors errors) {

		// 유효성 검증한 클래스의 validate 메소드 호출 
		new RegisterRequestValidator().validate(corp, errors);

		// 법인유형으로 들어온 값이 '선택'일시 null처리 
		if(corp.getCorpCls().equals("default")) {
			corp.setCorpCls(null);
		}
		// 결재월로 들어온 값이 '선택'일시 null처리 
		if(corp.getAccMt().equals("default")) {
			corp.setAccMt(null);
		}
		
		if(errors.hasErrors()) {
			// 에러가 있을시 원래 페이지로 돌아가게 
			return "login/signupForm2";
		}
		try {
			// 없을시 DAO insert 로직 수행 
			corpService.registerNewCorp(corp);
		} catch (AlreadyExistingCorpException e) {
			// 수행도중 이미 가입된 기업 에러가 나면 뷰단으로 에러 보내기 
			errors.rejectValue("bizrNo", "duplicate", "이미 가입된 사업자등록번호입니다.");
			return "login/signupForm2";
		}
		return "login/signupForm3";
	}
	/**
	 * 회원가입시 본인인증 기능 
	 * @return
	 */
	@ResponseBody
	@GetMapping("/signup/auth")
	public int smsAuth(@RequestParam("phnNo") String phnNo) {
		System.out.println(phnNo);
		// 인증 클래스의 인증 메소드 호출 
		int authNum = SendSmSTwilio.sendSMS("82", phnNo);
		System.out.println(authNum);
		return authNum;
	}
	
	/**
	 * 회원가입 1단계 본인인증 페이지 띄우기 
	 * @return
	 */
	@GetMapping("/signupForm")
	public String signUpForm() {
		return "login/signupForm";
	}
	/**
	 * 로그인 기능 
	 * @param corp
	 * @param session
	 * @param result
	 * @return
	 */
//	@RequestMapping(value="/login", method = RequestMethod.POST)
	@PostMapping("/loginCorp")
	public ModelAndView login(CorpVO corp, HttpSession session, BindingResult result) {
		
		CorpVO userVO = corpService.login(corp);
		ModelAndView mav = new ModelAndView();
		
		
		// 로그인 실패 
		if(userVO == null) {
			mav.setViewName("login/loginCorp");
			mav.addObject("loginResult", "* 없는 아이디거나 비밀번호가 맞지 않습니다.");
		} 
		else {
			// 로그인 성공 
			if(session.getAttribute("dest") != null) {
				mav.setViewName("redirect:/" + session.getAttribute("dest"));				
				session.removeAttribute("dest");
			} else {
				mav.setViewName("redirect:/");		
			}
			mav.addObject("userVO", userVO);
			
			String msg = userVO.getBizrNo() + " logged in";
			logback.loginLog(msg);
		}
		
		return mav;
	}
	/**
	 * 로그아웃 기능 
	 * @param status
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}
	/**
	 * 기업분석 페이지 로딩 
	 * @param session
	 * @return
	 */
	@RequestMapping("/corp/analysis")
	public ModelAndView corpAnalysis(HttpSession session) {
		ModelAndView mav = new ModelAndView("corp/analysis");
		
		// 1. 대표자 불러오기 
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		List<RepVO> repList = corpService.selectAllRep(corp);
		mav.addObject("repList", repList);
		
		// 2. 재무정보 불러오기 
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
		mav.addObject("finList", finList2);
		
		// 3. 신용 이력 불러오기 
		List<Map<String, String>> creditRnkList = corpService.selectAllCredit(corp);
		
		mav.addObject("creditRnkList", creditRnkList);
		
		return mav;
	}
	/**
	 * 마이페이지 로딩 
	 * @param session
	 * @return
	 */
	@RequestMapping("/corp/mypage")
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView("corp/mypage");
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		
		// 1. 세무사 리스트 불러오기
		List<AccountantVO> accountantList = accountantService.selectAll(corp);
		for(AccountantVO ac : accountantList) {
			System.out.println(ac);
		}
		mav.addObject("accountantList", accountantList);
		
		// 2. 대표자 불러오기 
		List<RepVO> repList = corpService.selectAllRep(corp);
		mav.addObject("repList", repList);
		
		// 3. 대출 신청 현황 불러오기
		List<LoanAppVO> loanAppList = loanAppService.selectAllLoanApp(corp.getBizrNo());
		mav.addObject("loanAppList", loanAppList);
		
		// 4. 대출 내역 불러오기 
		List<LoanHistoryVO> loanHisList = loanHistoryService.selectAllLoanHistory(corp.getBizrNo());
		mav.addObject("loanHisList", loanHisList);
		
		// 5. 서류 불러오기 
		List<DocVO> docList = docService.selectAllDoc(corp);
		mav.addObject("docList", docList);
		
		// 6. 인증 요청한 세무사 리스트 불러오기
		List<AuthVO> authList = authService.selectAllAuthWaitingCorpSide(corp);
		mav.addObject("authList", authList);
		return mav;
	}
	/**
	 * 마이페이지 기업 프로필 수정 (GET)
	 * @return
	 */
	@RequestMapping("/corp/update")
	public String updateMyPageForm(Model model) {
		model.addAttribute("corp", new CorpVO());
		return "corp/update";		
	}
	/**
	 * 정보수정 (POST)
	 * @param corpVO
	 * @return
	 */
	@PostMapping("/corp/update")
	public String updateMyPageProcess(@ModelAttribute("corp")CorpVO corp, Errors errors, HttpSession session) {
		System.out.println(corp);
		
		// 유효성 검증한 클래스의 validate 메소드 호출 
		new RegisterRequestValidator().validate(corp, errors);
				
		// 법인유형으로 들어온 값이 '선택'일시 null처리 
		if(corp.getCorpCls().equals("default")) {
			corp.setCorpCls(null);
		}
		// 결재월로 들어온 값이 '선택'일시 null처리 
		if(corp.getAccMt().equals("default")) {
			corp.setAccMt(null);
		}
		
		if(errors.hasErrors()) {
			// 에러가 있을시 원래 페이지로 돌아가게 
			return "corp/update";
		}
		// 없을시 DAO insert 로직 수행 
		CorpVO corpVO = corpService.updateCorp(corp);
		// 세션에 등록
		session.setAttribute("userVO", corpVO);
		return "redirect:/corp/mypage";
	}
	
}

