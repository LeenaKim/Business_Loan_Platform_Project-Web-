<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출관리</title>
<jsp:include page="/WEB-INF/jsp/include/cssEmp.jsp" />
<style>
.card-title {
	color: #525f7f !important;
}

</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
//
//Sales chart
//

var SalesChart = function() {

	// Variables
	
	var $chart = $('#chart-sales-dark');
	
	
	// Methods
	
	function init($chart) {
	
	
		 var salesChart = new Chart($chart, {
		   type: 'line',
		   options: {
		     scales: {
		       yAxes: [{
		         gridLines: {
		           lineWidth: 1,
		           color: Charts.colors.gray[900],
		           zeroLineColor: Charts.colors.gray[900]
		         },
		         ticks: {
		           callback: function(value) {
		             /* if (!(value % 10)) { */
		               return value + '원';
		             /* } */
		           }
		         }
		       }]
		     },
		     tooltips: {
		       callbacks: {
		         label: function(item, data) {
		           var label = data.datasets[item.datasetIndex].label || '';
		           var yLabel = item.yLabel;
		           var content = '';
		
		           if (data.datasets.length > 1) {
		             content += '<span class="popover-body-label mr-auto">' + label + '</span>';
		           }
		
		           content += '<span class="popover-body-value">' + yLabel + '원</span>';
		           return content;
		         }
		       }
		     }
		   },
		   
		   data: {
		     labels: ['2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월'],
		     datasets: [{
		       label: '연체금액',
		       data: [
		    	   ${ interestByMonMap.mon2 },
		    	   ${ interestByMonMap.mon3 },
		    	   ${ interestByMonMap.mon4 },
		    	   ${ interestByMonMap.mon5 },
		    	   ${ interestByMonMap.mon6 },
		    	   ${ interestByMonMap.mon7 },
		    	   ${ interestByMonMap.mon8 },
		    	   ${ interestByMonMap.mon9 }
		       ]
		     }]
		   }
		   
		 });
		
		 // Save to jQuery object
		
		 $chart.data('chart', salesChart);
		
		};
	
	
	// Events
	
	if ($chart.length) {
		init($chart);
	}

};

$(document).ready(function() {
	SalesChart();
});

function addFocusLoan() {
	$.ajax({
		url : '${ pageContext.request.contextPath }/emp/loanMng/addFocusLoan',
		type : 'post',
		data : {
			'loanNo' : ${ loanHis.loanNo }
		},
		success : function(data) {
			$('#focusLoanModal').modal('show');
		},
		error : function(result) {
			alert('error')
		}
	})
}
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/empHeader.jsp"/>
<!--------------------------- 관심대출 추가 모달 ----------------------------->
<div class="modal" id="focusLoanModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">관심대출 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>관심대출로 추가되었습니다.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="approveModalBtn">나의 관심대출 보기</button>
      </div>
    </div>
  </div>
</div>


    <div class="header bg-primary pb-6">
      <div class="container-fluid">
        <div class="header-body">
          <div class="row align-items-center py-4">
            <div class="col-lg-6 col-7">
              <h6 class="h2 text-white d-inline-block mb-0">대출관리</h6>
            </div>
            <div class="col-lg-6 col-5 text-right">
              <a href="javascript:addFocusLoan()" class="btn btn-sm btn-neutral">+ 관심 기업 추가</a>
            </div>
          </div>
          
          
          
           <!------------------------------ 그래프 ------------------------------>
	    <!-- <div class="container-fluid mt--6"> -->
	      <div class="row">
	        <div class="col-xl-12">
	          <div class="card bg-default">
	            <div class="card-header bg-transparent">
	              <div class="row align-items-center">
	                <div class="col">
	                  <h6 class="text-light text-uppercase ls-1 mb-1">Overview</h6>
	                  <h5 class="h3 text-white mb-0">대출이자 연체 추이</h5>
	                </div>
	                <div class="col">
	                  <ul class="nav nav-pills justify-content-end">
	                    <li class="nav-item mr-2 mr-md-0" data-toggle="chart" data-target="#chart-sales-dark" data-update='{"data":{"datasets":[{"data":[0, 20, 10, 30, 15, 40, 20, 60, 60]}]}}' data-prefix="$" data-suffix="k">
	                    </li>
	                    <li class="nav-item" data-toggle="chart" data-target="#chart-sales-dark" data-update='{"data":{"datasets":[{"data":[0, 20, 5, 25, 10, 30, 15, 40, 40]}]}}' data-prefix="$" data-suffix="k">
	                    </li>
	                  </ul>
	                </div>
	              </div>
	            </div>
	            <div class="card-body">
	              <!-- Chart -->
	              <div class="chart">
	                <!-- Chart wrapper -->
	                <canvas id="chart-sales-dark" class="chart-canvas"></canvas>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	     </div>
	 
	   
        
        
        
     
          <div class="row">
            <div class="col-xl-6">
              <div class="card card-stats">
                <div class="card-body">
                  <h5 class="card-title text-uppercase mb-0">연체</h5>
                  
                  <div class="table-responsive" >
				 	<table class="table align-items-center table-flush">
				       <thead class="thead-light">
				       	  <tr>
					       	  <th style="font-size: 15px;">연체율</th>
					       	  <td>${ delayedInterestRate }%</td>
				       	  </tr>
				       	  <tr>
					       	  <th style="font-size: 15px;">연체횟수</th>
					       	  <td>${ delayedInterestCnt }번</td>
				       	  </tr>
				       	  <tr>
					       	  <th style="font-size: 15px;">연체액</th>
					       	  <td>${ delayedInterestAmt }원</td>
				       	  </tr>
				       </thead>
				    </table>
				  </div>
                </div>
              </div>
              
              <div class="card card-stats">
                <div class="card-body">
                  <h5 class="card-title text-uppercase mb-0">상환</h5>
                  
                   <div class="table-responsive" >
				 	<table class="table align-items-center table-flush">
				       <thead class="thead-light">
				       	  <tr>
					       	  <th style="font-size: 15px;">상환률</th>
					       	  <td>${ loanHis.rpyRate }%</td>
				       	  </tr>
				       	  <tr>
					       	  <th style="font-size: 15px;">상환액</th>
					       	  <td>${ loanHis.rpyRate / 100 * loanHis.pcplAmt }원</td>
				       	  </tr>
				       </thead>
				    </table>
				  </div>
				  
                </div>
              </div>
            </div>  
                      
            <div class="col-xl-6">
               <div class="card card-stats">
                <div class="card-body">
                  <h5 class="card-title text-uppercase mb-0">대출정보</h5>
                   <div class="table-responsive">
				 	<table class="table align-items-center table-flush">
				       <thead class="thead-light">
				       	  <tr>
				       	  	<th>대출번호</th>
				       	  	<td>${ loanHis.loanNo }</td>
				       	  	<th>대출유형</th>
				       	  	<td>${ loanHis.loanType }</td>
				       	  </tr>
				       	  <tr>
				       	  	<th>대출기간</th>
				       	  	<td>${ loanHis.startDate } ~ ${ loanHis.finDate }</td>
				       	  	<th>원금</th>
				       	  	<td><fmt:formatNumber value="${ loanHis.pcplAmt }" pattern="###,###,###,###" />원</td>
				       	  </tr>
				       	  <tr>
				       	  	<th>금리</th>
				       	  	<td>${ loanHis.interest }%</td>
				       	  	<th>대출계좌</th>
				       	  	<td>${ loanHis.loanAcnt }</td>
				       	  </tr>
				       	  <tr>
				       	  	<th>이자납입계좌</th>
				       	  	<td>${ loanHis.interestAcnt }</td>
				       	  	<th>이자납부일</th>
				       	  	<td>매달 ${ loanHis.interestDate }일</td>
				       	  </tr>
				       	  <tr>
				       	  	<th>담보유형</th>
				       	  	<td>${ loanHis.assType }</td>
				       	  	<th>대출상품번호</th>
				       	  	<td>${ loanHis.prodNo }</td>
				       	  </tr>
				       	  <tr>
				       	  	<th>사업자등록번호</th>
				       	  	<td>${ loanHis.bizrNo }</td>
				       	  	<th>잔금</th>
				       	  	<td>${ loanHis.leftAmt }</td>
				       	  </tr>
				       	  <tr>
				       	  	<th>이자금액</th>
				       	  	<td><fmt:formatNumber value="${ loanHis.interestAmt }" pattern="###,###,###,###" />원</td>
				       	  </tr>
				       </thead>
				    </table>
				  </div>
				  
                </div>
              </div>
			</div>          
          
          
         </div>
        </div>
	   </div>
        
        
    
    <div class="container-fluid mt--6">
	 <div class="row">
        <div class="col-xl-12">
		    <ul class="nav nav-tabs" id="myTab" role="tablist">
			  <li class="nav-item" role="presentation">
			    <a class="nav-link active" id="rpy-history-tab" data-toggle="tab" href="#rpyHistory" role="tab" aria-controls="rpyHistory" aria-selected="true">상환내역</a>
			  </li>
			  <li class="nav-item" role="presentation">
			    <a class="nav-link" id="interest-tab" data-toggle="tab" href="#interest" role="tab" aria-controls="interest" aria-selected="false">이자납입내역</a>
			  </li>
			</ul>
			
			<div class="tab-content" id="myTabContent">
			
					<!-- 상환내역 -->
					<div class="tab-pane fade show active" id="rpyHistory" role="tabpanel" aria-labelledby="rpy-history-tab">
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
       		 
       		 	 
       		 	 
       		 	<!-- 이자납입내역 -->
				<div class="tab-pane fade" id="interest" role="tabpanel" aria-labelledby="interest-tab">
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
					
				
				</div>	
			
			</div>
			</div>
	 </div>
	
	</div>
	
<jsp:include page="../include/footer.jsp"/>
<jsp:include page="../include/js.jsp" />
</body>
</html>