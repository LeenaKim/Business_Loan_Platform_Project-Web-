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
					<th scope="col">대출상품</th>
					<th scope="col">대출계좌</th>
					<th scope="col">대출구분</th>
					<th scope="col">시작일</th>
					<th scope="col">만기일</th>
					<th scope="col">상환률</th>
					<th scope="col">잔금</th>
					<th scope="col">원금</th>
					<th scope="col">금리</th>
					<th scope="col">이자 납부 계좌</th>
					<th scope="col">이자 납부일</th>
					<th scope="col">담보 유형</th>
					<th scope="col">이자</th>
				</tr>
				<c:forEach items="${ loanHisList }" var="loanHis">
					<tr>
						<td><input type="radio" value="${ loanHis.loanNo }" name="loanHisRadio"></td>
						<td>${ loanHis.bizrNo }</td>
						<td>${ loanHis.prodName }</td>
						<td>${ loanHis.loanAcnt }</td>
						<td>${ loanHis.loanType }</td>
						<td>${ loanHis.startDate }</td>
						<td>${ loanHis.finDate }</td>
						<td>${ loanHis.rpyRate } %</td>
						<td><fmt:formatNumber value="${ loanHis.leftAmt }" pattern="###,###,###,###" /> 원</td>
						<td><fmt:formatNumber value="${ loanHis.pcplAmt }" pattern="###,###,###,###" /> 원</td>
						<td>${ loanHis.interest } %</td>
						<td>${ loanHis.interestAcnt }</td>
						<td>매달 ${ loanHis.interestDate }일</td>
						<td>${ loanHis.assType }</td>
						<td><fmt:formatNumber value="${ loanHis.interestAmt }" pattern="###,###,###,###" /> 원</td>
					</tr>
				</c:forEach>
				
				
                </tbody>
              </table>
              </div>
              <!------------------------------------ 페이징 시작 ------------------------------------>
				<div style="margin-left: 48%">
				<!------------------------------------ "이전" 구현 ------------------------------------>
					<c:if test="${ blockNo2 != 1 }"> 
						<a href="<%=request.getContextPath()%>/emp/loanHis?blockNo=${ blockNo2 -1 }&pageNo=${ blockStartPageNo2-1 }" >이전</a> &nbsp; 
					</c:if>
				<!------------------------------------ 페이지 구현 ------------------------------------>
				<c:forEach var="i" begin="${ blockStartPageNo2 }" end="${ blockEndPageNo2 }">
					<c:choose>
						<c:when test="${ pageNo2 == i }">
							${ i }&nbsp;|&nbsp;
						</c:when>
								
						<c:otherwise>
							<%-- <a href="<%=request.getContextPath()%>/emp?blockNo=${ blockNo }&pageNo=${ i }" onclick="goPaging(${ i })">${ i }&nbsp;</a>|&nbsp; --%>
							<a href="javascript:goPaging2('${ i }');" >${ i }&nbsp;</a>|&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<!------------------------------------ "다음" 구현 ------------------------------------>
				<c:if test="${ blockNo2 != totalBlockCnt2}">&nbsp;
					<a href="<%=request.getContextPath()%>/emp/loanHis?blockNo=${ blockNo2+1 }&pageNo=${ blockEndPageNo2+1 }" >다음</a> &nbsp; 
				</c:if>
				</div>
				<!------------------------------------ 페이징 끝 ------------------------------------>
			
			