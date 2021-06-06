<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

td {
	padding: 1%;
}
th {
	padding: 1%;
	background-color: #EFEFEF;
}
</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
function refusalRsn(appNo) {
	/* 
		대출 거절 이유 가져오는 ajax 
	*/
	console.log(appNo)
	$.ajax({
      	url : '${ pageContext.request.contextPath }/corp/refusalRsn',
      	type : 'get',
      	data : {
      		'appNo' : appNo
      	},
      	success : function(reason) {
			$('#refuseReasonModal').modal('show')
			$('.modal-body').append(reason)
      	}, error : function() {
      		alert('실패')
      	}
 	}) 
}
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/header.jsp"/>
		<img src="${ pageContext.request.contextPath }/resources/images/loanAppStatus_banner.jpg"
		style="width: 100%; height: 400px">
		

	<div class="container" id="changeable">
		<h3 class="title"><i class="ni ni-basket" style="color: rgba(64, 146, 143)"></i><br><b>${ userVO.name }의 대출 신청 현황</b></h3>
		<div class="card">
		  <div class="card-body">
		    <h5 style="color: rgba(233, 117, 80)">
		    	<img src="https://img.icons8.com/cute-clipart/30/000000/error.png"/>
		    	<b>주의</b>
		    </h5>
		    <ul>
				<li>신규 임시 대출계좌는 대출 승인 후부터 효력을 갖습니다.</li>
				<li>대출 승인이 기각될경우 신규 임시 대출계좌는 폐기됩니다.</li>
				<li>기존 대출 계좌를 새 대출 계좌로 설정한경우 대출이 기각되어도 해당 계좌를 계속 사용하실 수 있습니다.</li>		    
		    </ul>
		  </div>
		</div>
		<div class="blank"></div>
		<div class="scrollmenu">
			<table class="table">
				<tr>
					<th>대출상품 이름</th>
					<th>신청일</th>
					<th>대출유형</th>
					<th>대출계좌</th>
					<th>이자납부계좌</th>
					<th>신청금액</th>
					<th>대출기간</th>
					<th>담보유형</th>
					<th>지점명</th>
					<th>상태</th>
				</tr>
				<c:forEach items="${ loanAppList }" var="loanApp">
					<tr>
						<td>${ loanApp.prodName }</td>
						<td>${ loanApp.appDate }</td>
						<td>${ loanApp.loanType }</td>
						<td>${ loanApp.loanAcnt }</td>
						<td>${ loanApp.interestAcnt }</td>
						<td><fmt:formatNumber value="${ loanApp.appAmount }" pattern="###,###,###,###" /> 원</td>
						<td>${ loanApp.appMonth }</td>
						<td>${ loanApp.assType }</td>
						<td>${ loanApp.branchNm }</td>
						<td>
						
							<c:if test="${ loanApp.loanAppStatus eq 'FW' }">
								<span style="color: rgba(64, 146, 143)"><b>심사 진행중</b></span>
							</c:if>
							<c:if test="${ loanApp.loanAppStatus eq 'SW' }">
								2차 심사 진행중
							</c:if>
							<c:if test="${ loanApp.loanAppStatus eq 'R' }">
								<a href="javascript:refusalRsn(${ loanApp.appNo })"><b>거절사유보기</b></a>
							</c:if>
							<c:if test="${ loanApp.loanAppStatus eq 'C' }">
								<span style="color: rgba(62, 64, 69)"><b>승인</b></span>
							</c:if>
								
						
						<td>
						<%-- <td>${ loanApp.loanAppStatus }</td> --%>

					</tr>
				</c:forEach>
			</table>
		  
		</div>
	</div>
	
	
	<div class="modal" id="refuseReasonModal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">대출 거절 사유</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />
</body>
</html>