<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<jsp:include page="/WEB-INF/jsp/include/cssEmp.jsp" />
<style>
.card-title {
	color: #525f7f !important;
}
.smallLetter{
	font-size: 13px; 
	color: gray;
	float: left;
}
.number {
	font-size: 40px;
	color: rgba(233, 117, 80);
}
</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script>
$(document).ready(function() {
	$('#reload').click(function() {
		location.reload();	
	})
	/* 
		심사하기 버튼 클릭시 심사 페이지로 이동 
	*/
	$('#evaluate').click(function() {
	 	let appNo = $('input:radio[name=loanAppRadio]:checked').val()
	 	if(appNo == undefined){
	 		alert('신규 대출을 선택하세요.')
	 		return;
	 	} else {
	 		location.href = '${ pageContext.request.contextPath }/emp/loanEval/' + appNo;
	 	}
	})
	
	/* 
		관심 대출 클릭시 
	*/
	$('.focusGroup').click(function() {
		let loanNo = $(this).attr('id');
		console.log(loanNo)
		location.href = '${ pageContext.request.contextPath }/emp/loanMng/' + loanNo;
	})
})	
/* 
	대출 신청 페이징 ajax - 클릭된 페이지 수에 맞춰 controller에서 해당 페이지의 글을 받아옴 
*/
function goPaging(pageNo){
	$.ajax({
		url : '${ pageContext.request.contextPath }/emp/loanApp',
		type : 'post',
		data : {
			'blockNo' : ${ blockNo },
			'pageNo' : pageNo
		},
		success : function(data) {

			$('#loanAppTbl').empty();
			$('#loanAppTbl').append(data);
			
		},
		error : function(result) {
			alert('error')
		}
	})
}
/*
 * 대출 내역 페이징 ajax 
 */
function goPaging2(pageNo2){
	
	
	$.ajax({
		url : '${ pageContext.request.contextPath }/emp/loanHis',
		type : 'post',
		data : {
			'blockNo2' : ${ blockNo2 },
			'pageNo2' : pageNo2
		},
		success : function(data) {
			$('#loanHisTable').empty();
			$('#loanHisTable').append(data);
			
		},
		error : function(result) {
			alert('error')
		}
	})
}

function goManage() {
	let loanNo = $('input:radio[name=loanHisRadio]:checked').val()
 	if(loanNo == undefined){
 		alert('기존 대출을 선택하세요.')
 		return;
 	} else {
 		location.href = '${ pageContext.request.contextPath }/emp/loanMng/' + loanNo;
 	}
}
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
		               return value + '건';
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
		             //content += '<span class="popover-body-label mr-auto">' + label + '</span>';
		             content += label;
		           }
		
		           //content += '<span class="popover-body-value">' + yLabel + '건</span>';
		           content += yLabel + '건';
		           return content;
		         }
		       }
		     }
		   },
		   
		   data: {
		     labels: ['2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월'],
		     datasets: [{
		       label: '담당대출건수',
		       data: [
		    	   ${ loanHisByMonMap.mon2 },
		    	   ${ loanHisByMonMap.mon3 },
		    	   ${ loanHisByMonMap.mon4 },
		    	   ${ loanHisByMonMap.mon5 },
		    	   ${ loanHisByMonMap.mon6 },
		    	   ${ loanHisByMonMap.mon7 },
		    	   ${ loanHisByMonMap.mon8 },
		    	   ${ loanHisByMonMap.mon9 }
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
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">




	<jsp:include page="../include/empHeader.jsp"/>
	<!-- <div class="container" id="changeable" align="center"> -->
	<div class="header bg-primary pb-6">
      <div class="container-fluid">
        <div class="header-body">
          <div class="row align-items-center py-4">
            <div class="col-lg-6 col-7">
            </div>
            <div class="col-lg-6 col-5 text-right">
              <a href="#" class="btn btn-sm btn-neutral" id="reload">New</a>
            </div>
          </div>
		<div class="row">
            <div class="col-xl-3 col-md-6">
              <h1 class="h2 text-white d-inline-block mb-0" style="font-size: 30px;">${ empVO.ename }님, <br>오늘도 하나은행이 응원합니다 :)</h1>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card card-stats">
                <!-- Card body -->
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase text-muted mb-0">신규 대출 신청</h5>
                      <span class="h2 font-weight-bold mb-0 number">${ totalBoardCnt }건</span>
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow">
                        <i class="ni ni-active-40"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card card-stats">
                <!-- Card body -->
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase text-muted mb-0">담당 대출</h5>
                      <span class="h2 font-weight-bold mb-0 number">${ totalBoardCnt2 }건</span> 
                      <!-- <span class="h2 font-weight-bold mb-0 number">건</span> -->
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-gradient-orange text-white rounded-circle shadow">
                        <i class="ni ni-chart-pie-35"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card card-stats">
                <!-- Card body -->
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase text-muted mb-0">우리지점 신규대출건수</h5>
                      <span class="h2 font-weight-bold mb-0 number">231건</span>
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-gradient-green text-white rounded-circle shadow">
                        <i class="ni ni-money-coins"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- <div class="col-xl-3 col-md-6">
              <div class="card card-stats">
                Card body
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase text-muted mb-0">Performance</h5>
                      <span class="h2 font-weight-bold mb-0 number">49,65%</span>
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow">
                        <i class="ni ni-chart-bar-32"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> -->
          </div>
      	</div>
      </div>
     </div>
     
     
        <!------------------------------ Page content ------------------------------>
    <div class="container-fluid mt--6">
      <div class="row">
        <div class="col-xl-8">
          <div class="card bg-default">
            <div class="card-header bg-transparent">
              <div class="row align-items-center">
                <div class="col">
                  <h6 class="text-light text-uppercase ls-1 mb-1">Overview</h6>
                  <h5 class="h3 text-white mb-0">${ empVO.ename }님의 대출건수 추이</h5>
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
        <div class="col-xl-4">
          <div class="card">
            <div class="card-header bg-transparent">
              <div class="row align-items-center">
                <div class="col">
                  <h6 class="text-uppercase text-muted ls-1 mb-1">Performance</h6>
                  <h5 class="h3 mb-0">우리지점 신규대출건수 추이</h5>
                </div>
              </div>
            </div>
            <div class="card-body">
              <!-- Chart -->
              <div class="chart">
                <canvas id="chart-bars" class="chart-canvas"></canvas>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-xl-8">
          <div class="card">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">신규 대출 신청 목록</h3>
                </div>
                <div class="col text-right">
                  <a class="btn btn-sm btn-primary" id="evaluate" style="color: white">심사</a>
                </div>
              </div>
            </div>
            
            <div id="loanAppTbl">
            <div class="table-responsive">
              <!-- Projects table -->
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
                <tbody>
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
            </div>
    		        
	
	
	
	
          </div>
        </div>
        <div class="col-xl-4">
          <div class="card">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0"><i class="ni ni-user-run"></i>&nbsp;&nbsp;우리지점 대출왕 [ ${ empVO.branchNm } ]</h3>
                </div>
              </div>
            </div>
            <div class="table-responsive">
              <!-- Projects table -->
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                  	<th scope="col"></th>
                    <th scope="col">사원번호</th>
                    <th scope="col">사원이름</th>
                    <th scope="col">신규대출건수</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${ empList }" var="emp" varStatus="loop">
                	<c:if test="${ loop.count <= 6 }">
		                <tr>
		                	<td>
				                <img src="${ pageContext.request.contextPath }/resources/images/badge-1.png" style="width: 20px; height: 20px;">
			                	${ loop.count }
		                	</td>
		                	<td>${ emp.empno }</td>
		                	<td>${ emp.ename }</td>
		                	<td>${ emp.cnt }건</td>
		                </tr>
	                </c:if>
                </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
      
      <div class="row">
        <div class="col-xl-8">
          <div class="card">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">기존 담당 대출 목록</h3>
                </div>
                <div class="col text-right">
                  <a href="javascript:goManage()" id="loanManageBtn" class="btn btn-sm btn-primary">관리</a>
                </div>
              </div>
            </div>
            
            <div id="loanHisTable">
            <div class="table-responsive">
              <!-- Projects table -->
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
						<a href="<%=request.getContextPath()%>/emp/loanHis?blockNo2=${ blockNo2 -1 }&pageNo2=${ blockStartPageNo2-1 }" >이전</a> &nbsp; 
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
					<a href="<%=request.getContextPath()%>/emp/loanHis?blockNo2=${ blockNo2+1 }&pageNo2=${ blockEndPageNo2+1 }" >다음</a> &nbsp; 
				</c:if>
				</div>
				<!------------------------------------ 페이징 끝 ------------------------------------>
			</div>
          </div>
          </div>
          
          
          <div class="col-xl-4">
          <div class="card">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">나의 관심대출</h3>
                </div>
                <div class="blank"></div>
                
                <c:forEach items="${ focusLoanHisList }" var="loanHis" varStatus="loop">
		
						<div class="card focusGroup" id="${ loanHis.loanNo }" style="width: 100%" >
						
					 		 <div class="card-body">
					 		 	<h3 class="card-text" style="text-align: center;">
					 		 		<span class="smallLetter">${ loanHis.prodName }</span>
					 		 		<span class="smallLetter" style="float: right">계좌&nbsp;${ loanHis.loanAcnt }</span><br>
						 		 	<span class="smallLetter">잔금</span>
						 		 	<span style="color: red; float: right;"><b><fmt:formatNumber value="${ loanHis.leftAmt }" pattern="###,###,###,###" /></b></span><br>			 		 		
						 		 	<span class="smallLetter">금리</span>
						 		 	<span style="color: blue; float: right;"><b>${ loanHis.interest }%</b></span><br>			 		 		
					 		 		<span class="smallLetter">사업자등록번호</span>
					 		 		<span style="float: right; font-size: 13px;">${ loanHis.bizrNo }</span>
					 		 	</h3>
					 		 </div>
					 	</div>
				</c:forEach>
		
		
              </div>
            </div>
           </div>
          </div>
            
            
            
        </div>
       </div> 
        
        
        
      
		
	<!-- </div> -->
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />

</body>

</html>