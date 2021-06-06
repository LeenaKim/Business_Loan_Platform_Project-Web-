<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출 상세페이지</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
td {
	padding: 2%
}
tr > td:first-child {
	font-size: 18px;
	width: 25%;
}
tr > td:second-child {
	width: 75%;
}
.card {
	box-shadow: 8px 8px gray;
}
</style>
<script>
	function doAction(option){
		if(option == 'L'){
			location.href="/Beone/corp/loanProd"
		}else {
			location.href="/Beone/corp/loanApp?prodNo=${ loanProd.prodNo }"			
		}
	}
</script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">

	<jsp:include page="../include/header.jsp"/>
	<div class="container" id="changeable">
		<h3 class="title">
		${ loanProd.name }<br>
		<button class="btn btn-primary smallBtn" style="background-color: rgba(233, 117, 80); border: 1px solid rgba(233, 117, 80)">연 ${ loanProd.interest } %</button>
		<c:if test="${ loanProd.name eq '청년창업대출' }">
			<button class="btn btn-primary smallBtn" style="background-color: blue; border: 1px solid blue">청년우대</button>
		</c:if>
		</h3>
		<div class="card">
 		<div class="card-body">
		<table class="table table-striped">
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>대상</b></td>
				<td>
					${ loanProd.object }
				</td>
			</tr>
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>대출기간</b></td>
				<td>
					${ loanProd.termMon } 년
				</td>
			</tr>
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>최저금리</b></td>
				<td>
					연 ${ loanProd.interest } %
				</td>
			</tr>
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>한도</b></td>
				<td>
					${ loanProd.limit } 원 
				</td>
			</tr>
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>이자계산방법</b></td>
				<td>
					${ loanProd.interestCalMtd }
				</td>
			</tr>
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>상환방식</b></td>
				<td>
					${ loanProd.repType }
				</td>
			</tr>
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>원리금 상환방법</b></td>
				<td>
					${ loanProd.repMtd }
				</td>
			</tr>
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>계약해지/갱신방법</b></td>
				<td>
					${ loanProd.cancleReMtd }
				</td>
			</tr>
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>중도상환수수료율</b></td>
				<td>
					${ loanProd.midRpyFeeRate } %
				</td>
			</tr>
			<tr>
				<td><i class="ni ni-bold-right"></i>&nbsp;<b>유의사항</b></td>
				<td>
					${ loanProd.notice }
				</td>
			</tr>
		</table>
		</div>
		</div>
	</div>
	<div class="sub-blank"></div>
	<div style="text-align: center">
		<button type="button" class="btn btn-primary" onclick="doAction('J')">가입</button>
		<button type="button" class="btn btn-primary" onclick="doAction('L')">목록</button>
	</div>
	<div class="blank"></div>
	
	
	
	
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />
</body>
</html>