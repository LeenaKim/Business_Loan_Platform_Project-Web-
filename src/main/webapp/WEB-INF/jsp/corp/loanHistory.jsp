<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출 내역</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
td {
	padding: 1%;
}
th {
	padding: 1%;
	background-color: #EFEFEF;
}
div.scrollmenu {
  overflow: auto; 
  white-space: nowrap;
}
.complete {
	display: none;
}
</style>
<link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
<script>
/* 
	대출금 상환페이지로 이동 
*/
$(document).ready(function() {
	$('#repay').click(function() {
		var loanNo = $('input:radio[name="loanHisRadio"]:checked').val();

		if(loanNo == null){
			alert('상환하려는 대출을 선택하세요.')
			return;
		}
		location.href = '${ pageContext.request.contextPath }/corp/repay/' + loanNo;
	})
	
})

/* 
	진행중 / 완료 대출 보는 토글버튼 
*/
function changeStatus() {
	// 완료된 대출만, 진행중인 대출만 보이기 
	if(!$(this).is(':checked')){
		$('.ing').toggle()
		$('.complete').toggle()
	} 
}
		
	
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/header.jsp"/>

	<img src="${ pageContext.request.contextPath }/resources/images/loanHistory_banner.png"
	style="width: 100%; height: 450px">
	
	<div class="container" id="changeable">
		<h3 class="title"><i class="ni ni-single-copy-04" style="color: rgba(64, 146, 143)"></i><br><b>${ userVO.name }의 대출 내역</b></h3>
		<p>대출계좌를 클릭하시면 상환 내역이 출력됩니다.</p>
		<!-- 총 원금, 잔액 계산 -->
		<c:forEach items="${ loanHistoryList }" var="loanHis">
			<c:set var= "loanPcplAmtSum" value="${loanPcplAmtSum + loanHis.pcplAmt}"/>
			<c:set var= "loanLeftAmtSum" value="${loanLeftAmtSum + loanHis.leftAmt}"/>
		</c:forEach>
		
		<table class="table">
			<tr>
				<th style="width: 20%">대출원금합계</th>
				<td><fmt:formatNumber value="${ loanPcplAmtSum }" pattern="###,###,###,###" /> 원</td>
				<th style="width: 20%">대출잔금합계</th>
				<td><fmt:formatNumber value="${ loanLeftAmtSum }" pattern="###,###,###,###" /> 원</td>
			</tr>
		</table>
		<div class="blank"></div>
		
		<div>
			<input type="checkbox" onchange="changeStatus()" checked data-toggle="toggle" id="loanStatusChk" data-on="진행중" data-off="완료">
		   	<button style="float: right" type="button" class="btn btn-secondary" id="repay">대출금상환</button>
		</div>
		<div class="sub-blank"></div>
		<p>대출금 상환은 현재 진행중인 대출만 가능합니다.</p>
		<div class="scrollmenu">
			<table class="table">
				<tr>
					<th></th>
					<th>대출상품</th>
					<th>대출계좌</th>
					<th>대출구분</th>
					<th>시작일</th>
					<th>만기일</th>
					<th>상환률</th>
					<th>잔금</th>
					<th>원금</th>
					<th>금리</th>
					<th>이자 납부 계좌</th>
					<th>이자 납부일</th>
					<th>담보 유형</th>
					<th>이자</th>
				</tr>
				<c:forEach items="${ loanHistoryList }" var="loanHis">
					<c:if test="${ loanHis.loanStatus eq 'I' }">
					<tr class="ing">
					
						<td><input type="radio" value="${ loanHis.loanNo }" name="loanHisRadio"></td>
						<td>${ loanHis.prodName }</td>
						<td>${ loanHis.loanAcnt }</td>
						<td>${ loanHis.loanType }</td>
						<td>${ loanHis.startDate }</td>
						<td>${ loanHis.finDate }</td>
						<td>${ loanHis.rpyRate } %</td>
						<td><fmt:formatNumber value="${ loanHis.leftAmt }" pattern="###,###,###,###" /> 원</td>
						<td><fmt:formatNumber value="${ loanHis.pcplAmt }" pattern="###,###,###,###" /> 원</td>
						<td>${ loanHis.interest } %</td>
						<td>${ loanHis.interestAcnt }</td>
						<td>매달 ${ loanHis.interestDate }일</td>
						<td>${ loanHis.assType }</td>
						<td><fmt:formatNumber value="${ loanHis.interestAmt }" pattern="###,###,###,###" /> 원</td>
					</tr>
					</c:if>
					<c:if test="${ loanHis.loanStatus eq 'C' }">
					<tr class="complete">
						<td><input type="radio" value="${ loanHis.loanNo }" disabled name="loanHisRadio"></td>
						<td>${ loanHis.prodName }</td>
						<td>${ loanHis.loanAcnt }</td>
						<td>${ loanHis.loanType }</td>
						<td>${ loanHis.startDate }</td>
						<td>${ loanHis.finDate }</td>
						<td>${ loanHis.rpyRate } %</td>
						<td><fmt:formatNumber value="${ loanHis.leftAmt }" pattern="###,###,###,###" /> 원</td>
						<td><fmt:formatNumber value="${ loanHis.pcplAmt }" pattern="###,###,###,###" /> 원</td>
						<td>${ loanHis.interest } %</td>
						<td>${ loanHis.interestAcnt }</td>
						<td>매달 ${ loanHis.interestDate }일</td>
						<td>${ loanHis.assType }</td>
						<td><fmt:formatNumber value="${ loanHis.interestAmt }" pattern="###,###,###,###" /> 원</td>
					</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
		
		<div id="rpyHisTable"></div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>