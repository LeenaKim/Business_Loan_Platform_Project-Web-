<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세무사 인증</title>
<jsp:include page="../include/css.jsp" />
<style>

</style>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">

	<jsp:include page="../include/header.jsp"/>
	<div class="container" id="changeable">
		<h3 class="title">세무사 인증</h3>
		<hr>
		<h4 class="subtitle">담당 세무사 목록</h4>
		${ userVO.name }를 담당하고있는 세무사 목록입니다. 제외시키려면 제외 버튼을 클릭하세요.
		<table class="table table-sm">
		<!-- checkbox 로 한꺼번에 제외  -->
			<tr>
				<th style="width: 40%">세무사 등록번호</th>
				<th style="width: 30%">이름</th>
				<th style="width: 30%">인증일</th>
			</tr>
		</table>
		<a href="#" class="btn btn-primary">제외하기</a>
		<h4 class="subtitle">세무사 인증 요청 목록</h4>
		${ userVO.name }에 인증을 요청한 세무사 목록입니다. 담당 세무사가 맞다면 인증하기 버튼을 클릭해주세요. <br>세무사는 최대 다섯명까지만 등록가능합니다.
		<table class="table table-sm">
		<!-- checkbox 로 한꺼번에 인증  -->
			<tr>
				<th style="width: 40%">세무사 등록번호</th>
				<th style="width: 30%">이름</th>
				<th style="width: 30%">인증 요청일</th>
			</tr>
		</table>
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>