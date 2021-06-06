<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기업분석</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<style>
#rnk{
	font-size: 6em;
	color: #fd7e14
}
td {
	padding: 1%;
}
th {
	padding: 1%;
	background-color: #EFEFEF;
}
div.scrollmenu {
  overflow: auto; 
  white-space: nowrap;
}
</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script>
function addSymbols(e) {
	var suffixes = ["", "K", "M", "B"];
	var order = Math.max(Math.floor(Math.log(e.value) / Math.log(1000)), 0);
 
	if (order > suffixes.length - 1)
		order = suffixes.length - 1;
 
	var suffix = suffixes[order];
	return CanvasJS.formatNumber(e.value / Math.pow(1000, order)) + suffix;
}
 
function toggleDataSeries(e) {
	if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	} else {
		e.dataSeries.visible = true;
	}
	e.chart.render();
}
function toolTipContent(e) {
	var str = "";
	var total = 0;
	var str2, str3;
	for (var i = 0; i < e.entries.length; i++){
		var  str1 = "<span style= \"color:"+e.entries[i].dataSeries.color + "\"> "+e.entries[i].dataSeries.name+"</span>: $<strong>"+e.entries[i].dataPoint.y+"</strong>bn<br/>";
		total = e.entries[i].dataPoint.y + total;
		str = str.concat(str1);
	}
	str2 = "<span style = \"color:DodgerBlue;\"><strong>"+(e.entries[0].dataPoint.x).getFullYear()+"</strong></span><br/>";
	total = Math.round(total * 100) / 100;
	str3 = "<span style = \"color:Tomato\">Total:</span><strong> $"+total+"</strong>bn<br/>";
	return (str2.concat(str)).concat(str3);
}
function toolTipFormatter(e) {
	var str = "";
	var total = 0 ;
	var str3;
	var str2 ;
	for (var i = 0; i < e.entries.length; i++){
		var str1 = "<span style= \"color:"+e.entries[i].dataSeries.color + "\">" + e.entries[i].dataSeries.name + "</span>: <strong>"+  e.entries[i].dataPoint.y + "</strong> <br/>" ;
		total = e.entries[i].dataPoint.y + total;
		str = str.concat(str1);
	}
	str2 = "<strong>" + e.entries[0].dataPoint.label + "</strong> <br/>";
	str3 = "<span style = \"color:Tomato\">Total: </span><strong>" + total + "</strong><br/>";
	return (str2.concat(str)).concat(str3);
}
                
window.onload = function () {

	var year1 = "${ fn:substring(finList[0].ISSUE_DATE, 0, 4) }";
	var year2 = "${ fn:substring(finList[1].ISSUE_DATE, 0, 4) }";
	var year3 = "${ fn:substring(finList[2].ISSUE_DATE, 0, 4) }";
	//Better to construct options first and then pass it as a parameter
	
	// 주요재무상태
	var chart1 = new CanvasJS.Chart("chartContainer1", {
		
	
		animationEnabled: true,
		toolTip: {
			shared: true,
			reversed: true
		},
		data: [{
			type: "stackedColumn",
			name: "자본",
			showInLegend: "true",
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ y: ${ finList[0].TTL_CAPITAL / 1000000 }, label: year1 },
				{ y: ${ finList[1].TTL_CAPITAL / 1000000 }, label: year2 },
				{ y: ${ finList[2].TTL_CAPITAL / 1000000 }, label: year3 }
			]
		},
		{
			type: "stackedColumn",
			name: "부채",
			showInLegend: "true",
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ y: ${ finList[0].TTL_LIAB / 1000000 }, label: year1 },
				{ y: ${ finList[1].TTL_LIAB / 1000000 }, label: year2 },
				{ y: ${ finList[2].TTL_LIAB / 1000000 }, label: year3 }
			]
		},
		{
			name: "자산",
			type: "spline",
			showInLegend: "true",
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ y: ${ finList[0].TTL_AST / 1000000 }, label: year1 },
				{ y: ${ finList[1].TTL_AST / 1000000 }, label: year2 },
				{ y: ${ finList[2].TTL_AST / 1000000 }, label: year3 }
			]
		}]
	}) 
	
	// 주요 손익계산서
	var chart2 = new CanvasJS.Chart("chartContainer2", {
		
		animationEnabled: true,
		theme: "light2",
		toolTip: {
			shared: true
		},
		legend: {
			cursor: "pointer",
			itemclick: toggleDataSeries
		},
		data: [
			{
				type: "column",
				name: "매출액",
				showInLegend: true,
				xValueFormatString: "MMMM YYYY",
				yValueFormatString: "#,##0백만",
				dataPoints: [
					{ y: ${ finList[0].SALES / 1000000 }, label: year1},
					{ y: ${ finList[1].SALES / 1000000 }, label: year2},
					{ y: ${ finList[2].SALES / 1000000 }, label: year3}
				]
			},
			{
				type: "line",
				name: "영업이익",
				showInLegend: true,
				yValueFormatString: "#,##0백만",
				dataPoints: [
					{ y: ${ finList[0].BUSI_PROFITS / 1000000 }, label: year1 },
					{ y: ${ finList[1].BUSI_PROFITS / 1000000 }, label: year2 },
					{ y: ${ finList[2].BUSI_PROFITS / 1000000 }, label: year3 }
				]
			},
			{
				type: "area",
				name: "당기순이익",
				markerBorderColor: "white",
				markerBorderThickness: 2,
				showInLegend: true,
				yValueFormatString: "#,##0백만",
				dataPoints: [
					{ y: ${ finList[0].NET_INCM / 1000000 }, label: year1 },
					{ y: ${ finList[1].NET_INCM / 1000000 }, label: year2 },
					{ y: ${ finList[2].NET_INCM / 1000000 }, label: year3 }
				]
			}]
	})
	
	// 요약 재무상태표 
	var chart3 = new CanvasJS.Chart("chartContainer3", {
		
		exportEnabled: true,
		animationEnabled: true,
		axisY: {
			includeZero: true
		},
		axisY2: {
			includeZero: true
		},
		toolTip: {
			shared: true
		},
		legend: {
			cursor: "pointer",
			itemclick: toggleDataSeries
		},
		data: [{
			type: "stackedColumn",
			name: "비유동자산",
			showInLegend: true,      
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ label: year1,  y: ${ finList[0].NON_CURR_AST / 1000000 } },
				{ label: year2, y: ${ finList[1].NON_CURR_AST / 1000000 } },
				{ label: year3, y: ${ finList[2].NON_CURR_AST / 1000000 } }
			]
		},{
			type: "stackedColumn",
			name: "유동자산",
			showInLegend: true,      
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ label: year1,  y: ${ finList[0].CURR_AST / 1000000 } },
				{ label: year2, y: ${ finList[1].CURR_AST / 1000000 } },
				{ label: year3, y: ${ finList[2].CURR_AST / 1000000 } }
			]
		},
		{
			type: "stackedColumn",
			name: "자본총계",
			axisYType: "secondary",
			showInLegend: true,
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ label: year1,  y: ${ finList[0].TTL_CAPITAL / 1000000 } },
				{ label: year2, y: ${ finList[1].TTL_CAPITAL / 1000000 } },
				{ label: year3, y: ${ finList[2].TTL_CAPITAL / 1000000 } }
			]
		},{
			type: "stackedColumn",
			name: "비유동부채",
			axisYType: "secondary",
			showInLegend: true,      
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ label: year1,  y: ${ finList[0].NON_CURR_LIAB / 1000000 } },
				{ label: year2, y: ${ finList[1].NON_CURR_LIAB / 1000000 } },
				{ label: year3, y: ${ finList[2].NON_CURR_LIAB / 1000000 } }
			]
		},{
			type: "stackedColumn",
			name: "유동부채",
			axisYType: "secondary",
			showInLegend: true,      
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ label: year1,  y: ${ finList[0].CURR_LIAB / 1000000 } },
				{ label: year2, y: ${ finList[1].CURR_LIAB / 1000000 } },
				{ label: year3, y: ${ finList[2].CURR_LIAB / 1000000 } }
			]
		}]
		
		
	})
	// 요약손익계산서
	var chart4 = new CanvasJS.Chart("chartContainer4", {
		animationEnabled: true,
		axisY: {
			includeZero: true
		},
		legend: {
			cursor:"pointer",
			itemclick : toggleDataSeries
		},
		toolTip: {
			shared: true,
			content: toolTipFormatter
		},
		data: [{
			type: "bar",
			showInLegend: true,
			name: year3,
			color: "gold",
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ y: ${ finList[2].NET_INCM / 1000000 }, label: "당기순이익" },
				{ y: ${ finList[2].BUSI_PROFITS / 1000000 }, label: "영업이익" },
				{ y: ${ finList[2].SALES / 1000000 }, label: "매출액" }
			]
		},
		{
			type: "bar",
			showInLegend: true,
			name: year2,
			color: "silver",
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ y: ${ finList[1].NET_INCM / 1000000 }, label: "당기순이익" },
				{ y: ${ finList[1].BUSI_PROFITS / 1000000 }, label: "영업이익" },
				{ y: ${ finList[1].SALES / 1000000 }, label: "매출액" }
			]
		},
		{
			type: "bar",
			showInLegend: true,
			name: year1,
			color: "#A57164",
			yValueFormatString: "#,##0백만",
			dataPoints: [
				{ y: ${ finList[0].NET_INCM / 1000000 }, label: "당기순이익" },
				{ y: ${ finList[0].BUSI_PROFITS / 1000000 }, label: "영업이익" },
				{ y: ${ finList[0].SALES / 1000000 }, label: "매출액" }
			]
		}]
	})
	// 요약 현금흐름분석 
	var chart5 = new CanvasJS.Chart("chartContainer5", {
		animationEnabled: true,
		toolTip: {
			shared: true
		},
		legend: {
			cursor:"pointer",
			itemclick: toggleDataSeries
		},
		data: [{
			type: "column",
			name: "영업활동현금흐름",
			legendText: "영업활동현금흐름",
			showInLegend: true, 
			yValueFormatString: "#,##0백만",
			dataPoints:[
				{ label: year1,  y: ${ finList[0].SALES_CF / 1000000 } },
				{ label: year2, y: ${ finList[1].SALES_CF / 1000000 } },
				{ label: year3, y: ${ finList[2].SALES_CF / 1000000 } }
			]
		},
		{
			type: "column",	
			name: "재무활동현금흐름",
			legendText: "재무활동현금흐름",
			axisYType: "secondary",
			showInLegend: true,
			yValueFormatString: "#,##0백만",
			dataPoints:[
				{ label: year1,  y: ${ finList[0].FIN_CF / 1000000 } },
				{ label: year2, y: ${ finList[1].FIN_CF / 1000000 } },
				{ label: year3, y: ${ finList[2].FIN_CF / 1000000 } }
			]
		},{
			type: "column",	
			name: "투자활동현금흐름",
			legendText: "투자활동현금흐름",
			axisYType: "secondary",
			showInLegend: true,
			yValueFormatString: "#,##0백만",
			dataPoints:[
				{ label: year1, y: ${ finList[0].INVST_CF / 1000000 } },
				{ label: year2, y: ${ finList[1].INVST_CF / 1000000 } },
				{ label: year3, y: ${ finList[2].INVST_CF / 1000000 } }
			]
		}]
	})
	
	chart1.render();
	chart2.render();
	chart3.render();
	chart4.render();
	chart5.render();
	
	} 

</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">

	<jsp:include page="../include/header.jsp"/>
	<!----------------------------------- 기업 개황------------------------------------>
		<img src="${ pageContext.request.contextPath }/resources/images/analysis_banner.png"
		style="width: 100%; height: 450px;">		
	<div class="container" id="changeable">
		<h3 class="title">
			<b>${ userVO.name } 기업분석</b>
		</h3>

		<div class="card">
		  <div class="card-body">
		    <h5 style="color: rgba(233, 117, 80)">
		    	<img src="https://img.icons8.com/cute-clipart/30/000000/error.png"/>
		    	<b>주의</b>
		    </h5>
		    <ul>
				<li>기업분석 서비스는 서류보관함에서 재무제표 업로드 후 이용할 수 있습니다.</li>
		    </ul>
		  </div>
		</div>
		
		<h4 class="subtitle">기업 프로필</h4>
		<table class="table">
			<tr>
				<th>기업체명</th>
				<td>${ userVO.name }</td>
				<th>영문기업명</th>
				<td>${ userVO.nameEng }</td>
			</tr>
			<tr>
				<th>사업자번호</th>
				<td>${ userVO.bizrNo }</td>
				<th>법인(주민)번호</th>
				<td>${ userVO.jurirNo }</td>
			</tr>
			<tr>
				<th>대표자명</th>
				<td>
					<c:if test="${ not empty repList }">
					<c:forEach items="${ repList }" var="rep" varStatus="loop">
						<c:if test="${ loop.count ne 1 }">
							,
						</c:if>
						${ rep.repName }
					</c:forEach>	
					</c:if>			
				</td>
				<th>법인구분</th>
				<td>${ userVO.corpCls }</td>
			</tr>
			<tr>
				<th>업종</th>
				<td>${ userVO.indutyCode }</td>
				<th>홈페이지</th>
				<td>${ userVO.hmUrl }</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<c:if test="${ not empty userVO.phnNo }">
						+${ userVO.countryCode } ${ userVO.phnNo }
					</c:if>
				</td>
				<th>팩스번호</th>
				<td>
					<c:if test="${ not empty userVO.faxNo }">
						+${ userVO.countryCodeFax } ${ userVO.faxNo }
					</c:if>	
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3">${ userVO.adres }</td>
			</tr>
			<tr>
				<th>설립일</th>
				<td colspan="3">${ userVO.estDt }</td>
			</tr>
			
		</table>

		<div class="blank"></div>
		<hr>
		<h4 class="subtitle">기업 신용등급</h4>
		<div class="card">
		  <div class="card-body">
		  <div class="container">
		  <div class="row">
		  <div class="col">
		    <table class="table">
		    	<tr>
		    		<td>재무기준</td>
		    		<td rowspan="2">
		    			<div id="rnk">
		    				${ creditRnkList[2].CREDIT_RNK }
		    			</div>
		    		</td>
		    				
		    	</tr>
		    	<tr>
		    		<td>${ creditRnkList[2].FNC_STMT_DATE }</td>
		    	</tr>
		    </table>
		  </div>
		  <div class="col">
		    <table class="table">
		    	<tr>
		    		<th>등급</th>
		    		<th>평가(산출)일자</th>
		    		<th>재무기준일자</th>
		    	</tr>
		    	<tr>
		    		<th>${ creditRnkList[0].CREDIT_RNK }</th>
		    		<td>${ creditRnkList[0].RNK_DATE }</td>
		    		<td>${ creditRnkList[0].FNC_STMT_DATE }</td>
		    	</tr>
		    	<tr>
		    		<th>${ creditRnkList[1].CREDIT_RNK }</th>
		    		<td>${ creditRnkList[1].RNK_DATE }</td>
		    		<td>${ creditRnkList[1].FNC_STMT_DATE }</td>
		    	</tr>
		    	<tr>
		    		<th>${ creditRnkList[2].CREDIT_RNK }</th>
		    		<td>${ creditRnkList[2].RNK_DATE }</td>
		    		<td>${ creditRnkList[2].FNC_STMT_DATE }</td>
		    	</tr>
		    </table>
		  </div>
		  </div>
		  </div>
		  </div>
		</div>
	</div>
<!---------------------------------- 데이터 시각화 ---------------------------------->	
<!-- 3개년 년도 설정 -->	
<c:set var="year1" value="${ fn:substring(finList[0].ISSUE_DATE, 0, 4) }"/>	
<c:set var="year2" value="${ fn:substring(finList[1].ISSUE_DATE, 0, 4) }"/>	
<c:set var="year3" value="${ fn:substring(finList[2].ISSUE_DATE, 0, 4) }"/>	

		
		<div class="blank"></div>
			<div class="container">
			<hr>
				<h4 class="subtitle">요약 재무비율</h4>
				<div class="row">
					<!-- 성장성 -->
					<div class="col">
						<table class="table" >
							<tr>
								<th>성장성</th>
								<th>${ year2 }</th>
								<th>${ year3 }</th>
							</tr>
							<tr>
								<th>총자산증가율</th>
								<c:if test="${ fn:length(finList) >= 2 }">
								<c:forEach begin="0" end="${ fn:length(finList) - 2 }" var="i" >
									<td>
										<fmt:formatNumber type="number" pattern="0.00" value="${ finList[i+1].TTL_AST / finList[i].TTL_AST * 100 - 100 }"/></td>
								</c:forEach>
								</c:if>
							</tr>
							<tr>
								<th>매출증가율</th>
								<c:if test="${ fn:length(finList) >= 2 }">
								<c:forEach begin="0" end="${ fn:length(finList) - 2 }" var="i" >
									<td>
										<fmt:formatNumber type="number" pattern="0.00" value="${ finList[i+1].SALES / finList[i].SALES * 100 - 100 }"/></td>
								</c:forEach>	
								</c:if>		
							</tr>
							<tr>
								<th>순이익증가율</th>
								<c:if test="${ fn:length(finList) >= 2 }">
								<c:forEach begin="0" end="${ fn:length(finList) - 2 }" var="i" >
									<td>
										<fmt:formatNumber type="number" pattern="0.00" value="${ finList[i+1].NET_INCM / finList[i].BUSI_PROFITS * 100 - 100 }"/></td>
								</c:forEach>		
								</c:if>
							</tr>
						</table>
					</div>
					<!-- 수익성 -->
					<div class="col">
						<table class="table">
							<tr>
								<th>수익성</th>
								<th>${ year1 }</th>
								<th>${ year2 }</th>
								<th>${ year3 }</th>
							</tr>
							<tr>
								<th>영업이익률</th>
								<c:if test="${ fn:length(finList) >= 1 }">
								<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
									<td>
										<fmt:formatNumber type="number" pattern="0.00" value="${ finList[i].BUSI_PROFITS / finList[i].SALES * 100 - 100 }"/></td>
								</c:forEach>	
								</c:if>
							</tr>
							<tr>
								<th>ROE</th>
								<c:if test="${ fn:length(finList) >= 1 }">
								<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
									<td>
										<fmt:formatNumber type="number" pattern="0.00" value="${ finList[i].NET_INCM / finList[i].TTL_CAPITAL * 100 - 100 }"/></td>
								</c:forEach>	
								</c:if>
							</tr>
						</table>
					</div>
					<!-- 안정성 -->
					<div class="col">
					<table class="table" >
						<tr>
							<th>안정성</th>
							<th>${ year1 }</th>
							<th>${ year2 }</th>
							<th>${ year3 }</th>
						</tr>
						<tr>
							<th>부채비율</th>
							<c:if test="${ fn:length(finList) >= 1 }">
							<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
								<td>
									<fmt:formatNumber type="number" pattern="0.00" value="${ (( finList[i].CURR_LIAB + finList[i].NON_CURR_LIAB ) / finList[i].CAPITAL ) * 100 }"/></td>
							</c:forEach>
							</c:if>	
						</tr>
					</table>
				</div>
				</div>
			</div>
		
		<div class="blank"></div>
		<div class="container">
		<hr>
			<h4 class="subtitle">주요 재무정보</h4>
			<div class="blank"></div>
			<div class="card">
		  	<div class="card-body">
			<h5 style="display:inline; color: black">주요 재무상태표</h5>
			<p style="float:right">단위 : 백만</p>
			<table class="table">
				<tr>
					<th></th>
					<th>${ year1 }</th>
					<th>${ year2 }</th>
					<th>${ year3 }</th>
				</tr>
				<tr>
					<th>자산총계</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].TTL_AST / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>부채총계</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].TTL_LIAB / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>자본총계</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].TTL_CAPITAL / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
			</table>
			
			<div class="blank"></div>
			<div id="chartContainer1" style="height: 300px; width: 100%;"></div>
			</div>
			</div>
			<div class="blank"></div>
			<div class="blank"></div>
			
			
			<div class="card">
		  	<div class="card-body">
			<h5 style="display:inline; color: black">주요 손익계산서</h5>
			<p style="float:right">단위 : 백만</p>
			<table class="table">
				<tr>
					<th></th>
					<th>${ year1 }</th>
					<th>${ year2 }</th>
					<th>${ year3 }</th>
				</tr>
				<tr>
					<th>매출액</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].SALES / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>영업이익</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].BUSI_PROFITS / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>당기순이익</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].NET_INCM / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
			</table>
			
			<div class="blank"></div>
			<div id="chartContainer2" style="height: 300px; width: 100%;"></div> 
			</div>
			</div>
			<div class="blank"></div>
			<div class="blank"></div>
			
			<hr>
			
			<h4 class="subtitle">재무제표 요약</h4>
			<div class="blank"></div>
			<div class="card">
		  	<div class="card-body">
			<h5 style="display:inline; color: black">요약 재무상태표</h5>
			<p style="float:right">단위 : 백만</p>
			<table class="table">
				<tr>
					<th></th>
					<th>${ year1 }</th>
					<th>${ year2 }</th>
					<th>${ year3 }</th>
				</tr>
				<tr>
					<th>유동자산</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].CURR_AST / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>비유동자산</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].NON_CURR_AST / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>자산총계</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].TTL_AST / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>유동부채</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].CURR_LIAB / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>비유동부채</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].NON_CURR_LIAB / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>부채총계</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].TTL_LIAB / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>자본금</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].CAPITAL / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>자본총계</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].TTL_CAPITAL / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
			</table>
			
			<div class="blank"></div>
			<div id="chartContainer3" style="height: 300px; width: 100%;"></div> 
			</div>
			</div>
			<div class="blank"></div>
			<div class="blank"></div>
			
			
			<div class="card">
		  	<div class="card-body">
			<h5 style="display:inline; color: black">요약 손익계산서</h5>
			<p style="float:right">단위 : 백만</p>
			<table class="table">
				<tr>
					<th></th>
					<th>${ year1 }</th>
					<th>${ year2 }</th>
					<th>${ year3 }</th>
				</tr>
				<tr>
					<th>매출액</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].SALES / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>영업이익</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].BUSI_PROFITS / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>당기순이익</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].NET_INCM / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
			</table>
			
			<div class="blank"></div>
			<div id="chartContainer4" style="height: 300px; width: 100%;"></div> 
			</div>
			</div>
			<div class="blank"></div>
			<div class="blank"></div>
			
			
			<div class="card">
		  	<div class="card-body">
			<h5 style="display:inline; color: black">요약 현금흐름분석</h5>
			<p style="float:right">단위 : 백만</p>
			<table class="table">
				<tr>
					<th></th>
					<th>${ year1 }</th>
					<th>${ year2 }</th>
					<th>${ year3 }</th>
				</tr>
				<tr>
					<th>영업활동현금흐름</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].SALES_CF / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>투자활동현금흐름</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].INVST_CF / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
				<tr>
					<th>재무활동현금흐름</th>
					<c:if test="${ fn:length(finList) >= 1 }">
					<c:forEach begin="0" end="${ fn:length(finList) - 1 }" var="i" >
						<td>
							<fmt:formatNumber type="number" pattern="###,###,###,###" value="${ finList[i].FIN_CF / 1000000 }"/>
						</td>
					</c:forEach>
					</c:if>
				</tr>
			</table>
			
			<div class="blank"></div>
			<div id="chartContainer5" style="height: 300px; width: 100%;"></div> 
			</div>
			</div>
			<div class="blank"></div>
			<div class="blank"></div>
			
		</div>
		
	<jsp:include page="../include/footer.jsp"/>
	
<jsp:include page="../include/js.jsp" />
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>


</body>
</html>