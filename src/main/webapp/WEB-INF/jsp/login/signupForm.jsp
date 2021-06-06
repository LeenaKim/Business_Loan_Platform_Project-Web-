<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
@import url(https://fonts.googleapis.com/css?family=Open+Sans);
.boxes {
  margin: auto;
  padding: 3%;
}  

/*Checkboxes styles*/
input[type="checkbox"] { display: none; }

input[type="checkbox"] + label {
  display: inline;
  position: relative;
  padding-left: 20%;
  font: 14px/20px 'Open Sans', Arial, sans-serif;
  color: gray;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
}

input[name="ttlAgr"] + label {
	padding-left: 8%;
}

input[type="checkbox"] + label:last-child { margin-bottom: 0; }

input[type="checkbox"] + label:before {
  content: '';
  display: block;
  width: 20px;
  height: 20px;
  border: 1px solid rgba(64, 146, 143);
  position: absolute;
  left: 0;
  top: 0;
  opacity: .6;
  -webkit-transition: all .12s, border-color .08s;
  transition: all .12s, border-color .08s;
}

input[type="checkbox"]:checked + label:before {
  width: 10px;
  top: -5px;
  left: 5px;
  border-radius: 0;
  opacity: 1;
  border-top-color: transparent;
  border-left-color: transparent;
  -webkit-transform: rotate(45deg);
  transform: rotate(45deg);
}

#signUpDiv {
	text-align: left;
	font-size: 16px;
}

</style>
<link href="resources/css/progress-wizard.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script> 
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<script>
$(document).ready(function() {
	
	
	// 전송된 인증번호를 저장하는 변수 
	let authNumReal;
	
	/* 
		인증번호 요청 버튼 클릭시 인증번호 전송 ajax
	*/
	$('#authSubmit').click(function() {
		let phnNo = document.signForm.phnNo.value;
		console.log(phnNo)
		$.ajax({
			url : '${ pageContext.request.contextPath }/signup/auth',
			type: 'get',
			data : {
				phnNo : phnNo
			},
			success : function(data) {
				authNumReal = data;
			}, error : function() {
				alert('실패')
			}
		})
	})
	/* 
		인증번호 확인 버튼 클릭시 저장해놨던 authNumReal과 비교하여 인증 성공/실패여부 판단 
	*/
	$('#authConfirm').click(function() {
		let authNum = document.signForm.authNum.value;
		if(authNum == authNumReal){
			/* $('#auth').hide();
			$('#corpReg').show(); */
			location.href="${ pageContext.request.contextPath }/signupForm2"
		} else {
			$('#authChk').empty();
			$('#authChk').append('인증번호가 일치하지 않습니다.');
		}
	})
	/* 
		핸드폰번호 입력시 하이픈 제거 
	*/
	$('.onlyNum').keyup(function() {
		var val = $(this).val();
		console.log($(this))
		console.log($(this).val())
		var pattern = /[^(0-9)]/gi;  
		if(pattern.test(val)){
			/* $('.msg').css('color', 'red'); */
			/* $(this).append('<span style="color: red">숫자만 입력가능합니다.</span>') */
			$(this).val(val.replace(pattern,""));
		}
		
	})
})
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">

	<jsp:include page="../include/header.jsp"/>
	<div class="container" id="changeable">
		<!------------------------ 진행바 ------------------------>
        <div class="sub-blank"></div>
        <ul class="progress-indicator">
		  <li class="completed"> <span class="bubble"></span>본인인증</li>
		  <li> <span class="bubble"></span>사업자정보 입력</li>
		  <li> <span class="bubble"></span> 가입 완료!</li>
		</ul>
        <div class="sub-blank"></div>

 
		<!------------------------ 본인확인 ------------------------>
		<div class="signUpProcedure" id="auth">
		
		<h3 class="title">회원가입</h3>
		<div class="card text-center" style="width: 100%;">
		  <div class="card-body">
		    <h5 class="card-title">회원 가입을 위해서는 고객님의<br><b>본인확인</b>이 필요합니다.</h5>
		    <p>본인명의가 아닐경우 인증이 이루어지지 않습니다.</p>
		    <div class="card" style="background-color: rgba(64, 146, 143, 0.1);">
			  <div class="card-body">
			    <p>관련법률 및 규정에 따라 아래 사항에 대한 동의가 필요합니다.</p>
			    <div class="boxes">
			    <table class="table">
			    	<tr>
			    		<td>
						  <input type="checkbox" id="box-1">
						  <label for="box-1">개인정보이용 및 제공 동의</label>
			    		</td>
			    		<td>
						  <input type="checkbox" id="box-2">
						  <label for="box-2">통신사이용약관 동의</label><br>
			    		</td>
			    	</tr>
			    	<tr>
			    		<td>
						  <input type="checkbox" id="box-3">
						  <label for="box-3">고객식별정보처리 동의</label>
			    		</td>
			    		<td>
						  <input type="checkbox" id="box-4">
						  <label for="box-4">서비스이용약관 동의</label>
			    		</td>
			    	</tr>
			    </table>
			    <input type="checkbox" id="box-0" name="ttlAgr">
				<label for="box-0">전체동의</label>
				</div>
			  </div>
			</div>
			
			<div class="blank"></div>
			<form name="signForm" method="post">
				<span style="font-size: 16px">전화번호</span>
				<input type="text" id="phnNo" class="onlyNum" name="phnNo" placeholder="'-' 제외">
				<input type="button" class="btn btn-secondary" id="authSubmit" value="전송"><br>
				<br>
				<span style="font-size: 16px">인증번호</span>
				<input type="text" id="authNum" placeholder="인증번호 입력">
				<input type="button" class="btn btn-primary" id="authConfirm" value="확인">
				<div class="msg" id="authChk"></div>
			</form>
		  </div>
		</div>
		
		</div>
		<div class="blank"></div>
		
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>