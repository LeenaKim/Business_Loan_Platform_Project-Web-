<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계좌 조회</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
.card{
	box-shadow: 2px 2px 10px #253B31;
}
.btn-block{
	font-size: 15px;
	padding: 1%;
}
#balance{
	border-botton: 3px solid rgba(64, 146, 143);
}
.smallLetter{
	font-size: 13px; 
	color: gray;
}
.smallBtn {
	margin-top: 2%;
	background-color: #E0E4E3;
	color: #3F403F;
	border: none;
}
</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
$(document).ready(function() {
	
	/* 
		계좌 상세조회 (거래내역)
	*/
	$('.view').click(function() {
		let no = $(this).val();
		console.log(no)
		location.href = "${ pageContext.request.contextPath }/corp/acntDetail/" + no;
	})
	
	/* 
		계좌이체 
	*/
	$('.trans').click(function() {
		let no = $(this).val();
		console.log(no)
		location.href = "${ pageContext.request.contextPath }/corp/trans/" + no;
	})
})
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/header.jsp"/>
	<!-- 총 잔액 구하기 -->
	<c:forEach items="${ acntList }" var="acnt" varStatus="loop">
		<c:set var= "balanceSum" value="${balanceSum + acnt.balance}"/>
	</c:forEach>
	
	
	
	<div class="container" id="changeable">
		<h3 class="title"><i class="ni ni-money-coins" style="color: rgba(64, 146, 143)"></i><br><b>대출계좌 조회</b></h3>
		<h4 style="display:inline"><b>${ userVO.name }</b> 고객님의 </h4><br>
		<h5 style="display:inline;">대출계좌 내역입니다.</h5>
		<h5 style="display:inline; float:right">총 잔액</h5><br><br>
		<h2 style="border-bottom: 3px solid rgba(64, 146, 143); float:right;"><fmt:formatNumber value="${ balanceSum }" pattern="###,###,###,###" /> 원</h2>
		<div class="blank" style="clear: both;"></div>
		
		<hr>
		<div class="row">
		<c:forEach items="${ acntList }" var="acnt" varStatus="loop">
		
			<div class="col">
				<div class="card" style="width: 21rem; height: 11rem; margin: 3%;" >
					<h5 class="card-header"><span class="smallLetter">HANA 기업 자유입출금</span><br>${ acnt.no }</h5>
			 		 <div class="card-body">
			 		 	<h3 class="card-text" style="text-align: center;">
			 		 		<span class="smallLetter">잔액</span>&nbsp;
			 		 		<fmt:formatNumber value="${ acnt.balance }" pattern="###,###,###,###" />
			 		 		<span class="smallLetter">원</span><br>
				 		 	<button class="btn btn-secondary smallBtn view" value="${ acnt.no }">조회</button>
				 		 	<button class="btn btn-secondary smallBtn trans" value="${ acnt.no }">이체</button>
			 		 	</h3>
			 		 </div>
			 	</div>
			</div>
						
		</c:forEach>
		</div>
		
	</div>
	<div class="blank"></div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>