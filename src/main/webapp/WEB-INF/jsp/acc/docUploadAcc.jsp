<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서류보관함</title>
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
		url : '${ pageContext.request.contextPath }/acc/doc',
		type: 'get',
		data : {
			bizrNo : ${ corp.bizrNo }
		},
		success : function(data) {
			$('#docList').empty();
			
			let list = JSON.parse(data)
			
			$(list).each(function() {
				console.log(this)
				
				let str = '';
				str += '<hr>';
				str += this.docType + '&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="dwAtag" id="dw' + this.docNo + '">' + this.docOriName + '(' + this.docSize + ' bytes)</a>';
				str += '&nbsp;&nbsp;&nbsp;&nbsp;' 
				
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
      	url : '${ pageContext.request.contextPath }/acc/doc',
      	type : 'post',
      	contentType : false,
      	processData : false,
      	data : formData,
      	success : function() {
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
 

</script>

</head>
<body data-spy="scroll" data-target=".site-navbar-target">

	<jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
	<div class="container" id="changeable">
		<h3 class="title"><i class="ni ni-archive-2" style="color: rgba(64, 146, 143)"></i><br>서류 업로드</h3>
		<div class="card">
		  <div class="card-body">
		    <h5 style="color: rgba(64, 146, 143)">주의</h5>
		    <ul>
		    	<li>세무사는 재무제표, 표준부과세과세증명원에 한해서만 업로드할 수 있습니다.</li>
		    	<li>세무사는 파일 업로드만 가능하고, 기업이 올린 파일에 대해서는 삭제가 불가능합니다.</li>
		    	<li>서류의 법적 유효기간이 지나면 자동으로 보관함에서 삭제됩니다. </li>
		    	<li>서류 유효기간 전까지는 언제든 재이용 및 다운로드가 가능합니다. </li>
		    	<li>파일은 .jpeg, .pdf, .jpg, .xlsx 파일만 업로드할 수 있습니다. </li>
		    	<li>파일 최대 용량은 10MB 입니다. </li>
		    </ul>
		  </div>
		</div>
		
		<div class="sub-blank"></div>

		<div class="card">
		  <div class="card-body">
		    <h5 style="color: rgba(64, 146, 143)">${ corp.name }의 서류보관함</h5>
		    <div id="docList"></div>
		  </div>
		</div>
<!--------------------------------------------- 제출 폼 --------------------------------------------->
		
		<div class="sub-blank"></div>
		<form name="docForm">
		<input type="hidden" value="${ corp.bizrNo }" name="bizrNo">
		<div>
		<table class="table">
			<tr>
				<th>서류 종류</th>
				<td>
					<select name="docType">
						<option value="default">선택</option>
						<option value="재무제표">재무제표</option>
						<option value="표준부과세과세증명원">표준부과세과세증명원</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제출인</th>
				<td>${ accVO.name }</td>
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