package beone.sendSms;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class SendSmSTwilio {

	// Find your Account Sid and Token at twilio.com/user/account
	  public static final String ACCOUNT_SID = "AC92532dd8ede776012382089c19c6929d";
	  public static final String AUTH_TOKEN = "085fd34ca9922b67c614f1d3343ec637";
	  
	  // 인증번호 보내기 
	  public static int sendSMS (String country, String phoneNum) {

		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
	    
	    // 휴대폰 인증번호 생성
	    int authNum = randomRange(100000, 999999);
	    
	    
	    // 전송대상 휴대폰 번호
	    String sendTarget = "+"+ country + phoneNum;
	    System.out.println("sendTarget : " + sendTarget);
	    // 전송 메세지
	    String authMsg = "[BEONE] 인증번호는 [" + authNum + "] 입니다." ;
	    
	    
	    Message message = Message.creator(
	    	// to
	    	new PhoneNumber(sendTarget),
	        // from
	    	new PhoneNumber("+12059645984"), 
	        // message
	    	authMsg).create();
	    
		return authNum;
	  }
	  
	  // 인증번호 범위 지정
	  public static int randomRange(int n1, int n2) {
	    return (int) (Math.random() * (n2 - n1 + 1)) + n1;
	  }
	  
	  /**
	   * 그 외의 메세지 지정 문자 보내기
	   * @param country
	   * @param phoneNum
	   * @return
	   */
	  public static void sendDirectSMS (String msg) {

			Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		    
		    // 전송대상 휴대폰 번호
		    String sendTarget = "+821039122836";
		    System.out.println("sendTarget : " + sendTarget);
		    // 전송 메세지
		    
		    Message message = Message.creator(
		    	// to
		    	new PhoneNumber(sendTarget),
		        // from
		    	new PhoneNumber("+12059645984"), 
		        // message
		    	msg).create();
		  }
	  
}
