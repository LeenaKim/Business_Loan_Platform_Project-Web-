<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<div class="tab-pane" id="profile" role="tabpanel" aria-labelledby="loan-his-tab">
	<div class="card">
		<div class="card-header border-0">
			<div class="row align-items-center">
		    	<div class="col">
		        	<h3 class="mb-0">상환 내역</h3>
		        </div>
		    </div>
		</div>
            
		<div class="table-responsive" >
			<table class="table align-items-center table-flush">
				<thead class="thead-light">
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
				</tbody>
			</table>
		</div>
	</div>
</div>
