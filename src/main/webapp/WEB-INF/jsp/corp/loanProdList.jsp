<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출상품조회</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
#credit {
	display: none;
}
.md-form {
	width: 30%;
	float: right
}

.singleLine{
	display: inline;
}
th {
	background-color: #E9F5EF;
}

</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		/* 간편금리확인 선택창 */
		$('.custom-select-sm').change(function() {
			let loanType = $(this).val()
			if(loanType == '보증서 담보대출'){
				$('#credit').hide()
				$('#assur').show()
			} else if(loanType == '신용 대출' || loanType == '물적 담보대출'){
				$('#assur').hide()
				$('#credit').show()
			}
		})
		/* 상품 검색 */
		/* $('.form-control').keyup(function() {
			let val = $(this).val()
			for(var i in "${ loanProd }"){
				console.log(i)
			}
		}) */
		
		/* 비교하기 */
		$('.btn-primary').click(function() {
			let prodNoArr = new Array();
			
			if($('input:checkbox[name="no"]:checked').length > 3){
				alert('최대 3개까지만 비교할 수 있습니다.');
				$('#compareModal').modal('hide')
			} else {
				$("input:checkbox[name='no']").each(function(){
					if($(this).is(":checked") == true) {
						prodNoArr.push($(this).val())
						/* console.log($(this).val()) */
					}

				});
				
				$.ajax({
					url : '${ pageContext.request.contextPath }/corp/loanProd/comp',
					type : 'get',
					data : {
						'no' : prodNoArr 
					},
					success : function(result) {
						$('.modal-body').empty()
						$('.modal-body').append(result)
					},
					error : function(result) {
						alert('error')
					}
				})
				$('#compareModal').modal('show')
			} 
		})
	
	})
	/* 예상 금리 보기 결과 */
	function doInterestTest() {
		let loanTypeOrg = $('.custom-select-sm').val()
		let loanType;
		let standard;
		if(loanTypeOrg == '보증서 담보대출'){
			loanType = 'W'
			standard = $('#assurVal').val()
		} else if(loanTypeOrg == '신용 대출') {
			loanType = 'C'
			standard = $('#creditVal').val()
		} else if(loanTypeOrg == '물적 담보대출'){
			loanType = 'M'
			standard = $('#creditVal').val()
		}
			console.log(loanType)
			console.log(standard)
		
		$.ajax({
			url : '${ pageContext.request.contextPath }/corp/loanProd/test',
			type : 'get',
			data : {
				loanType : loanType,
				standard : standard
			},
			success : function(result) {
				$('#interest_rst').empty()
				$('#interest_rst').append('고객님이 받을 수 있는 예상 금리는 <span style="color: rgba(64, 146, 143)"><b>' + result + '%</b></span> 입니다.')
			},
			error : function(result) {
				alert('error')
			}
		})
		
		
	}
$(document).ready(function() {
	/* 
	상품검색 
	*/
	$("#myInput").keyup(function() {
	   var value = $(this).val().toLowerCase();
	   $("#prodTbl tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	   });
	   
	});
})	
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">

	<jsp:include page="../include/header.jsp"/>
	
	<img src="${ pageContext.request.contextPath }/resources/images/loanProd_banner.jpg"
	style="width: 100%; height: 450px">
	
	<div class="container" id="changeable">
		<h3 class="title"><i class="ni ni-cart" style="color: rgba(64, 146, 143)"></i><br>대출 상품 조회</h3>
		<div class="card" style="border: 2px solid rgba(64, 146, 143)">
			<div class="card-body">
			<h5 class="card-title">간편 대출 금리 보기</h5>
			<form action="" name="interest_test">
				<table id="interest">
					<tr>
						<td>대출 유형</td>
						<td>
							<select class="custom-select custom-select-sm">
								<option>보증서 담보대출</option>
								<option>물적 담보대출</option>
								<option>신용 대출</option>
							</select>
						</td>
					</tr>
						<tr class="option" id="credit">
							<td>신용도</td>
							<td>
								<select class="custom-select custom-select-sm" id="creditVal">
									<option>AAA ~ A</option>
									<option>BBB</option>
									<option>BB</option>
									<option>B</option>
									<option>CCC ~ D</option>
								</select>
							</td>
						</tr>
						<tr class="option" id="assur">
							<td>보증 비율</td>
							<td>
								<select class="custom-select custom-select-sm" id="assurVal">
									<option>100%</option>
									<option>90%</option>
									<option>85%</option>
									<option>80%</option>
									<option>80% 미만</option>
								</select>
							</td>
						</tr>
				</table>
				<a href="#" class="card-link" onclick="doInterestTest()">예상 금리 보기</a>
			</form>
			</div>
			<div id="interest_rst" style="margin-left: 3%"></div>
			<div class="sub-blank"></div>
		</div>
		<div class="blank"></div>
		<h4 class="subtitle singleLine">원하시는 상품을 찾아보세요. </h4>
		<div class="sub-blank"></div>
		<!-- Search form -->
		<div class="md-form mt-0 singleLine">
			<input class="form-control" type="text" id="myInput" placeholder="상품명 검색" aria-label="Search">
		</div>
		<div></div>
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
		  비교하기
		</button>
		&nbsp;&nbsp;&nbsp;최대 3개까지 비교가능<br>
		<hr>
		<h5>전체 ${ totalBoardCnt }개 대출 목록</h5>
		<form action="" name="loanProd">
			<table class="table table-hover" id="prodTbl">
			<c:forEach items="${ loanProd }" var="prod" varStatus="loop" >
					
				<c:if test="${ loop.count <= 3 }">
				<tr>
					<td style="width: 7%"><input type="checkbox" name="no" id="${ prod.prodNo }" value="${ prod.prodNo }"></td>
					<td class="prodTblTd"><a href="<%= request.getContextPath() %>/corp/loanDetail?no=${ prod.prodNo }" >${ prod.name }</a>
						<button class="btn btn-secondary smallBtn" style="background-color: #4158EB; border: none;">★ 인기</button>
					</td>
				</tr>
				</c:if>
				
				<c:if test="${ loop.count > 3 }">
				<tr>
					<td style="width: 7%"><input type="checkbox" name="no" id="${ prod.prodNo }" value="${ prod.prodNo }"></td>
					<td class="prodTblTd"><a href="<%= request.getContextPath() %>/corp/loanDetail?no=${ prod.prodNo }" >${ prod.name }</a></td>
				</tr>
				</c:if>
			</c:forEach>
			</table>
		</form>
	</div>
	<!------------------------------------ 페이징 시작 ------------------------------------>
	<div style="margin-left: 48%">
	<!------------------------------------ "이전" 구현 ------------------------------------>
		<c:if test="${ blockNo != 1 }"> 
			<a href="<%=request.getContextPath()%>/corp/loanProd?blockNo=${ blockNo -1 }&pageNo=${ blockStartPageNo-1 }" >이전</a> &nbsp;
		</c:if>
	<!------------------------------------ 페이지 구현 ------------------------------------>
	<c:forEach var="i" begin="${ blockStartPageNo }" end="${ blockEndPageNo }">
		<c:choose>
			<c:when test="${ pageNo == i }">
				${ i }&nbsp;|&nbsp;
			</c:when>
					
			<c:otherwise>
				<a href="<%=request.getContextPath()%>/corp/loanProd?blockNo=${ blockNo }&pageNo=${ i }" >${ i }&nbsp;</a>|&nbsp;
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<!------------------------------------ "다음" 구현 ------------------------------------>
	<c:if test="${ blockNo != totalBlockCnt}">&nbsp;
		<a href="<%=request.getContextPath()%>/corp/loanProd?blockNo=${ blockNo+1 }&pageNo=${ blockEndPageNo+1 }" >다음</a> &nbsp;
	</c:if>
	</div>
	<!------------------------------------ 페이징 끝 ------------------------------------>
	<div class="blank"></div>
	
	<!-- Modal -->
	<div class="modal fade" id="compareModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">대출 상품 비교</h5>
	       <!--  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button> -->
	      </div>
	      <div class="modal-body">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>