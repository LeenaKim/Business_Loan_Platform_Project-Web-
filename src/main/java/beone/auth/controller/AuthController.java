package beone.auth.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import beone.accountant.vo.AccountantVO;
import beone.auth.service.AuthService;
import beone.auth.vo.AuthVO;
import beone.corp.vo.CorpVO;

@Controller
public class AuthController {

	@Autowired
	private AuthService authService;
	
	/**
	 * 세무사의 인증요청 
	 * @param bizrNo
	 */
	@ResponseBody
	@PostMapping("/acc/auth")
	public void requestCorpAuth(@RequestParam("bizrNo") String bizrNo, HttpSession session) {
		AccountantVO acc = (AccountantVO)session.getAttribute("accVO");
		AuthVO auth = new AuthVO();
		auth.setBizrNo(bizrNo);
		auth.setAccNo(acc.getAccNo());
		authService.insertNewAuth(auth);
	}
	/**
	 * 기업이 세무사 인증 확인 
	 * @param session
	 * @param accNo
	 */
	@ResponseBody
	@PostMapping("/corp/authConfirm")
	public void authConfirm(HttpSession session, @RequestParam("accNo") String accNo) {
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		AuthVO auth = new AuthVO();
		auth.setBizrNo(corp.getBizrNo());
		auth.setAccNo(accNo);
		System.out.println(auth);
		authService.confirmAuth(auth);
	}
	/**
	 * 기업이 인증된 세무사 삭제 
	 * @param session
	 * @param accNo
	 */
	@ResponseBody
	@PostMapping("/corp/authDelete")
	public void deleteAuth(HttpSession session, HttpServletRequest request) {
		CorpVO corp = (CorpVO)session.getAttribute("userVO");
		AuthVO auth = new AuthVO();
		auth.setBizrNo(corp.getBizrNo());
		auth.setAccNo(request.getParameter("accNo"));
		System.out.println(auth);
		authService.deleteAuth(auth);
	}
}
