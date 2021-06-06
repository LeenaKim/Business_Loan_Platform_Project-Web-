<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출 신청 현황</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
div.scrollmenu {
  overflow: auto;
  white-space: nowrap;
}

div.scrollmenu a {
  display: inline-block;
  color: white;
  text-align: center;
  padding: 14px;
  text-decoration: none;
}

div.scrollmenu a:hover {
  background-color: #777;
}
</style>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/header.jsp"/>

	<div class="container" id="changeable">
		<h3 class="title">대출신청이 완료되었습니다.</h3>
		서류 심사 후 개별 연락드리겠습니다.<br>
		서류 심사는 1주일 내외로 소요됩니다.<br>
		신청 현황은 대출>대출 신청 현황 페이지 및 마이페이지에서 확인할 수 있습니다.<br>
		 
		<div class="blank"></div>
		<div class="blank"></div>
		<div style="text-align: center">
	  		<a href="<%= request.getContextPath() %>/corp/loanAppStatus"><input type="button" class="btn btn-primary" value="신청 현황"></a>
	  	</div> 
	</div>
<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />
</body>
</html>