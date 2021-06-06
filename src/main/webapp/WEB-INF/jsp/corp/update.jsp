<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기업정보 수정</title>
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
	color: rgba(64, 146, 143);
}
#signUpDiv {
	text-align: left;
	font-size: 15px;
}
.errorMsg {
	color: red;
	font-size: 10px;
}
</style>
<script src ="http://code.jquery.com/jquery-3.5.1.min.js "></script> 
<script>

</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
	<jsp:include page="../include/header.jsp"/>
	<div class="container" id="changeable">
	
	
	<div class="signUpProcedure" id="corpReg">
		
		<h3 class="title">기업 정보 수정</h3>
		<div class="card text-center" style="width: 100%;">
		  <div class="card-body">
			<form:form modelAttribute="corp" method="post"> 
			<form:input path="pw" type="hidden" value="${ userVO.pw }" readonly="true"/><br>
			<p style="font-size: 13px" class="necessary">* 표시 항목은 대출 신청을 위한 필수 입력 항목입니다.</p>
			<div class="row" id="signUpDiv">
				<div class="col">
					<div class="variables">
						<span class="necessary">* </span>사업자등록번호<br>
						<form:input path="bizrNo" placeholder="'-' 제외" value="${ userVO.bizrNo }" readonly="true"/><br>
						<form:errors class="errorMsg" path="bizrNo"/><br>
					</div>
					<div class="variables">
						법인등록번호<br>
						<form:input path="jurirNo" value="${ userVO.jurirNo }" readonly="true"/><br>
					</div>
					<div class="variables">
						<span class="necessary">* </span>기업체명<br>
						<form:input path="name" value="${ userVO.name }"/><br>
						<form:errors class="errorMsg" path="name"/><br>
					</div>
					<div class="variables">
						기업체영문명<br>
						<form:input path="nameEng" value="${ userVO.nameEng }"/><br>
					</div>
				
				</div>
				<div class="col">
					<div class="variables">
						<span class="necessary">* </span>법인구분<br>
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
						<span class="necessary">* </span>업종<br>
						<form:input path="indutyCode" placeholder="통계청 업종분류기준표 기준" value="${ userVO.indutyCode }"/><br>
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
						<span class="necessary">* </span>주소<br>
						<form:input path="adres" value="${ userVO.adres }"/><br>
					</div>
					<div class="variables">
						홈페이지<br>
						<form:input path="hmUrl" placeholder="http://www를 제외한 나머지 도메인만 입력해주세요." value="${ userVO.hmUrl }"/><br>
					</div>
					<div class="variables">
						팩스번호<br>
						<form:input path="countryCodeFax" style="width: 20%" class="onlyNum" placeholder="ex)82" value="${ userVO.countryCodeFax }"/>
						<form:input path="faxNo" style="width: 65%" value="${ userVO.faxNo }"/><br>
						<form:errors class="errorMsg" path="faxNo"/><br>
						<form:errors class="errorMsg" path="countryCodeFax"/><br>
					</div>
					<div class="variables">
						<span class="necessary">* </span>전화번호<br>
						<form:input path="countryCode" style="width: 20%" class="onlyNum" placeholder="ex)82" value="${ userVO.countryCode }"/>
						<form:input path="phnNo" style="width: 65%" value="${ userVO.phnNo }"/><br>
						<form:errors class="errorMsg" path="phnNo"/><br>
						<form:errors class="errorMsg" path="countryCode"/><br>
					</div>
					<div class="variables">
						<span class="necessary">* </span>설립일<br>
						<form:input type="date" path="estDt" value="${ userVO.estDt }"/><br>
					</div>
				</div>
			
			<div class="blank"></div>
			<div style="margin-left: 40%">
				<input type="submit" class="btn btn-primary" id="update" value="수정">
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