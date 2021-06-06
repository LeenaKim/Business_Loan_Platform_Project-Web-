package beone.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import beone.corp.vo.CorpVO;

public class RegisterRequestValidator implements Validator {

	private static final String bizrNoRegExp = "[0-9]+";
	private static final String pwRegExp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{12,20}$";
	
	private Pattern bizrNoPattern;
	private Pattern pwPattern;
	
	public RegisterRequestValidator() {
		bizrNoPattern = Pattern.compile(bizrNoRegExp);
		pwPattern = Pattern.compile(pwRegExp);
	}
	
	@Override
	public boolean supports(Class<?> clazz) {
		return CorpVO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		CorpVO regReq = (CorpVO) target;

		// 사업자 등록정보 유효성 검증 
		if(regReq.getBizrNo() == null || regReq.getBizrNo().trim().isEmpty()) {
			errors.rejectValue("bizrNo", "required", "필수 정보입니다.");
		} else {
			Matcher matcher = bizrNoPattern.matcher(regReq.getBizrNo());
			if(!matcher.matches()) {
				errors.rejectValue("bizrNo", "bad", "숫자만 입력해주세요.");
			}
		}
		
		// 비밀번호 유효성 검증
		if(regReq.getPw() == null || regReq.getPw().trim().isEmpty()) {
			errors.rejectValue("pw", "required", "필수 정보입니다.");
		} else {
			Matcher matcher = pwPattern.matcher(regReq.getPw());
			if(!matcher.matches()) {
				errors.rejectValue("pw", "bad", "특수문자/문자/숫자 포함 형태의 12 - 20자리 비밀번호를 입력해주세요. ");
			}
		}
		
		// 기업체명 유효성 검증
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required", "필수 정보입니다.");
		// 비밀번호 확인 유효성 검증 
		ValidationUtils.rejectIfEmpty(errors, "pwConfirm", "required", "필수 정보입니다.");
		if(!regReq.getPw().isEmpty()) {
			if(!regReq.isPwEqualToPwConfirm()) {
				errors.rejectValue("pwConfirm", "nonmatch", "비밀번호가 일치하지 않습니다.");
			}
		}
		
		// 팩스번호, 전화번호 유효성 검증
		if(regReq.getFaxNo() != null) {
			Matcher matcher = bizrNoPattern.matcher(regReq.getFaxNo());
			if(matcher.matches()) {
				errors.rejectValue("faxNo", "bad", "숫자만 입력해주세요.");
			}
		}
		if(regReq.getPhnNo() != null) {
			Matcher matcher = bizrNoPattern.matcher(regReq.getPhnNo());
			if(matcher.matches()) {
				errors.rejectValue("phnNo", "bad", "숫자만 입력해주세요.");
			}
		}
		if(regReq.getIndutyCode() != null) {
			Matcher matcher = bizrNoPattern.matcher(regReq.getIndutyCode());
			if(matcher.matches()) {
				errors.rejectValue("indutyCode", "bad", "숫자만 입력해주세요.");
			}
		}
		if(regReq.getCountryCode() != null) {
			Matcher matcher = bizrNoPattern.matcher(regReq.getCountryCode());
			if(matcher.matches()) {
				errors.rejectValue("countryCode", "bad", "숫자만 입력해주세요.");
			}
		}
		if(regReq.getCountryCodeFax() != null) {
			Matcher matcher = bizrNoPattern.matcher(regReq.getCountryCodeFax());
			if(matcher.matches()) {
				errors.rejectValue("countryCodeFax", "bad", "숫자만 입력해주세요.");
			}
		}
	}

}
