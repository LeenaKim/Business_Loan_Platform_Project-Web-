<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
td {
	padding: 2%
}
</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="${ pageContext.request.contextPath }/resources/js/chkData.js"></script>
<script>
function doLogin() {
	let lf = document.loginForm;
	
	if(isNull(lf.bizrNo, '직원번호를 입력하세요.'))
		return false;
	if(isNull(lf.pw, '비밀번호를 입력하세요.'))
		return false;
	
	return true;
}
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">

	<jsp:include page="../include/header.jsp"/>
	<div class="container" id="changeable" align="center">
		<h3 class="title">로그인</h3>
		<hr>
		<div class="sub-blank"></div>
		<form action="${ pageContext.request.contextPath }/emp/login" method="post" name="loginForm" onsubmit="return doLogin();"> 
		<table class="table-borderless">
			<tr>
				<th>직원번호</th>
				<td><input name="empno" type="text"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input name="pw" type="password"/></td>
			</tr>
			<c:if test="${ not empty loginResult }">
				<tr>
					<th colspan="2" style="color: red">${ loginResult }</th>
				</tr>
			</c:if>
		</table>
		<div class="blank"></div>
		<input type="submit" class="btn btn-primary" value="로그인" id="login">
		</form> 
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>