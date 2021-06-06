<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이자조회 & 납입</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
td {
	padding: 1%;
}
th {
	padding: 1%;
	background-color: #EFEFEF;
	font-size: 11px;
}
div.scrollmenu {
  overflow: auto; 
  white-space: nowrap;
}
ul{
	padding: 0%;
	padding-left: 3%;
}
.complete {
	display: none;
}
</style>
<link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
<script>
$(document).ready(function() {
	$('#selectAcnt').change(function() {
		location.href = "${ pageContext.request.contextPath }/corp/interest?loanNo=" + $(this).val();
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
		<div class="container" id="changeable">
		<h3 class="title"><b>이자조회 & 납부</b></h3>
		
		<div class="card">
		  <div class="card-body">
		    <h5 style="color: rgba(233, 117, 80)">
		    	<img src="https://img.icons8.com/cute-clipart/30/000000/error.png"/>
		    	<b>주의</b>
		    </h5>
		    <ul>
		    	<li>월 이자 납부 금액 : (대출원금 * (약정이자율 / 12 * 대출기간(개월))) / 대출기간(개월)</li>
		    	<li>대출신청시 이자 자동이체를 선택하신경우 이자납부계좌에서 매월 동일한 날짜에 자동이체됩니다.</li>
		    	<li>이자가 납부되지 않은 경우 해당 월의 이자는 다음 월로 이월되고, 정상금리(약정 이자율)에 1%의 지연가산이자율이 붙습니다.</li>
		    </ul>
		  </div>
		</div>
	
	
		<div class="blank"></div>
		<h5 class="subtitle" style="display:inline">이자조회</h5>
		<div style="float:right">
			<input type="checkbox" onchange="changeStatus()" checked data-toggle="toggle" id="loanStatusChk" data-on="진행중" data-off="완료">
		</div>
		<div class="blank"></div>
		
		<select class="custom-select custom-select-sm" id="selectAcnt">
		<c:forEach items="${ loanHisList }" var="loanHisL">
		
			<c:if test="${ loanHisL.loanNo eq loanHis.loanNo }">
			  <c:if test="${ loanHisL.loanStatus eq 'C' }">
				  <option class="complete" value="${ loanHisL.loanNo }" selected>대출번호 ${ loanHisL.loanNo } | 계좌 ${ loanHisL.loanAcnt } | 대출금 
				  	<fmt:formatNumber value="${ loanHisL.pcplAmt }" pattern="###,###,###,###" /> 원
				  </option>			  
			  </c:if>
			  <c:if test="${ loanHisL.loanStatus eq 'I' }">
				  <option class="ing" value="${ loanHisL.loanNo }" selected>대출번호 ${ loanHisL.loanNo } | 계좌 ${ loanHisL.loanAcnt } | 대출금 
				  	<fmt:formatNumber value="${ loanHisL.pcplAmt }" pattern="###,###,###,###" /> 원
				  </option>			  			  
			  </c:if>
			</c:if>
			
			
			<c:if test="${ loanHisL.loanNo ne loanHis.loanNo }">
			  <c:if test="${ loanHisL.loanStatus eq 'C' }">
				  <option class="complete" value="${ loanHisL.loanNo }">대출번호 ${ loanHisL.loanNo } | 계좌 ${ loanHisL.loanAcnt } | 대출금 
				  	<fmt:formatNumber value="${ loanHisL.pcplAmt }" pattern="###,###,###,###" /> 원
				  </option>
			  </c:if>
			  <c:if test="${ loanHisL.loanStatus eq 'I' }">
				  <option class="ing" value="${ loanHisL.loanNo }">대출번호 ${ loanHisL.loanNo } | 계좌 ${ loanHisL.loanAcnt } | 대출금 
				  	<fmt:formatNumber value="${ loanHisL.pcplAmt }" pattern="###,###,###,###" /> 원
				  </option>
			  </c:if>
			</c:if>
		</c:forEach>
		</select> 
		
		
		
		<h5 class="subtitle">대출정보</h5>
		<table class="table">
			<tr>
				<th>대출상품</th>
				<td>${ loanHis.prodName }</td>
				<th>대출계좌</th>
				<td>${ loanHis.loanAcnt }</td>
			</tr>
			<tr>
				<th>대출구분</th>
				<td>${ loanHis.loanType }</td>
				<th>대출기간</th>
				<td>${ loanHis.startDate } ~ ${ loanHis.finDate }</td>
			</tr>
			<tr>
				<th>상환률</th>
				<td>${ loanHis.rpyRate }%</td>
				<th>잔금</th>
				<td><fmt:formatNumber value="${ loanHis.leftAmt }" pattern="###,###,###,###" />원</td>
			</tr>
			<tr>
				<th>원금</th>
				<td><fmt:formatNumber value="${ loanHis.pcplAmt }" pattern="###,###,###,###" />원</td>
				<th>금리</th>
				<td>연 ${ loanHis.interest }%</td>
			</tr>
			<tr>
				<th>이자납부계좌</th>
				<td>${ loanHis.interestAcnt }</td>
				<th>담보유형</th>
				<td>
					<c:if test="${ not empty loanHis.assType }">
						${ loanHis.assType }
					</c:if>
				</td>
			</tr>
			<tr>
				<th>월 납부 이자</th>
				<td><fmt:formatNumber value="${ loanHis.interestAmt }" pattern="###,###,###,###" />원</td>
				<th>대출 상태</th>
				<td>
					<c:if test="${ loanHis.loanStatus eq 'C' }">
						종료 
					</c:if>
					<c:if test="${ loanHis.loanStatus eq 'I' }">
						진행중 
					</c:if>
				</td>
			</tr>
		</table>



		<h5 class="subtitle">이자납입정보</h5>
		<table class="table">
			<tr>
				<th>번호</th>
				<th>납부액</th>
				<th>납부일</th>
			</tr>
			<c:forEach items="${ intrList }" var="intr" varStatus="loop">
			<tr>
				<td>${ loop.count }</td>
				<td><fmt:formatNumber value="${ intr.payAmt }" pattern="###,###,###,###" />원</td>
				<td>${ intr.payDate }</td>
			</tr>
			</c:forEach>
		</table>
		
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
