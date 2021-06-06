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

</style>
<link href="resources/css/progress-wizard.min.css" rel="stylesheet">
<script src ="http://code.jquery.com/jquery-3.5.1.min.js "></script> 
<script>

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
		  <li class="completed"> <span class="bubble"></span> 가입 완료!</li>
		</ul>
        <div class="sub-blank"></div>
		
		
		<div class="card text-center">
		  <div class="card-body">
		    회원가입이 완료되었습니다. <br>
		    로그인해주세요.
		    <div class="blank"></div>
			<div style="text-align: center">
				<a href="${ pageContext.request.contextPath }/login"><input type="submit" class="btn btn-primary" id="join" value="로그인"></a>
			</div>	
		  </div>
		</div>
	
	
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />
</body>
</html>