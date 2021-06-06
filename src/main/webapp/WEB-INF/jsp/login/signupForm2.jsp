<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
.variables {
	margin: 3%;
}
.variables > input {
	width: 290px;
} 
.col {
	margin-left: 7%;
}
.necessary {
	color: red;
}
#signUpDiv {
	text-align: left;
	font-size: 15px;
}
.errorMsg {
	color: red;
	font-size: 10px;s
}
</style>
<link href="resources/css/progress-wizard.min.css" rel="stylesheet">
<script src ="http://code.jquery.com/jquery-3.5.1.min.js "></script> 
<script>
/* 
 숫자 외 문자 입력시 제거 
*/
$('.onlyNum').keyup(function() {
	var val = $(this).val();
	console.log($(this))
	console.log($(this).val())
	var pattern = /[^(0-9)]/gi;  
	if(pattern.test(val)){
		/* $('.msg').css('color', 'red'); */
		/* $(this).append('<span style="color: red">숫자만 입력가능합니다.</span>') */
		$(this).val(val.replace(pattern,""));
	}

})
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
	<jsp:include page="../include/header.jsp"/>
	<div class="container" id="changeable">
	
	<!------------------------ 진행바 ------------------------>
        <div class="sub-blank"></div>
        <ul class="progress-indicator">
		  <li class="completed"> <span class="bubble"></span>본인인증</li>
		  <li class="completed"> <span class="bubble"></span>사업자정보 입력</li>
		  <li> <span class="bubble"></span> 가입 완료!</li>
		</ul>
        <div class="sub-blank"></div>
	
	
	
	<div class="signUpProcedure" id="corpReg">
		
		<h3 class="title">사업자정보등록</h3>
		<div class="card text-center" style="width: 100%;">
		  <div class="card-body">
		    <h5 class="card-title">고객님의 사업자 정보를 등록해주세요.</h5>
		    <p>사업자 등록번호로 로그인할 수 있습니다.</p>
		    
			<form:form modelAttribute="corp" method="post"> 
	
			<div class="row" id="signUpDiv">
				<div class="col">
					<div class="variables">
						<span class="necessary">* </span>사업자등록번호<br>
						<form:input path="bizrNo" cssClass="onlyNum" placeholder="'-' 제외"/><br>
						<form:errors class="errorMsg" path="bizrNo"/><br>
					</div>
					<div class="variables">
						법인등록번호<br>
						<form:input path="jurirNo"/><br>
					</div>
					<div class="variables">
						<span class="necessary">* </span>비밀번호<br>
						<form:input path="pw" type="password" placeholder="영문, 숫자, 특수문자 포함 12자"/><br>
						<form:errors class="errorMsg" path="pw"/><br>
					</div>
					<div class="variables">
						<span class="necessary">* </span>비밀번호 확인<br>
						<form:input path="pwConfirm" type="password" placeholder="비밀번호를 다시 입력해주세요."/><br>
						<form:errors class="errorMsg" path="pwConfirm"/><br>
					</div>
					<div class="variables">
						<span class="necessary">* </span>기업체명<br>
						<form:input path="name"/><br>
						<form:errors class="errorMsg" path="name"/><br>
					</div>
					<div class="variables">
						기업체영문명<br>
						<form:input path="nameEng"/><br>
					</div>
				
				</div>
				<div class="col">
					<div class="variables">
						법인구분<br>
						<form:select class="custom-select" style="width: 85%" path="corpCls">
							<form:option value="default">선택</form:option>
							<form:option value="Y">유가증권시장</form:option>
							<form:option value="K">코스닥시장</form:option>
							<form:option value="N">코넥스시장</form:option>
							<form:option value="E">기타법인</form:option>
						</form:select>
						
						<br>
					</div>
					
					<div class="variables">
						업종<br>
						<form:input path="indutyCode" class="onlyNum" placeholder="통계청 업종분류기준표 기준"/><br>
						<form:errors class="errorMsg" path="indutyCode"/><br>
					</div>
					<div class="variables">
						결재월<br>
						<form:select class="custom-select" style="width: 85%" path="accMt">
							<form:option value="default">선택</form:option>
								<c:forEach var="i" begin="1" end="12">
									<form:option value="${ i }">${ i }월</form:option>
								</c:forEach>
						</form:select><br>
					</div>
					<div class="variables">
						주소<br>
						<form:input path="adres"/><br>
					</div>
					<div class="variables">
						홈페이지<br>
						<form:input path="hmUrl" placeholder="http://www를 제외한 나머지 도메인만 입력해주세요."/><br>
					</div>
					<div class="variables">
						팩스번호<br>
						<form:input path="countryCodeFax" style="width: 20%" class="onlyNum" placeholder="ex)82"/>
						<form:input path="faxNo" style="width: 65%"/><br>
						<form:errors class="errorMsg" path="countryCodeFax"/><br>
						<form:errors class="errorMsg" path="faxNo"/><br>
					</div>
					<div class="variables">
						전화번호<br>
						<form:input path="countryCode" style="width: 20%" class="onlyNum" placeholder="ex)82"/>
						<form:input path="phnNo" style="width: 65%"/><br>
						<form:errors class="errorMsg" path="countryCode"/><br>
						<form:errors class="errorMsg" path="phnNo"/><br>
					</div>
					<div class="variables">
						설립일<br>
						<form:input type="date" path="estDt"/><br>
					</div>
				</div>
			
			<div class="blank"></div>
			<div style="margin-left: 40%">
				<input type="submit" class="btn btn-primary" id="join" value="가입">
			</div>	
			</div>
			
			</form:form>
		  </div>
		</div>
		<div class="blank"></div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />
</body>
</html>