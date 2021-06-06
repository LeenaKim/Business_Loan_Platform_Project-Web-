<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일업로드</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<script src ="http://code.jquery.com/jquery-3.5.1.min.js "></script> 
<style>

</style>
<script>
function checkExt(obj){
	let allowName = ['pdf', 'jpg', 'jpeg', 'xlsx', 'png'];
	let fileName = obj.value;
	console.log(fileName)
	let ext = fileName.substring(fileName.lastIndexOf('.')+1);
	ext = ext.toLowerCase();
	console.log('확장자 : ' + ext)
	for(let i = 0; i < allowName.length; i++){
		if(allowName[i] == ext){
			return true;
		}
	}
	alert('[ ' + ext + ' ] 확장자는 파일 정책에 위배됩니다.')
	obj.value='';
	return false;
}

function getDocList() {
	// 해당 게시물의 서류리스트 조회 => <div id="docList"></div> 조회데이터 업데이트 
	$.ajax({
		url : '${ pageContext.request.contextPath }/corp/doc',
		type: 'get',
		success : function(data) {
			
			$('#docList').empty();
			
			let list = JSON.parse(data)
			
			$(list).each(function() {
				console.log(this)
				
				let str = '';
				str += '<hr>';
				str += this.docType + '&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="dwAtag" id="dw' + this.docNo + '">' + this.docOriName + '(' + this.docSize + ' bytes)</a>';
				str += '&nbsp;&nbsp;&nbsp;&nbsp;' 
				str += '<button class="delBtn btn" id=' + this.docNo + ' style="float:right">삭제</button>'
				
				$('#docList').append(str);
			})
		}, error : function() {
			alert('실패')
		}
	})
}

/**
 * 서류 저장 
 */
 
$(document).ready(function(){
    $('#docUpload').click(function(){
    	
		
    	let form = document.docForm;
    	
    	/* 필수 입력값 체크 */
    	if(form.docType.value == 'default'){
			alert('서류 종류를 선택하세요.')    		
    		return;
    	}
    	if(form.issueDate.value == ""){
			alert('발급 일자를 선택하세요.')    		
    		return;
    	}
    	if(form.doc.value == ""){
			alert('파일을 첨부하세요.')    		
    		return;
    	}
    	/* 허용된 확장자가 아니면 함수를 빠져나옴 */
    	if(!checkExt(form.doc))
    		return;
    	
    	let formData = new FormData(form);
    	formData.append("fileObj", $("#fileTag")[0].files[0]);

    	formData.append("docType", form.docType.value)
    	formData.append("issueDate", form.issueDate.value)
    	
      $.ajax({
      	url : '${ pageContext.request.contextPath }/corp/doc',
      	type : 'post',
      	contentType : false,
      	processData : false,
      	data : formData,
      	success : function(answer) {
      		console.log(answer)
      		if(answer == '"no"'){
      			alert('표준 재무제표 양식을 따라주세요.')
      		} 
      		getDocList(); 
      		document.docForm.docType.value = 'default';
      		document.docForm.issueDate.value = '';
      		document.docForm.doc.value = '';
      	}, error : function() {
      		alert('실패')
      	}
      })
    })
    
 })
 
 
 /* 화면 시작시 댓글이 모두 보이도록 */
 $(document).ready(function() {
	 getDocList();
 })
 
 /* 서류 삭제  */
 /* 동적으로 만든 버튼이니 on 이벤트 추가  */
 
 $(document).ready(function() {
	   $(document).on('click', '.delBtn', function() {
		   
		   if(!confirm('서류를 보관함에서 삭제하시겠습니까?')) return;
		   
		   let docNo = $(this).attr('id');
		   
		   $.ajax({
			   url : '${ pageContext.request.contextPath }/corp/doc/' + docNo,
			   type : 'delete',
			   success : function() {
				   getDocList();
			   }, error : function() {
				   alert('실패')
			   }
		   })
	   })
 }) 
 /* 파일 다운로드 */
 $(document).ready(function() {
	 $(document).on('click', '.dwAtag', function() {
		 
		 let id = $(this).attr('id');
		 let docNo = id.substring(2);
		 location.href = '${ pageContext.request.contextPath }/corp/doc/' + docNo;
		 
	 })
 })
 /* 재무제표 양식 다운로드 */
 $(document).ready(function() {
	
	$('#finDownload').click(function() {
		 location.href = '${ pageContext.request.contextPath }/corp/doc/finDownload';		 		
	})	 
	 
 })
 
</script>

</head>
<body data-spy="scroll" data-target=".site-navbar-target">

	<jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
	<div class="container" id="changeable">
		<h3 class="title"><i class="ni ni-archive-2" style="color: rgba(64, 146, 143)"></i><br><b>서류 업로드</b></h3>
		<div class="card">
		  <div class="card-body">
		    <h5 style="color: rgba(233, 117, 80)">
		    	<img src="https://img.icons8.com/cute-clipart/30/000000/error.png"/>
		    	<b>주의</b>
		    </h5>
		    <ul>
		    	<li>파일은 한번에 최대 5개까지 올릴 수 있습니다.</li>
		    	<li>서류의 법적 유효기간이 지나면 자동으로 보관함에서 삭제됩니다. </li>
		    	<li>서류 유효기간 전까지는 언제든 재이용 및 다운로드가 가능합니다. </li>
		    	<li>파일은 .jpeg, .pdf, .jpg, .xlsx 파일만 업로드할 수 있습니다. </li>
		    	<li>파일 최대 용량은 10MB 입니다. </li>
		    	<li>재무제표의 경우 주어진 양식만 사용할 수 있습니다. 
		    		<input type="button" class="btn btn-secondary smallBtn" value="양식 다운로드" id="finDownload" style="background-color: rgba(233, 117, 80); border: none; ">
		    	</li>
		    </ul>
		  </div>
		</div>
		
		<div class="sub-blank"></div>

		<div class="card" style="border: 2px solid rgba(233, 117, 80)">
		  <div class="card-body">
		    <h5 style="color: rgba(89, 78, 84)">${ userVO.name }님의 서류보관함</h5>
		    <div id="docList"></div>
		  </div>
		</div>
<!--------------------------------------------- 제출 폼 --------------------------------------------->
		
		<div class="sub-blank"></div>
		<form name="docForm">
		<div>
		<table class="table">
			<tr>
				<th>서류 종류</th>
				<td>
					<select name="docType">
						<option value="default">선택</option>
						<option value="법인등기부등본">법인등기부등본</option>
						<option value="사업자등록증">사업자등록증</option>
						<option value="보증서">보증서</option>
						<option value="주주명부">주주명부</option>
						<option value="재무제표">재무제표</option>
						<option value="표준부과세과세증명원">표준부과세과세증명원</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제출인</th>
				<td>${ userVO.name }</td>
			</tr>
			<tr>
				<th>발급일</th>
				<td><input type="date" name="issueDate">
			</tr>
			<tr>
				<th>서류 첨부</th>
				<td>
					<input type="file" name="doc" id="fileTag"/>
				</td>
			</tr>
		</table>
	  	</div>
	  	<div class="blank"></div>

		
		
		<div style="text-align: center">
	  		<input type="button" class="btn btn-primary" id="docUpload" name="attachfile1" value="업로드">
	  	</div>
		</form>
	</div>
	<div class="blank"></div>
	<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
	
<jsp:include page="/WEB-INF/jsp/include/js.jsp" />
</body>


</html>