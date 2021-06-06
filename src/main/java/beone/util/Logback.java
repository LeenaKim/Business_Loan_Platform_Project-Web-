package beone.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import beone.corp.vo.CorpVO;

@Component
public class Logback {

	private static final Logger log = LoggerFactory.getLogger(Logback.class);
	
//	public static void main(String[] args) {
//		new Logback().test();
//	}
	/*
	public void test() {
		CorpVO corp = new CorpVO();
		corp.setName("MGM 컴퍼니");
		corp.setBizrNo("1111");
		
		log.debug("debug~!" + corp.getName());
		log.info("info!!");
		log.warn("warn!");	
		log.error("error!");
	}
	*/
	/**
	 * 로그인 로그 찍기 
	 * @param msg
	 */
	public void loginLog(String msg) {
		log.info(msg);
	}
	/**
	 * 대출신청 로그 찍기 
	 * @param msg
	 */
	public void loanAppLog(String msg) {
		log.info(msg);
	}
	/**
	 * 이자 자동납부 로그찍기 
	 * @param msg
	 */
	public void interestPay(String msg) {
		log.info(msg);
	}
}
