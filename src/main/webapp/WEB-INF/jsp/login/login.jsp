<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
.card {
	margin: 0 auto;
}
.type {
	float: left;
	background-color: #EBEEED;
}
.card-body {
	width: 100%;
	margin: 0 auto;
}
.btn {
  transition-duration: 0.4s;
  background-color: #EBEEED; 
  color: black; 
  border: none;
  width: 40%;
  margin: 1%;
  height: 150%;
}

.btn:hover {
  background-color: rgba(64, 146, 143, 0.8); /* Green */
  color: white;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function goLogIn(userType) {
	if(userType == 'C')
		location.href = "${ pageContext.request.contextPath }/loginCorp";
	else
		location.href = "${ pageContext.request.contextPath }/loginAcc";
}
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">

	<jsp:include page="../include/header.jsp"/>
	<div class="container" id="changeable">
		<h3 class="title">로그인</h3>
		<div class="card text-center" style="width: 100%;">
		  <div class="card-body">
		    <h5 class="card-title"><b>회원유형</b>을 선택하세요.</h5>
		    <button class="btn" onclick="goLogIn('C')">
		    	<b>기업회원</b><br><br>
		    	사업자번호를 알고 있고<br>
		    	기업회원으로 BEONE을 사용합니다.
		    </button>
		    <button class="btn" onclick="goLogIn('A')">
		    	<b>세무사 회원</b><br><br>
		    	세무사 등록번호를 알고 있고<br>
		    	세무사회원으로 BEONE을 사용합니다.
		    </button>
		    <div class="sub-blank"></div>
		    <a href="${ pageContext.request.contextPath }/signupForm"><button class="btn btn-primary" style="background-color: rgba(233, 117, 80)">회원가입</button></a>
		  </div>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>