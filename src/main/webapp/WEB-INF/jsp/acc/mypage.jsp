<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
%>
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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function() {
	/* 
		기업 인증 요청 보내기 
	*/
	$('#requestBtn').click(function() {
		let bizrNo = $('#addCorpModal input[type=text]').val()
		
		$.ajax({
			url : '${ pageContext.request.contextPath }/acc/auth',
			type: 'post',
			data : {
				bizrNo : bizrNo
			},
			success : function(data) {
				$('#addCorpModal').modal('hide')
				
				$('body').removeClass('modal-open');
				$('.modal-backdrop').remove();
				$('#afterAddCorpModal').modal('show')	
			}, error : function() {
				alert('실패')
			}
		}) 
	})
})
/* 
	세무사가 요청한 모든 인증요청 불러오기 
function getAllAuthListWaiting() {
	$.ajax({
		url : '${ pageContext.request.contextPath }/acc/getAuthWaitingList',
		type: 'get',
		success : function(data) {
			
		}, error : function() {
			alert('실패')
		}
	}) 
}
*/

</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<!-- 기업 추가 모달 -->
<div class="modal" id="addCorpModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">기업에게 담당 세무사 인증 요청을 보냅니다.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table">
        	<tr>
        		<th>사업자등록번호</th>
        		<td><input type="text" name="bizrNo"></td>
        	</tr>
        	<tr>
        		<th>세무사등록번호</th>
        		<td>${ accVO.accNo }</td>
        	</tr>
        	<tr>
        		<th>인증요청일</th>
        		<td><%= sf.format(nowTime) %></td>
        	</tr>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="requestBtn">요청</button>
      </div>
    </div>
  </div>
</div>
<!-- 인증요청 후의 모달  -->
<div class="modal" id="afterAddCorpModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">인증 요청을 완료했습니다.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>기업의 상황에 따라 인증에 시간이 걸릴 수 있습니다.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>


	<jsp:include page="../include/header.jsp"/>
	<div class="container" id="changeable">
		<h3 class="title"><i class="ni ni-single-02" style="color: rgba(64, 146, 143)"></i><br>${ accVO.name }님,<br>오늘도 화이팅!</h3>
		<hr>
		
		<div class="row">
			<div class="col-lg-4" style="border-right: 1px solid #ccc;">
				<h4 class="subtitle">세무사 프로필</h4>
				<a href="${ pageContext.request.contextPath }/acc/update"><button class="btn btn-secondary smallBtn" id="update" value="">업데이트</button></a>
				<div class="blank"></div>
			</div>

			<div class="col-lg-4">
					<div class="variables">
						세무사등록번호<br>
						<span>${ accVO.accNo }</span><br>
					</div>
					<div class="variables">
						이름<br>
						<span>${ accVO.name }</span><br>
					</div>
					<div class="variables">
						전화번호<br>
						<span>${ accVO.phone }</span><br>
					</div>
				
			</div>
			
			
		</div>	 
		
		
		<!-- 내가담당하는 기업 -->
		<hr>
		<h4 class="subtitle">내가 담당하고있는 기업<button class="btn btn-primary" data-toggle="modal" data-target="#addCorpModal" style="float: right">+ 새 담당기업 추가</button></h4>
		<br>
		<div class="sub-blank"></div>
		
		<div class="row" id="cardList">
		<c:forEach items="${ corpList }" var="corp" varStatus="loop">
		
			<div class="col">
				<div class="card" style="width: 21rem; height: 11rem; margin: 3%;" >
					<h5 class="card-header">${ corp.bizrNo }</h5>
			 		 <div class="card-body">
			 		 	<h3 class="card-text" style="text-align: center;">
			 		 		&nbsp;${ corp.name }<br>
				 		 	<button class="btn btn-secondary smallBtn view" value="${ corp.bizrNo }">기업정보</button>
				 		 	<a href="${ pageContext.request.contextPath }/acc/docUpload/${ corp.bizrNo }"><button class="btn btn-secondary smallBtn trans" value="${ corp.bizrNo }">서류보관함</button></a>
			 		 	</h3>
			 		 </div>
			 	</div>
			</div>
						
		</c:forEach>
		
		</div>
		
		
		<!-- 인증 대기중인 기업 -->
		<hr>
		<h4 class="subtitle">인증 대기중인 기업</h4>
		<br>
		<div class="sub-blank"></div>
		
		<div class="row" id="authList">
			<table class="table">
				<tr>
					<th>사업자번호</th>
					<th>회사이름</th>
					<th>인증요청일</th>
					<th>인증상태</th>
				</tr>
				<c:forEach items="${ authList }" var="auth" varStatus="loop">
				<tr>
					<td>${ auth.bizrNo }</td>
					<td>${ auth.name }</td>
					<td>${ auth.authReqDate }</td>
					<td>인증대기중</td>
				</tr>
				</c:forEach>
			</table>				
		
		</div>
		
		
	
	</div>
	<div class="blank"></div>
	<div class="blank"></div>
	<div class="blank"></div>

	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>