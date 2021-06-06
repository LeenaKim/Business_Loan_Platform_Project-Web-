<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래내역</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
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
	float: left;
}
.smallBtn {
	margin-top: 2%;
	background-color: #E0E4E3;
	color: #3F403F;
	border: none;
}
.SearchTerm{
	width: 15%;
	height: 6%;
	border: none;
	background-color: #E0E4E3;
	font-size: 11px;
}
.SearchTerm:focus {
	background-color: rgba(64, 146, 143);
}
#selectTermDate {
	display: none;
}
</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
$(document).ready(function() {
	/* 
		계좌 변경시 해당 계좌 상세 내역으로 이동 
	*/
	$('#selectAcnt').change(function() {
		let no = $(this).val();
		location.href = "${ pageContext.request.contextPath }/corp/acntDetail/" + no;
	})

	/* 
		계좌 내역 조회 기간 
	*/
	$('.SearchTerm').click(function() {
		let term = $(this).val();
		if($(this).attr('id') != 'condition'){
			location.href = "${ pageContext.request.contextPath }/corp/acntDetailTerm/" + ${ acnt.no } + "/" + term;			
		}
		
	})
	/* 
		'조건검색' 클릭시 시작일, 종료일 설정 div 보이기 
	*/
	$('#condition').click(function() {
		alert('조건검색 클릭')
		$('#selectTermDate').toggle();
	})
	/* 
		'조건검색' 클릭시 페이지 이동 
	*/
	$('#viewCustom').click(function() {
		let start = $('input[name=start]').val()
		let end = $('input[name=end]').val()
		let no = ${ acnt.no }
		
		if(start == ''){
			alert('시작일을 입력하세요.');
			return;
		}
		if(end == ''){
			alert('종료일을 입력하세요.');
			return;
		}
		
		location.href = "${ pageContext.request.contextPath }/corp/acntDetailCustomTerm/" + no + "/" + start + "/" + end;
	})
})


</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/header.jsp"/>

	
	
	<div class="container" id="changeable">
		<h3 class="title"><i class="ni ni-money-coins" style="color: rgba(64, 146, 143)"></i><br><b>거래내역 조회</b></h3>
		<h4 style="display:inline"><b>${ userVO.name }</b> 고객님의 </h4><br>
		<h5 style="display:inline;">거래내역입니다.</h5><br>
		<div class="sub-blank"></div>
		
		
		<p><b>계좌번호</b></p>
		<select class="custom-select custom-select-sm" id="selectAcnt">
		<c:forEach items="${ acntList }" var="acnts">
			<c:if test="${ acnts.no eq  acnt.no }">
			  <option value="${ acnts.no }" selected>하나 ${ acnts.no }</option>
			</c:if>
			<c:if test="${ acnts.no ne acnt.no }">
			  <option value="${ acnts.no }">하나 ${ acnts.no }</option>
			</c:if>
		</c:forEach>
		</select>
		
		
		<div class="sub-blank"></div>
		<h5 style="display:inline; float:right">잔액</h5><br><br>
		<h5 style="border-bottom: 3px solid rgba(64, 146, 143); float:right;"><fmt:formatNumber value="${ acnt.balance }" pattern="###,###,###,###" /> 원</h5>
		
		<p style="smallLetter">${ acnt.regDate } ~</p>
		
		
		<button class="SearchTerm" id="dday" value="0">당일</button>
		<button class="SearchTerm" id="week" value="7">일주일</button>
		<button class="SearchTerm" id="oneMon" value="30">1개월</button>
		<button class="SearchTerm" id="threeMon" value="90">3개월</button>
		<button class="SearchTerm" id="sixMon" value="182">6개월</button>
		<button class="SearchTerm" id="condition" value="condition">조건검색</button>
		
		<div class="sub-blank"></div>
		
		<div id="selectTermDate">
				<input type="submit" id="viewCustom" value="조회" style="float: right; font-size: 12px;">
				<span class="smallLetter" style="float: right">
				종료일<input type="date" name="end"></span>
				<span class="smallLetter" style="float: right">
				시작일<input type="date" name="start"></span><br><br><br>
		</div>
		<!--------------------------------------------- 거래내역 시작 --------------------------------------------->
		<div class="row" id="cardList">
		<c:forEach items="${ transList }" var="trans" varStatus="loop">
		
				<div class="card" style="width: 100%" >
			 		 <div class="card-body">
			 		 	<h3 class="card-text" style="text-align: center;">
			 		 		<span class="smallLetter">${ trans.occurTime }</span>
			 		 		<span class="smallLetter" style="float: right">잔액&nbsp;<b><fmt:formatNumber value="${ trans.balance }" pattern="###,###,###,###" />원</b></span><br>
			 		 		
			 		 		<span style="float: right; font-size: 15px;"><b>${ trans.objName }</b></span><br>
			 		 		<c:if test="${ not empty trans.objAcntNo }">
			 		 			<span style="float: right; font-size: 13px;">${ trans.objAcntNo }</span><br>
			 		 		</c:if>
			 		 		<c:if test="${ trans.wAmount ne 0 }">
				 		 		<span class="smallLetter">출금금액</span>
				 		 		<span style="color: red; float: right;"><b><fmt:formatNumber value="${ trans.wAmount }" pattern="###,###,###,###" /></b></span><br>			 		 		
			 		 		</c:if>
			 		 		<c:if test="${ trans.dAmount ne 0 }">
				 		 		<span class="smallLetter">입금금액</span>
				 		 		<span style="color: blue; float: right;"><b><fmt:formatNumber value="${ trans.dAmount }" pattern="###,###,###,###" /></b></span><br>			 		 		
			 		 		</c:if>
			 		 		<span class="smallLetter">거래유형</span>
			 		 		<span style="float: right; font-size: 13px;">${ trans.summary }</span>
			 		 	</h3>
			 		 </div>
			 	</div>
			<c:if test="${ loop.last }">
				<c:set var="lastTransNo" value="${ trans.no }"/>
			</c:if>	
		</c:forEach>
		
		
		</div>
		
		
		<div class="blank"></div>
		<!------------------------------------ 페이징 시작 ------------------------------------>
		<div style="margin-left: 48%">
		<!------------------------------------ "이전" 구현 ------------------------------------>
			<c:if test="${ blockNo != 1 }"> 
				<c:if test="${ empty term and empty start }">
					<a href="<%=request.getContextPath()%>/corp/acntDetail/${ acnt.no }?blockNo=${ blockNo -1 }&pageNo=${ blockStartPageNo-1 }" >이전</a> &nbsp;
				</c:if>
				<c:if test="${ not empty term  }">
					<a href="<%=request.getContextPath()%>/corp/acntDetailTerm/${ acnt.no }/${ term }?blockNo=${ blockNo -1 }&pageNo=${ blockStartPageNo-1 }" >이전</a> &nbsp;
				</c:if>
				<c:if test="${ not empty start }">
					<a href="<%=request.getContextPath()%>/corp/acntDetailCustomTerm/${ acnt.no }/${ start }/${ end }?blockNo=${ blockNo -1 }&pageNo=${ blockStartPageNo-1 }" >이전</a> &nbsp;
				</c:if>
			</c:if>
		<!------------------------------------ 페이지 구현 ------------------------------------>
		<c:forEach var="i" begin="${ blockStartPageNo }" end="${ blockEndPageNo }">
			<c:choose>
				<c:when test="${ pageNo == i }">
					${ i }&nbsp;|&nbsp;
				</c:when>
						
				<c:otherwise>
					<c:if test="${ empty term and empty start}">
						<a href="<%=request.getContextPath()%>/corp/acntDetail/${ acnt.no }?blockNo=${ blockNo }&pageNo=${ i }" >${ i }&nbsp;</a>|&nbsp; 
						<%-- <a href="javascript:goPaging2('${ i }');" >${ i }&nbsp;</a>|&nbsp; --%>					
					</c:if>
					<c:if test="${ not empty term }">
						<a href="<%=request.getContextPath()%>/corp/acntDetailTerm/${ acnt.no }/${ term }?blockNo=${ blockNo }&pageNo=${ i }" >${ i }&nbsp;</a>|&nbsp; 
					</c:if>
					<c:if test="${ not empty start }">
						<a href="<%=request.getContextPath()%>/corp/acntDetailCustomTerm/${ acnt.no }/${ start }/${ end }?blockNo=${ blockNo }&pageNo=${ i }" >${ i }&nbsp;</a>|&nbsp; 
					</c:if>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<!------------------------------------ "다음" 구현 ------------------------------------>
		<c:if test="${ blockNo != totalBlockCnt}">&nbsp;
			<c:if test="${ empty term  and empty start }">
				<a href="<%=request.getContextPath()%>/corp/acntDetail/${ acnt.no }?blockNo=${ blockNo+1 }&pageNo=${ blockEndPageNo+1 }" >다음</a> &nbsp;
			</c:if>
			<c:if test="${ not empty term }">
				<a href="<%=request.getContextPath()%>/corp/acntDetailTerm/${ acnt.no }/${ term }?blockNo=${ blockNo+1 }&pageNo=${ blockEndPageNo+1 }" >다음</a> &nbsp;
			</c:if>
			<c:if test="${ not empty start }">
				<a href="<%=request.getContextPath()%>/corp/acntDetailCustomTerm/${ acnt.no }/${ start }/${ end }?blockNo=${ blockNo+1 }&pageNo=${ blockEndPageNo+1 }" >다음</a> &nbsp;
			</c:if>
		</c:if>
		</div>
		<!------------------------------------ 페이징 끝 ------------------------------------>
	
	
	
		<!-- <div style="text-align: center">
			<input type="button" class="btn btn-secondary midBtn" id="viewMore" value="+ 더보기">
		</div> -->
		
		
	</div>
	<div class="blank"></div>
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />
<script>
/* 
더보기 클릭시 ajax로 20개 더 가져오기 
$('#viewMore').click(function() {
	let no = ${ acnt.no };
	let lastTransNo = ${ lastTransNo };
	
	$.ajax({
		url : '${ pageContext.request.contextPath }/corp/acntDetail',
		type: 'post',
		data : {
			no : no,
			lastTransNo : lastTransNo
		},
		success : function(data) {
			$('#cardList').append(data);
		}, error : function() {
			alert('실패')
		}
	})
})
*/
</script>
</body>

</html>