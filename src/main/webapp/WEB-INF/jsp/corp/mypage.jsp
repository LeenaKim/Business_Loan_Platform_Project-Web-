<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
/* .card {
	width: 300px;
	height: 300px;
} */
.table {
	font-size: 12px;
}
span {
	width: 150%;
	font-size: 15px;
	color: #3F403F
}
.variables {
	width: 100%;
	margin: 6%;
	font-size: 13px;
	color: gray;
}

#update {
	background-color: #f57102;
	border: none;
}
td {
	padding: 1%;
}
th {
	padding: 1%;
	background-color: #EFEFEF;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function() {
	/* 
		세무사 인증 
	*/
	$('.confirmAccNoBtn').click(function() {
		let accNo = $(this).val()
		$.ajax({
			url : '${ pageContext.request.contextPath }/corp/authConfirm',
			type: 'post',
			data : {
				accNo : accNo
			},
			success : function(data) {
				location.reload();
				$('#authAccModal').modal('hide');
				
			}, error : function() {
				alert('실패')
			}
		}) 
	})
	
	/* 
		세무사 삭제 
	*/
	$('.deleteAccNoBtn').click(function() {
		let accNo = $(this).val()
		console.log('accNo : ' + accNo)
		$.ajax({
			url : '${ pageContext.request.contextPath }/corp/authDelete',
			type: 'post',
			data : {
				accNo : accNo
			},
			success : function(data) {
				location.reload();
				$('#authAccModal').modal('hide');
			}, error : function() {
				alert('실패')
			}
		}) 
	})
})


</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<!-- 세무사 인증 모달  -->
<div class="modal" id="authAccModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">세무사 인증</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <p class="subtitle">인증을 요청한 세무사 목록</p>
        <table class="table">
			<tr>
				<th>세무사등록번호</th>
				<th>세무사이름</th>
				<th>인증요청일</th>
				<th></th>
			</tr>
			<c:forEach items="${ authList }" var="auth" varStatus="loop">
			<tr>
				<td>${ auth.accNo }</td>
				<td>${ auth.name }</td>
				<td>${ auth.authReqDate }</td>
				<td><button class="btn btn-secondary smallBtn confirmAccNoBtn" value="${ auth.accNo }">인증</button></td>
			</tr>
			</c:forEach>
		</table>	
      <p class="subtitle">인증 완료된 세무사 목록</p>
        <table class="table">
			<tr>
				<th>세무사등록번호</th>
				<th>세무사이름</th>
				<th></th>
			</tr>
			<c:forEach items="${ accountantList }" var="acc" varStatus="loop">
				<tr>
					<td>${ acc.accNo }</td>
					<td>${ acc.name }</td>
					<td><button class="btn btn-secondary smallBtn deleteAccNoBtn" value="${ acc.accNo }">삭제</button></td>
				</tr>
			</c:forEach>
		</table>	
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>



	<jsp:include page="../include/header.jsp"/>
	
	<img src="${ pageContext.request.contextPath }/resources/images/mypage_banner.jpg"
	style="width: 100%; height: 450px">
	
	<div class="container" id="changeable">
		<h3 class="title"><i class="ni ni-single-02" style="color: rgba(64, 146, 143)"></i><br><b>${ userVO.name }님,<br>오늘도 화이팅!</b></h3>
		<hr>
		
		<div class="row">
			<div class="col-lg-4" style="border-right: 1px solid #ccc;">
				<h4 class="subtitle">기업 프로필</h4>
				<button class="btn btn-primary smallBtn" value="" data-toggle="modal" data-target="#authAccModal" >세무사 인증</button>
				<a href="${ pageContext.request.contextPath }/corp/update"><button class="btn btn-secondary smallBtn" id="update" value="">업데이트</button></a>
			</div>

			<div class="col-lg-4">
					<div class="variables">
						사업자등록번호<br>
						<span>${ userVO.bizrNo }</span><br>
					</div>
					<div class="variables">
						법인등록번호<br>
						<span>${ userVO.jurirNo }</span><br>
					</div>
					<div class="variables">
						기업체명<br>
						<span>${ userVO.name }</span><br>
					</div>
					<div class="variables">
						기업체영문명<br>
						<span>${ userVO.nameEng }</span><br>
					</div>
					<div class="variables">
						대표자<br>
						<c:if test="${ not empty repList }">
						<c:forEach items="${ repList }" var="rep" varStatus="loop">
							<c:if test="${ loop.count ne 1 }">
								,
							</c:if>
							<span>${ rep.repName }</span>
						</c:forEach><br>
						</c:if>
					</div>
					<div class="variables">
						기장세무사<br>
						<c:forEach items="${ accountantList }" var="accountant" varStatus="loop">
						<c:if test="${ loop.count ne 1 }">
							,
						</c:if>
						<span>${ accountant.name }</span>
						</c:forEach><br>
					</div>
					<div class="variables">
						법인구분<br>
						<span>
						<c:if test="${ userVO.corpCls eq 'Y' }">
							유가증권시장 
						</c:if>
						<c:if test="${ userVO.corpCls eq 'K' }">
							코스닥시장
						</c:if>
						<c:if test="${ userVO.corpCls eq 'N' }">
							코넥스시장 
						</c:if>
						<c:if test="${ userVO.corpCls eq 'E' }">
							기타 
						</c:if>
						</span><br>
					</div>
				
			</div>
			<div class="col-lg-4">
					<div class="variables">
						업종<br>
						<span>${ userVO.indutyCode }</span><br>
					</div>
					<div class="variables">
						결재월<br>
						<span>${ userVO.accMt }월</span><br>
					</div>
					<div class="variables">
						주소<br>
						<span>${ userVO.adres }</span><br>
					</div>
					<div class="variables">
						홈페이지<br>
						<span>http://www.${ userVO.hmUrl }</span><br>
					</div>
					<div class="variables">
						팩스번호<br>
						<span>${ userVO.countryCodeFax })&nbsp;&nbsp;${ userVO.faxNo }</span><br>
					</div>
					<div class="variables">
						전화번호<br>
						<span>${ userVO.countryCode })&nbsp;&nbsp;${ userVO.phnNo }</span><br>
					</div>
					<div class="variables">
						설립일<br>
						<span>${ userVO.estDt }</span><br>
					</div>
			</div>
			
		</div>	 
		
		<hr>
		<h4 class="subtitle">나의 대출</h4><div class="sub-blank"></div>
		<div class="row">
		<div class="col-lg-3">
		<div class="card" style="position: relative" >
		  <div class="card-body">
		    <h5 class="card-title">대출 신청 현황</h5>
		    <p class="card-text">
		    	<c:forEach items="${ loanAppList }" var="loanApp" varStatus="loop">
		    		<c:if test="${ loop.last }">
		    			'${ loanApp.prodName }' 포함 <span style="color: #fd7e14m; font-weight: bold"> ${ loop.count }</span>건<br>
		    			신청일 : ${ loanApp.appDate }<br>
		    			상태 : 
		    			<c:choose>
			    			<c:when test="${ loanApp.loanAppStatus eq 'FW' }">
		    				<span style="color: #fd7e14; font-weight: bold">
			    				심사중
			    			</span>
			    			</c:when>
			    			<c:when test="${ loanApp.loanAppStatus eq 'C' }">
			    			<span style="color: #fd7e14; font-weight: bold">
			    				승인
			    			</span>
			    			</c:when>
			    			<c:otherwise>
			    			<span style="color: #fd7e14; font-weight: bold">
			    				기각
			    			</span>
			    			</c:otherwise>
		    			</c:choose>
		    		</c:if>
		    	</c:forEach>
		    </p>
		    <a href="${ pageContext.request.contextPath }/corp/loanAppStatus" class="btn btn-primary">신청 현황</a>
		  </div>
		</div>
		</div>
		
		<div class="col-lg-3">
		<div class="card" style="position: relative" >
		  <div class="card-body">
		    <h5 class="card-title">대출 내역</h5>
		    <p class="card-text">
		    	<c:forEach items="${ loanHisList }" var="loanHis" varStatus="loop">
		    		<!-- 대출 원금 총합 -->
		    		<c:set var="oriLoanAmtSum" value="${ oriLoanAmtSum + loanHis.pcplAmt }"/>
		    		<!-- 대출 잔금 총합 -->
		    		<c:set var="leftLoanAmtSum" value="${ leftLoanAmtSum + loanHis.leftAmt }"/>
		    		<!-- 대출 상환금 총합 -->
		    		<c:if test="${ loop.last }">
		    			'${ loanHis.prodName }' 포함 <span style="color: #fd7e14m; font-weight: bold"> ${ loop.count }</span>건<br>
		    			시작일 : ${ loanHis.startDate }<br>
		    			상태 : 
		    			<c:choose>
			    			<c:when test="${ loanHis.loanStatus eq 'I' }">
		    				<span style="color: #fd7e14; font-weight: bold">
			    				진행중
			    			</span>
			    			</c:when>
			    			<c:otherwise>
			    			<span style="color: #fd7e14; font-weight: bold">
			    				상환 완료
			    			</span>
			    			</c:otherwise>
		    			</c:choose>
		    		</c:if>
		    	</c:forEach>
		    </p>
		    <a href="${ pageContext.request.contextPath }/corp/loanHistory" class="btn btn-primary">대출 내역</a>
		  </div>
		 </div>
		</div>
		
		<div class="col-lg-3">
		<div class="card" style="position: relative" >
		  <div class="card-body">
		    <h5 class="card-title">대출 잔액</h5>
		    <p class="card-text">
		    	원금 : <b><fmt:formatNumber value="${ oriLoanAmtSum }" pattern="###,###,###,###" /></b> 원<br>
		    	잔금 : <b><fmt:formatNumber value="${ leftLoanAmtSum }" pattern="###,###,###,###" /></b> 원<br>
		    </p>
		    <a href="${ pageContext.request.contextPath }/corp/" class="btn btn-primary">상환 내역</a>
		  </div>
		</div>
		</div>
		
		<div class="col-lg-3">
		<div class="card" style="position: relative" >
		  <div class="card-body">
		    <h5 class="card-title">서류 보관함</h5>
		    <p class="card-text">
		    	<c:forEach items="${ docList }" var="doc" varStatus="loop">
		    	<c:if test="${ loop.last }">
		    		${ doc.docType }&nbsp;&nbsp;${ doc.docOriName } 포함 <span style="color: #fd7e14m; font-weight: bold"> ${ loop.count }</span>건<br>
		    	</c:if>
		    	</c:forEach>
		    </p>
		    <a href="${ pageContext.request.contextPath }/corp/docUpload" class="btn btn-primary">서류 보관함</a>
		  </div>
		</div>
		</div>
	</div>
	
	</div>
	<div class="blank"></div>
	<div class="blank"></div>
	<div class="blank"></div>

	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>