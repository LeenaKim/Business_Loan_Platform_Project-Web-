package beone.interest.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import beone.interest.dao.InterestDAO;
import beone.interest.vo.InterestVO;
import beone.util.Logback;

@Service
public class InterestServiceImpl implements InterestService {

	@Autowired
	private InterestDAO interestDAO;
	
	@Autowired
	private Logback logback;
	
	@Override
	public List<InterestVO> selectPerPage(Map<String, Object> map) {
		List<InterestVO> intrList = interestDAO.selectPerPage(map);
		return intrList;
	}

	@Override
	public int selectCnt(String loanNo) {
		int cnt = interestDAO.selectCnt(loanNo);
		return cnt;
	}

	/**
	 * 매월 3일, 12일, 23일 새벽 3시에 이자 징수 
	 */
	@Scheduled(cron = "0 0 3 3 * *")
	@Override
	public void autoPayInterest3() {
		System.out.println("이자징수 스케줄러 호출...");
		interestDAO.autoInterestPay("3");
		// 이자납부 로그찍기
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		String msg = sdf.format(today) + " auto-interest-payment completed";
		logback.interestPay(msg);
	}
	@Scheduled(cron = "0 28 23 12 * *")
	@Override
	public void autoPayInterest12() {
		System.out.println("이자징수 스케줄러 호출...");
		interestDAO.autoInterestPay("12");
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		String msg = sdf.format(today) + " auto-interest-payment completed";
		logback.interestPay(msg);
	}
	@Scheduled(cron = "0 0 3 23 * *")
	@Override
	public void autoPayInterest23() {
		System.out.println("이자징수 스케줄러 호출...");
		interestDAO.autoInterestPay("23");
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		String msg = sdf.format(today) + " auto-interest-payment completed";
		logback.interestPay(msg);
	}

	@Override
	public List<InterestVO> selectAllByLoanNo(String loanNo) {
		List<InterestVO> intrList = interestDAO.selectAllByLoanNo(loanNo);
		return intrList;
	}

	
	
}
