<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table">
	<tr>
		<th>항목</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<th>
				${ loanProd.name }
			</th>
		</c:forEach>
	</tr>
	<tr>
		<th>대상</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<td>
				${ loanProd.object }
			</td>
		</c:forEach>
		
	</tr>
	<tr>
		<th>대출기간</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<td>
				${ loanProd.termMon } 년
			</td>
		</c:forEach>
		
	</tr>
	<tr>
		<th>최저금리</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<td>
				${ loanProd.interest }
			</td>
		</c:forEach>
		
	</tr>
	<tr>
		<th>한도</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<td>
				${ loanProd.limit }
			</td>
		</c:forEach>
		
	</tr>
	<tr>
		<th>이자계산방법</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<td>
				${ loanProd.interestCalMtd }
			</td>
		</c:forEach>
		
	</tr>
	<tr>
		<th>상환방식</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<td>
				${ loanProd.repType }
			</td>
		</c:forEach>
		
	</tr>
	<tr>
		<th>원리금 상환방법</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<td>
				${ loanProd.repMtd }
			</td>
		</c:forEach>
		
	</tr>
	<tr>
		<th>계약해지/갱신방법</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<td>
				${ loanProd.cancleReMtd }
			</td>
		</c:forEach>
		
	</tr>
	<tr>
		<th>중도상환수수료율</th>
		<c:forEach items="${ loanProdComp }" var="loanProd" varStatus="loop">
			<td>
				${ loanProd.midRpyFeeRate }
			</td>
		</c:forEach>
		
	</tr>
</table>