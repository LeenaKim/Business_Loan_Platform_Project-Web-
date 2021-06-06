<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상환내역</title>
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
</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script>
$(document).ready(function() {
	/* 
		잔액 확인 ajax 
	*/
	$('#chkBalance').click(function() {
		$.ajax({
	      	url : '${ pageContext.request.contextPath }/corp/chkBalance',
	      	type : 'get',
	      	data : {
	      		'no' : ${ loanHis.loanAcnt }
	      	},
	      	success : function(result) {
	      		$('#chkBalanceRst').empty()
	      		$('#chkBalanceRst').append('<br>잔액 : <span style="color: rgba(64, 146, 143)">' + result + '</span>원');
	      	}, error : function() {
	      		alert('실패')
	      	}
	      })
	}) 
	/* 
		중도상환수수료 체크 ajax 
	*/
	$('#chkRpyFee').click(function(){
	  
		let midRpyAmt = document.rpyForm.midRpyAmt.value;
		
		if(midRpyAmt == '') {
			alert('상환금액을 입력하세요.');
			return;						
		}
		
		$.ajax({
	      	url : '${ pageContext.request.contextPath }/corp/chkRpyFee',
	      	type : 'get',
	      	/* contentType : false,
	      	processData : false, */
	      	data : {
	      		'loanNo' : ${ loanHis.loanNo },
	      		'midRpyAmt' : midRpyAmt
	      	},
	      	success : function(result) {
	      		$('#chkFeeRst').empty()
	      		$('#chkFeeRst').html('<br>중도상환수수료는 <span style="color: rgba(64, 146, 143)">' + result + '</span>원입니다.');
	      	}, error : function() {
	      		alert('실패')
	      	}
	      })
	})
	

})
	function pwChk() {
		let rpyForm = document.rpyForm
		let pw = document.pwForm.password.value;
		if(pw != '${ userVO.pw }'){
			$('.form-group').append('<span style="color: red">비밀번호가 일치하지 않습니다.</span>')
		} else {
			rpyForm.submit();
		}
	
	}
	/* 
		상환 전 잔액체크 및 널체크 
	*/
	function chkData() {
		let flag = true;
		let midRpyAmt = document.rpyForm.midRpyAmt.value;
		// null 값 체크 
		if(midRpyAmt == ''){
			alert('상환금액을 입력하세요.');
			$('#pwConfirm').modal('hide')
			flag = false;
		}
		// 비밀번호 체크 
		
		$.ajax({
		     url : '${ pageContext.request.contextPath }/corp/chkBalance',
		     type : 'get',
		     data : {
		      	'no' : ${ loanHis.loanAcnt }
		      },
		      async: false,
		      success : function(result) {
		    	  if(Number(result) < Number(midRpyAmt)){
		    		  alert('잔액이 부족합니다.')
		    		  document.rpyForm.midRpyAmt.value = '';
		    		  flag = false;
		    	  } 
		      }, error : function() {
		      	alert('실패')
		      }
		     })
		     
		if(flag) {
			$(document).ready(function() {
				$('#pwConfirm').modal('show')
			})
		}
		return flag; 
	}

</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/header.jsp"/>
		<div class="container" id="changeable">
		<h3 class="title"><b>대출상환</b></h3>
		
		<div class="card">
		  <div class="card-body">
		    <h5 style="color: rgba(233, 117, 80)">
		    	<img src="https://img.icons8.com/cute-clipart/30/000000/error.png"/>
		    <b>주의</b>
		    </h5>
		    <ul>
		    	<li>중도상환수수료가 있는 대출의 경우 가입시 수수료가 자동으로 계산됩니다.</li>
		    	<li>중도상환수수료가 있는 대출의 경우 상환금액에서 수수료를 제외한 금액만 상환됩니다.</li>
		    	<li>상환금은 대출계좌에서 인출됩니다. 잔액이 부족할경우 인출되지 않으며, 해당 계좌에 상환금을 입금한 후 상환 서비스를 이용하시길 바랍니다.</li>
		    </ul>
		  </div>
		</div>
		
		<h5 class="subtitle">상환</h5>
		
		<form action="${ pageContext.request.contextPath }/corp/repay" name="rpyForm" method="post" onsubmit="return chkData()">
		<input type="hidden" value="${ loanHis.loanNo }" name="loanNo">
		<input type="hidden" value="${ loanHis.loanAcnt }" name="loanAcnt">
		<table class="table">
			<tr>
				<th>상환금액</th>
				<td>
					<input type="text" name="midRpyAmt"> 원
		 	 	 	<button type="button" class="btn-secondary" id="chkRpyFee" style="float:right">수수료 계산</button>
		 	 		<span id="chkFeeRst"></span>
		 	 	</td>
			</tr>
			<tr>
				<th>출금계좌</th>
				<td>${ loanHis.loanAcnt }&nbsp;&nbsp;
					<button type="button" class="btn-secondary" id="chkBalance" style="float:right">잔액확인</button>
					<span id="chkBalanceRst"></span>
				</td>
			</tr>
		</table>
		
		<div style="text-align: center">
		   <button type="submit" class="btn btn-primary" id="repay" data-toggle="modal" data-target="#exampleModal">상환</button>
		</div>
		</form>
				
				
				
		<h5 class="subtitle">상환내역</h5>
		<p><span style="color: rgba(64, 146, 143)">${ loanAcnt }</span> 대출에 대한 상환내역입니다.</p>
		<!-- 상환누계금액 및 잔금 계산 -->
		<c:forEach items="${ rpyHisList }" var="rpyHis" varStatus="loop">
			<c:set var= "rpyAmtSum" value="${rpyAmtSum + rpyHis.midRpyAmt}"/>
			<c:set var= "rpyFeeSum" value="${rpyFeeSum + rpyHis.midRpyFee}"/>
			<%-- <c:if test="${ loop.first }">
				<c:set var="leftAmt" value="${ rpyHis.balance }"/>
			</c:if> --%>
		</c:forEach>
		
		<table class="table">
			<tr>
				<th style="width: 20%">상환누계금액</th>
				<td><fmt:formatNumber value="${ rpyAmtSum - rpyFeeSum }" pattern="###,###,###,###" /> 원</td>
				<th style="width: 20%">잔금</th>
				<td><fmt:formatNumber value="${ loanHis.leftAmt }" pattern="###,###,###,###" /> 원</td>
			</tr>
		</table>
		
		<div class="blank"></div>
		<div class="scrollmenu">
		<table class="table">
			<tr>
				<th>번호</th>
				<th>상환일</th>
				<th>상환금액</th>
				<th>중도상환수수료</th>
				<th>잔금</th>
			</tr>
			<c:forEach items="${ rpyHisList }" var="rpyHis" varStatus="loop">
				<tr>
					<td>${ loop.count }</td>
					<td>${ rpyHis.midRpyDate }</td>
					<td><fmt:formatNumber value="${ rpyHis.midRpyAmt }" pattern="###,###,###,###" /> 원</td>
					<td><fmt:formatNumber value="${ rpyHis.midRpyFee }" pattern="###,###,###,###" /> 원</td>
					<td><fmt:formatNumber value="${ rpyHis.balance }" pattern="###,###,###,###" /> 원</td>
				</tr>
			</c:forEach>
		</table>
		</div>
		
		<div class="blank"></div>
		
		<!------------------------------------ modal ------------------------------------>

		
		
		<!-- Modal -->
		<div class="modal" id="pwConfirm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">대출상환</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          			<span aria-hidden="true">&times;</span>
        		</button>
		      </div>
		      <div class="modal-body">
		      	<form name="pwForm">
		          <div class="form-group">
		            <label for="recipient-name" class="col-form-label">비밀번호를 입력하세요. </label>
		            <input type="password" class="form-control" name="password">
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary" id="confirm" onclick="pwChk()">확인</button>
		      </div>
		    </div>
		  </div>
		</div>
	
	
	
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>	
