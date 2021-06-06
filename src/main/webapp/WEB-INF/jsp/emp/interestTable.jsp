<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
				<div class="card">
		            <div class="card-header border-0">
		              <div class="row align-items-center">
		                <div class="col">
		                  <h3 class="mb-0">대출정보</h3>
		                </div>
		              </div>
		            </div>
		            
				<div class="table-responsive" >
				<table class="table align-items-center table-flush">
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
			</div>
		
			</div>
		
		
				<div class="card">
		            <div class="card-header border-0">
		              <div class="row align-items-center">
		                <div class="col">
		                  <h3 class="mb-0">이자납입내역</h3>
		                </div>
		              </div>
		            </div>
		            
				<div class="table-responsive" >
				<table class="table align-items-center table-flush">
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
				</div>
				<!------------------------------------ 페이징 시작 ------------------------------------>
				<div style="margin-left: 48%">
				<!------------------------------------ "이전" 구현 ------------------------------------>
					<c:if test="${ blockNo != 1 }"> 
						<%-- <a href="<%=request.getContextPath()%>/corp/loanProd?blockNo=${ blockNo -1 }&pageNo=${ blockStartPageNo-1 }" >이전</a> &nbsp; --%>
						<a href="javascript:interestAjax(${ blockNo-1 }, ${ blockStartPageNo-1 })">이전</a>&nbsp;
					</c:if>
				<!------------------------------------ 페이지 구현 ------------------------------------>
				<c:forEach var="i" begin="${ blockStartPageNo }" end="${ blockEndPageNo }">
					<c:choose>
						<c:when test="${ pageNo == i }">
							${ i }&nbsp;|&nbsp;
						</c:when>
								
						<c:otherwise>
							<a href="javascript:interestAjax(${ blockNo }, ${ i })">${ i }&nbsp;</a>|&nbsp;
							<%-- <a href="<%=request.getContextPath()%>/corp/loanProd?blockNo=${ blockNo }&pageNo=${ i }" >${ i }&nbsp;</a>|&nbsp; --%>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<!------------------------------------ "다음" 구현 ------------------------------------>
				<c:if test="${ blockNo != totalBlockCnt}">&nbsp;
					<%-- <a href="<%=request.getContextPath()%>/corp/loanProd?blockNo=${ blockNo+1 }&pageNo=${ blockEndPageNo+1 }" >다음</a> &nbsp; --%>
					<a href="javascript:interestAjax(${ blockNo+1 }, ${ blockEndPageNo+1 })">다음</a>&nbsp;
				</c:if>
				</div>
				<!------------------------------------ 페이징 끝 ------------------------------------>
			 </div>