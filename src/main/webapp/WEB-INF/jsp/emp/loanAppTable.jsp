<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
			<div class="table-responsive">
 			<table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                  	<th></th>
                    <th scope="col">사업자등록번호</th>
                    <th scope="col">대출상품 이름</th>
					<th scope="col">신청일</th>
					<th scope="col">대출유형</th>
					<th scope="col">대출계좌</th>
					<th scope="col">이자납부계좌</th>
					<th scope="col">신청금액</th>
					<th scope="col">대출기간</th>
					<th scope="col">담보유형</th>
                  </tr>
                </thead>
                <tbody id="loanAppTbl">
                <c:forEach items="${ loanAppList }" var="loanApp">
					<tr>
						<td><input type="radio" value="${ loanApp.appNo }" name="loanAppRadio"></td>
						<td>${ loanApp.bizrNo }</td>
						<td>${ loanApp.prodName }</td>
						<td>${ loanApp.appDate }</td>
						<td>${ loanApp.loanType }</td>
						<td>${ loanApp.loanAcnt }</td>
						<td>${ loanApp.interestAcnt }</td>
						<td><fmt:formatNumber value="${ loanApp.appAmount }" pattern="###,###,###,###" /> 원</td>
						<td>${ loanApp.appMonth }</td>
						<td>${ loanApp.assType }</td>
					</tr>
				</c:forEach>
				
				
                </tbody>
              </table>
              </div>
              
              <!------------------------------------ 페이징 시작 ------------------------------------>
			<div style="margin-left: 48%">
			<!------------------------------------ "이전" 구현 ------------------------------------>
				<c:if test="${ blockNo != 1 }"> 
					<a href="<%=request.getContextPath()%>/emp/loanApp?blockNo=${ blockNo -1 }&pageNo=${ blockStartPageNo-1 }" >이전</a> &nbsp;
				</c:if>
			<!------------------------------------ 페이지 구현 ------------------------------------>
			<c:forEach var="i" begin="${ blockStartPageNo }" end="${ blockEndPageNo }">
				<c:choose>
					<c:when test="${ pageNo == i }">
						${ i }&nbsp;|&nbsp;
					</c:when>
							
					<c:otherwise>
						<%-- <a href="<%=request.getContextPath()%>/emp?blockNo=${ blockNo }&pageNo=${ i }" onclick="goPaging(${ i })">${ i }&nbsp;</a>|&nbsp; --%>
						<a href="javascript:goPaging('${ i }');" >${ i }&nbsp;</a>|&nbsp;
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<!------------------------------------ "다음" 구현 ------------------------------------>
			<c:if test="${ blockNo != totalBlockCnt}">&nbsp;
				<a href="<%=request.getContextPath()%>/emp/loanApp?blockNo=${ blockNo+1 }&pageNo=${ blockEndPageNo+1 }" >다음</a> &nbsp;
			</c:if>
			</div>
			<!------------------------------------ 페이징 끝 ------------------------------------>
