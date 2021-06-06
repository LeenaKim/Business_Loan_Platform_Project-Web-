package beone.loanManage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import beone.interest.service.InterestService;
import beone.interest.vo.InterestVO;
import beone.loanHistory.service.LoanHistoryService;
import beone.loanHistory.vo.LoanHistoryVO;
import beone.rpyHistory.service.RpyHistoryService;
import beone.rpyHistory.vo.RpyHistoryVO;


@Controller
public class LoanManageController {

	@Autowired
	private LoanHistoryService loanHistoryService;
	
	@Autowired
	private InterestService interestService;
	
	@Autowired
	private RpyHistoryService rpyHistoryService;
	
	@GetMapping("/emp/loanMng/{loanNo}")
	public ModelAndView loanManageMain(@PathVariable("loanNo") String loanNo) {
		ModelAndView mav = new ModelAndView("emp/loanManage");
		System.out.println("loanNo : " + loanNo);
		
		
		// 1. 대출정보 끌어오기 
		LoanHistoryVO loanHis = loanHistoryService.selectByLoanNo(loanNo);
		
		// 2. 이자납부정보 끌어오기
		List<InterestVO> intrList = interestService.selectAllByLoanNo(loanNo);
		
		// 3. 상환내역 끌어오기
		List<RpyHistoryVO> rpyList = rpyHistoryService.selectAllRpyHis(loanNo);
		
		// 4. 이자연체 계산하기
			// 전체 이자금액 
		long ttlInterest = Math.round(loanHis.getPcplAmt() * loanHis.getInterest());
			
		long delayedInterestAmt = 0; 		// 연체액 
		float delayedInterestRate = 0;		// 연체율
		int delayedInterestCnt = 0;			// 연체횟수
		
		int intrListLastIdx = 0;
		long lastNextMonAmt = 0;
		if(intrList.size() != 0) {
			intrListLastIdx = intrList.size() - 1;
			lastNextMonAmt = intrList.get(intrListLastIdx).getNextMonAmt();			// 가장 최근 '다음달 납부금액'

			// 다음달 납부액이 한달 납부액보다 크면 연체임 
			if(lastNextMonAmt > loanHis.getInterestAmt()) {
				delayedInterestAmt = lastNextMonAmt - loanHis.getInterestAmt(); // 연체금액은 '다음달 납부금액' - '원래 납부금액'
				delayedInterestRate = delayedInterestAmt / ttlInterest * 100; 		// 연체율은 연체금액 / 총 이자금액 * 100
			}

			// 총 이자 납부내역에서 납부액이 0인것만 세면 연체횟수 
			for(InterestVO intr : intrList) {
				if(intr.getPayAmt() == 0) {
					delayedInterestCnt++;
				}
			}
		}
		
		// 5. 그래프를 위해 이자 연체 추이 계산하기
		// 행원이 담당하고있는 모든 대출 가져오기 
		Map<String, Integer> interestByMonMap = new HashMap<>();
				
		// 동적으로 변수 생성
		for(int i = 2; i < 10; i++) {
			interestByMonMap.put("mon" + i,  0);
		}
		// 모든 대출내역 돌며 해당 월인것 맵에 저장 
		int delayedAmtByMon = 0;
		for(int i = 2; i < 10; i++) {
			for(InterestVO interest : intrList) {
				if(interest.getPayAmt() == 0 && interest.getPayDate().contains("-0" + i + "-")) {
					delayedAmtByMon += loanHis.getInterestAmt();
				} else if(interest.getPayAmt() != 0 && interest.getPayDate().contains("-0" + i + "-")) {
					delayedAmtByMon = 0;
				}
			}
			interestByMonMap.put("mon" + i, delayedAmtByMon);
		}
		mav.addObject("interestByMonMap", interestByMonMap);
		
		mav.addObject("loanHis", loanHis);
		mav.addObject("intrList", intrList);
		mav.addObject("rpyList", rpyList);
		mav.addObject("bizrNo", loanHis.getBizrNo());
		mav.addObject("delayedInterestAmt", delayedInterestAmt);
		mav.addObject("delayedInterestRate", delayedInterestRate);
		mav.addObject("delayedInterestCnt", delayedInterestCnt);

		return mav;
	}
	/**
	 * 관심대출 추가 
	 * @param bizrNo
	 * @return
	 */
	@ResponseBody
	@PostMapping("/emp/loanMng/addFocusLoan")
	public String addFocusCorp(@RequestParam("loanNo") String loanNo) {
		loanHistoryService.addFocusLoan(loanNo);
		return "success";
	}
}
