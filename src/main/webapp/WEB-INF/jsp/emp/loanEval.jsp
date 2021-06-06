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
<title>대출심사</title>
<jsp:include page="/WEB-INF/jsp/include/cssEmp.jsp" />
<style>
.card-title {
	color: #525f7f !important;
}
#rnk{
	font-size: 6em;
	color: #fd7e14
}
.greens {
	color: rgba(64, 146, 143);
}
.nav-link {
	color: white;
}
.nav-link:hover {
	color: orange;
}

#approve{
	background-color: white;
	border-color: rgba(64, 146, 143);
	color: rgba(64, 146, 143);
} 
#viewDart{
	background-color: white;
	border-color: rgba(64, 146, 143);
	color: rgba(64, 146, 143);
}
#scndEval{
	background-color: white;
	border-color: rgba(64, 146, 143);
	color: rgba(64, 146, 143);
}
.steps {
	color: #f57102;
	font-size: 30px;
}
#scndEvalModal{
	padding: 1%;
}
#refuseRsn {
	width: 100%;
	height: 50%;
}
.complete {
	display: none;
}
/* Style the form */
#regForm {
  background-color: #ffffff;
  margin: 100px auto;
  padding: 40px;
  width: 70%;
  min-width: 300px;
}

/* Style the input fields */
input {
  padding: 10px;
  width: 100%;
  font-size: 17px;
  font-family: Raleway;
  border: 1px solid #aaaaaa;
}

/* Mark input boxes that gets an error on validation: */
input.invalid {
  background-color: #ffdddd;
}

/* Hide all steps by default: */
.tab {
  display: none;
  margin: 2%;
  padding: 4%;
  border: 1px solid rgba(88, 79, 84);
  border-radius: 20px;
  box-shadow: 3px 3px gray;
}

/* Make circles that indicate the steps of the form: */
.step {
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbbbbb;
  border: none;
  border-radius: 50%;
  display: inline-block;
  opacity: 0.5;
}

/* Mark the active step: */
.step.active {
  opacity: 1;
}

/* Mark the steps that are finished and valid: */
.step.finish {
  background-color: #4CAF50;
}
#aiImg {
	width: 100%;
	height: 40%;
	position: relative;
}
</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
<script type="text/javascript" async src="https://tenor.com/embed.js"></script>
<script>
$(document).ready(function() {
	/* 서류 다운로드 */
	 $('#download').click(function() {
		 let docNo = $('input:radio[name="docRadio"]:checked').val()
		 console.log(docNo);
		 if(docNo == null){
			 alert('다운로드할 서류를 선택하세요.')
		 } else {
			 location.href = '${ pageContext.request.contextPath }/emp/doc/' + docNo; 
		 }
		 
	 })
	 
	 /* 상환내역 조회 */
	 $('#repay').click(function() {
		 let loanNo = $('input:radio[name="loanHisRadio"]:checked').val()
		 console.log(loanNo);
		 if(loanNo == null){
			 alert('상환내역을 조회할 대출내역을 선택하세요.')
		 } else {
			 $.ajax({
					url : '${ pageContext.request.contextPath }/emp/rpy/' + loanNo,
					type : 'post',
					success : function(data) {

						$('#loanRpy').empty();
						$('#loanRpy').append(data);
						
					},
					error : function(result) {
						alert('error')
					}
				})
		 }
		 
		 
		 
	 })
})
/*
	대출내역 페이징 ajax - 클릭된 페이지 수에 맞춰 controller에서 해당 페이지의 글을 받아옴 
*/
function goPaging2(pageNo2){

	console.log(${ blockNo2 })
	console.log(pageNo2)
	
	$.ajax({
		url : '${ pageContext.request.contextPath }/emp/loanEval/loanHis',
		type : 'post',
		data : {
			'blockNo2' : ${ blockNo2 },
			'pageNo2' : pageNo2,
			'bizrNo' : ${ corp.bizrNo }
		},
		success : function(data) {
			console.log('성공')
			console.log(data)
			$('#loanHisTable').empty();
			$('#loanHisTable').append(data);
			
		},
		error : function(result) {
			alert('error')
		}
	})
}

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

$(document).ready(function() {

	/* 
		dart에 올라간 재무제표 바로 확인하기 
	*/
	$('#viewDart').click(function() {
		
		let bizrNo = ${ corp.bizrNo }
		let year = $('#yearSelector').val()
		
		$.ajax({
	      	url : '${ pageContext.request.contextPath }/emp/loanEval',
	      	type : 'post',
	      	async : false,
	      	data : {
	      		'bizrNo' : bizrNo,
	      		'year' : year
	      	},
	      	success : function(data) {
	      		let len = data.length;
	      		let rcept_no = data.substring(1, len - 1);
			    let url = 'http://dart.fss.or.kr/dsaf001/main.do?rcpNo=' + rcept_no;
				window.open(url, "_blank");
	      	}, error : function() {
	      		alert('바깥쪽 실패')
	      	}
     	}) 
	
	}) 
	
	/* 
		대출 승인 버튼 
	$('#approveModalBtn').click(function() {
		location.href = '${ pageContext.request.contextPath }/emp/loanEvalApprove/${ loanApp.appNo }'
	})
	*/

	/* 
		대출 기각 버튼 
	*/
	$('#refuseModalBtn').click(function() {
		let reason = $('#reasonSelector').val()
		location.href = '${ pageContext.request.contextPath }/emp/loanEvalRefuse/${ loanApp.appNo }/' + reason
		
	})
	/* 
		AI 금리심사 요청 버튼 
	*/
	$('#scndEvalModalBtn').click(function() {
		
		/* 
			파이썬과 연동 
		*/
		if(${ not empty finList[2].BUSI_PROFITS and not empty finList[2].NET_INCM and not empty finList[2].TTL_LIAB and not empty creditRnkList[2].CREDIT_RNK }){
			$('#scndEvalModalBody').empty()
			let str0 = '';
			str0 += '<div class="card" style="border: 1px solid  rgba(64, 146, 143)">';
			str0 += '<div class="card-body">';
			str0 += '<img src="${ pageContext.request.contextPath }/resources/images/blog-AI.gif" id="aiImg">'		
			
			str0 += '</div></div>';
			$('#scndEvalModalBody').append(str0);
			$('#scndEvalModalFooter').empty()

			let busi_profits = ${ finList[2].BUSI_PROFITS }
			let net_incm = ${ finList[2].NET_INCM }
			let ttl_liab = ${ finList[2].TTL_LIAB }
			let credit_rnk = '${ creditRnkList[2].CREDIT_RNK }'
			
			
			if(credit_rnk == 'AAA'){
				credit_rnk = 1;
			} else if(credit_rnk = 'AA'){
				credit_rnk = 2;
			} else if(credit_rnk = 'A'){
				credit_rnk = 3;
			} else if(credit_rnk = 'BBB'){
				credit_rnk = 4;
			} else if(credit_rnk = 'BB'){
				credit_rnk = 5;
			} else if(credit_rnk = 'B'){
				credit_rnk = 6;
			} else if(credit_rnk = 'CCC'){
				credit_rnk = 7;
			} else if(credit_rnk = 'CC'){
				credit_rnk = 8;
			} else if(credit_rnk = 'C'){
				credit_rnk = 9;
			} else {
				credit_rnk = 10;
			}
			console.log('파이썬 호출...')
 			$.ajax({
		      	url : '${ pageContext.request.contextPath }/emp/ML',
		      	type : 'get',
		      	data : {
		      		'param_busi_profits' : busi_profits,
		      		'param_net_incm' : net_incm,
		      		'param_ttl_liab' : ttl_liab,
		      		'param_credit_rnk' : credit_rnk
		      	},
		      	success : function(interest) {
		      		setTimeout(function() {
			      		$('#scndEvalModal').modal('hide')
			      		$('.modal-backdrop').hide();
			      		str = '';
			      		str += '<div style="padding: 2%; margin: 2%; border: 4px solid rgba(233, 117, 80);">'
			      		str += '<h2 style="text-align: center; margin: 2%">AI 대출금리 심사 결과 : ' + '<span style="color: blue; size=16px">' + interest + '</span>%</h2>'	      			
		      			str += '<h3 style="text-align: center; margin: 2%">오차 : 0.084%</h3>'
		      			str += '</div>'
		      			$('#AIinterest').append(str)
		      		}, 5000);
		      	}, error : function() {
		      		alert('실패')
		      	}
	     	})  
		} else {
			alert('AI 대출금리 심사를 위한 데이터가 충분하지 않습니다. STEP3로 넘어가주세요. ')
		}
		
		
	})
	
	
})

/* 
	진행중 / 완료 대출 보는 토글버튼 
*/
function changeStatus() {
	// 완료된 대출만, 진행중인 대출만 보이기 
	if(!$(this).is(':checked')){
		$('.ing').toggle()
		$('.complete').toggle()
	} 
}
/* 
	이자납입내역 조회 및 페이징 ajax
*/
function interestAjax(blockNo, pageNo) {
	let loanNo = $('#selectAcnt').val();
	/* console.log('loanNo : ' + loanNo)
	console.log('pageNo : ' + pageNo)
	console.log('blockNo : ' + blockNo) */
	
	$.ajax({
      	url : '${ pageContext.request.contextPath }/emp/loanEval/interest',
      	type : 'post',
      	data : {
      		'loanNo' : loanNo,
      		'pageNo' : pageNo,
      		'blockNo' : blockNo
      	},
      	success : function(data) {
			$('#loanHisInterestAjax').empty();
			$('#loanHisInterestAjax').append(data);
			
      	}, error : function() {
      		alert('실패')
      	}
 	}) 
}

/* 
	STEPPER JS
*/
$(document).ready(function() {
	currentTab = 0; // Current tab is set to be the first tab (0)
	showTab(currentTab); // Display the current tab	
})

function showTab(n) {
  // This function will display the specified tab of the form ...
  var x = document.getElementsByClassName("tab");
  x[n].style.display = "block";
  // ... and fix the Previous/Next buttons:
  if (n == 0) {
    document.getElementById("prevBtn").style.display = "none";
  } else {
    document.getElementById("prevBtn").style.display = "inline";
  }
  if (n == (x.length - 1)) {
    document.getElementById("nextBtn").innerHTML = "승인";
  } else {
    document.getElementById("nextBtn").innerHTML = "다음";
  }
  // ... and run a function that displays the correct step indicator:
  fixStepIndicator(n)
}

function nextPrev(n) {
  // This function will figure out which tab to display
  var x = document.getElementsByClassName("tab");
  // Exit the function if any field in the current tab is invalid:
  /* if (n == 1 && !validateForm() ) return false; */
  // Hide the current tab:
  x[currentTab].style.display = "none";
  // Increase or decrease the current tab by 1:
  currentTab = currentTab + n;
  // if you have reached the end of the form... :
  if (currentTab >= x.length) {
    //...the form gets submitted:
    
    document.getElementById("evalForm").submit();
    return false;
  }
  // Otherwise, display the correct tab:
  showTab(currentTab);
}

function validateForm() {
  // This function deals with validation of the form fields
  var x, y, i, valid = true;
  x = document.getElementsByClassName("tab");
  y = x[currentTab].getElementsByTagName("input");
  // A loop that checks every input field in the current tab:
  for (i = 0; i < y.length; i++) {
    // If a field is empty...
    if (y[i].value == "") {
      // add an "invalid" class to the field:
      y[i].className += " invalid";
      // and set the current valid status to false:
      valid = false;
    }
  }
  // If the valid status is true, mark the step as finished and valid:
  if (valid) {
    document.getElementsByClassName("step")[currentTab].className += " finish";
  }
  return valid; // return the valid status
}

function fixStepIndicator(n) {
  // This function removes the "active" class of all steps...
  var i, x = document.getElementsByClassName("step");
  for (i = 0; i < x.length; i++) {
    x[i].className = x[i].className.replace(" active", "");
  }
  //... and adds the "active" class to the current step:
  x[n].className += " active";
}


</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/empHeader.jsp"/>
<!-- 3개년 년도 설정 -->	
<c:set var="year1" value="${ fn:substring(finList[0].ISSUE_DATE, 0, 4) }"/>	
<c:set var="year2" value="${ fn:substring(finList[1].ISSUE_DATE, 0, 4) }"/>	
<c:set var="year3" value="${ fn:substring(finList[2].ISSUE_DATE, 0, 4) }"/>	

<!--------------------------- 대출승인 모달 ----------------------------->
<div class="modal" id="approveModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">대출승인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>대출을 승인하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="approveModalBtn">승인</button>
      </div>
    </div>
  </div>
</div>
<!--------------------------- 대출기각 모달 ----------------------------->
<div class="modal" id="refuseModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">대출기각</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>대출을 기각하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="refuseModalBtn">기각</button>
      </div>
    </div>
  </div>
</div>
<!---------------------------2차심사 모달 ----------------------------->
<div class="modal" id="scndEvalModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">AI 대출금리 심사요청</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="scndEvalModalBody">
        <p>다음의 내용으로 대출금리 심사를 요청합니다. </p>
        <div class="table-responsive" >
	        <table class="table align-items-center table-flush">
				<thead class="thead-light">
					<tr>
						<th scope="col">사업자등록번호</th>
						<td>${ loanApp.bizrNo }</td>
						<th scope="col">대출상품 이름</th>
						<td>${ loanApp.prodName }</td>
					</tr>
					<tr>
						<th scope="col">신청일</th>
						<td>${ loanApp.appDate }</td>
						<th scope="col">대출유형</th>
						<td>${ loanApp.loanType }</td>
					</tr>
					<tr>	
						<th scope="col">대출계좌</th>
						<td>${ loanApp.loanAcnt }</td>
						<th scope="col">이자납부계좌</th>
						<td>${ loanApp.interestAcnt }</td>
					</tr>
					<tr>
						<th scope="col">신청금액</th>
						<td><fmt:formatNumber value="${ loanApp.appAmount }" pattern="###,###,###,###" /> 원</td>
						<th scope="col">대출기간</th>
						<td>${ loanApp.appMonth } 개월</td>
					</tr>
					<tr>	
						<th scope="col">담보유형</th>
						<td>${ loanApp.assType }</td>
						<th scope="col">지점명</th>
						<td>${ loanApp.branchNm }</td>
					</tr>
					</thead>
		      </table>
		 </div>
      </div>
      <div class="modal-footer" id="scndEvalModalFooter">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="scndEvalModalBtn">요청</button>
      </div>
    </div>
  </div>
</div>
<%-- <!---------------------------2차심사 모달 ----------------------------->
<div class="modal" id="scndEvalModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">2차심사 요청</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="scndEvalModalBody">
        <p>다음의 내용으로 2차심사를 요청합니다. </p>
        <div class="table-responsive" >
	        <table class="table align-items-center table-flush">
				<thead class="thead-light">
					<tr>
						<th scope="col">사업자등록번호</th>
						<td>${ loanApp.bizrNo }</td>
						<th scope="col">대출상품 이름</th>
						<td>${ loanApp.prodName }</td>
					</tr>
					<tr>
						<th scope="col">신청일</th>
						<td>${ loanApp.appDate }</td>
						<th scope="col">대출유형</th>
						<td>${ loanApp.loanType }</td>
					</tr>
					<tr>	
						<th scope="col">대출계좌</th>
						<td>${ loanApp.loanAcnt }</td>
						<th scope="col">이자납부계좌</th>
						<td>${ loanApp.interestAcnt }</td>
					</tr>
					<tr>
						<th scope="col">신청금액</th>
						<td><fmt:formatNumber value="${ loanApp.appAmount }" pattern="###,###,###,###" /> 원</td>
						<th scope="col">대출기간</th>
						<td>${ loanApp.appMonth } 개월</td>
					</tr>
					<tr>	
						<th scope="col">담보유형</th>
						<td>${ loanApp.assType }</td>
						<th scope="col">지점명</th>
						<td>${ loanApp.branchNm }</td>
					</tr>
					</thead>
		      </table>
		 </div>
      </div>
      <div class="modal-footer" id="scndEvalModalFooter">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="scndEvalModalBtn">요청</button>
      </div>
    </div>
  </div>
</div> --%>
<!--------------------------- 2차심사 결과 - 기각 ----------------------------->
<div class="modal" id="scndEvalRsltRefuse" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header" style="border-bottom: 1px solid #D2D4D4;">
        <h3 class="modal-title">2차 심사 결과</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="refuseBody">
      	<h3>심사 결과</h3>
        <p style="color: #BF1C16">대출이 기각되었습니다. </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="scndEvalRefuseModalBtn">기각</button>
      </div>
    </div>
  </div>
</div>
<!--------------------------- 2차심사 결과 - 승인 ----------------------------->
<div class="modal" id="scndEvalRsltApprove" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header" style="border-bottom: 1px solid #D2D4D4;">
        <h3 class="modal-title">2차 심사 결과</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="approveBody">
        <h3>심사 결과</h3>
        <p style="color: #1C16BF">대출이 승인되었습니다. </p>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button> -->
        <button type="button" class="btn btn-primary" id="scndEvalApproveModalBtn">승인</button>
      </div>
    </div>
  </div>
</div>



	<div class="header bg-primary pb-6">
      <div class="container-fluid">
        <div class="header-body">
          <div class="row align-items-center py-4">
            <div class="col-lg-6 col-7">
            </div>
          </div>
		<div class="row">
            <div class="col-xl-6">
              <div class="card card-stats">
                <!-- Card body -->
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <%-- <h5 class="card-title text-uppercase mb-0"><span class="steps">STEP1.</span> 재무제표 유효성 검증</h5>
                      <div class="sub-blank"></div>
                      <p>조회하려는 재무제표의 연도를 선택하세요.</p>
                      <select id="yearSelector" class="custom-select custom-select-sm"> 
                      	<option value="${ year1 }">${ year1 }</option>
                      	<option value="${ year2 }">${ year2 }</option>
                      	<option value="${ year3 }">${ year3 }</option>
                      </select>
                      <div class="sub-blank"></div>
                      <div>
                      	<input id="viewDart" type="button" class="btn btn-primary evalBtns" value="기업정보공시 확인">
                      </div>
                      <hr>
                      <h5 class="card-title text-uppercase mb-0"><span class="steps">STEP2.</span> 간편심사</h5>
                      <div class="sub-blank"></div>
                      <p>재무제표 정보가 공시 정보와 맞지 않을경우 '대출기각'을 선택하세요.<br>
                      	 2차 심사로 넘기지 않고 간편 승인을 내려면 '대출승인'을 선택하세요.</p>
                      <div>
                      	<button type="button" id="approve" class="btn btn-primary" data-toggle="modal" data-target="#approveModal">
						  대출승인
						</button>
                      	<!-- <input id="approve" type="button" class="btn btn-primary " value="대출승인"> -->
                      	<input id="refuse" type="button" class="btn btn-primary " data-toggle="modal" data-target="#refuseModal" value="대출기각">
                      </div>
					  <hr>
                      <h5 class="card-title text-uppercase mb-0"><span class="steps">STEP3.</span> 2차심사</h5>
                      <div class="sub-blank"></div>
                      <p>2차심사 신청시 전문 심사팀으로 대출 신청 정보를 전송합니다. </p>
                      <div>
                      	<input id="scndEval" type="button" class="btn btn-primary evalBtns"data-toggle="modal" data-target="#scndEvalModal"  value="2차심사">
                      </div>
					  <hr>
                      <h5 class="card-title text-uppercase mb-0"><span class="steps">STEP3.</span> 2차심사</h5>
                      <div class="sub-blank"></div>
                      <p>2차심사 신청시 전문 심사팀으로 대출 신청 정보를 전송합니다. </p>
                      <div>
                      	<input id="scndEval" type="button" class="btn btn-primary evalBtns"data-toggle="modal" data-target="#scndEvalModal"  value="2차심사">
                      </div> --%>
                      

						<h5 class="card-title text-uppercase mb-0">대출심사</h5>
						
						<!-- One "tab" for each step in the form: -->
						<div class="tab">
							<h5 class="card-title text-uppercase mb-0"><span class="steps">STEP1.</span> 재무제표 유효성 검증</h5>
	                        <div class="sub-blank"></div>
	                      	<p>※ 조회하려는 재무제표의 연도를 선택하세요.<br>※ 재무제표 정보가 공시 정보와 맞지 않을경우 '대출기각'을 선택하세요.</p>
	                      	<select id="yearSelector" class="custom-select custom-select-sm"> 
	                      		<option value="${ year1 }">${ year1 }</option>
	                      		<option value="${ year2 }">${ year2 }</option>
	                      		<option value="${ year3 }">${ year3 }</option>
	                      	</select>
	                      	<div class="sub-blank"></div>
	                      	<div>
	                      		<input id="viewDart" type="button" class="btn btn-primary evalBtns" value="기업정보공시 확인">
	                      	</div>
	                      	<div class="sub-blank"></div>
	                      	<select id="reasonSelector" class="custom-select custom-select-sm"> 
	                      		<option value="재무제표 정보가 맞지 않습니다.">재무제표 정보가 맞지 않습니다.</option>
	                      		<option value="기업의 재무조건이 대출 기준과 맞지 않습니다.">기업의 재무조건이 대출 기준과 맞지 않습니다.</option>
	                      		<option value="기업의 신용도가 대출 기준과 맞지 않습니다.">기업의 신용도가 대출 기준과 맞지 않습니다.</option>
	                      		<option value="기업의 상환 이력 및 대출 내역이 대출을 받기에 부적합합니다.">기업의 상환 이력 및 대출 내역이 대출을 받기에 부적합합니다.</option>
	                      		<option value="대출 상품의 대출 대상에 부합하지 않습니다.">대출 상품의 대출 대상에 부합하지 않습니다.</option>
	                      	</select>
	                      	<div class="sub-blank"></div>
	                      	<div>
		                      	<input id="refuse" type="button" class="btn btn-primary " data-toggle="modal" data-target="#refuseModal" value="대출기각">
	                      	</div>
						</div>
						
						<div class="tab" id="AIinterest">
							<h5 class="card-title text-uppercase mb-0"><span class="steps">STEP2.</span> AI 대출금리 심사</h5>
	                      	<div class="sub-blank"></div>
	                      	<p>※ AI가 대출 금리를 판단합니다. <br>※ AI는 적정 대출 금리와 금리 오차 범위를 알려줍니다. 
	                      		<br>※ 작년 재무제표와 신용등급이 필요합니다.
	                      	</p>
	                      	<div>
	                      		<input id="scndEval" type="button" class="btn btn-primary evalBtns"data-toggle="modal" data-target="#scndEvalModal"  value="AI에게 대출금리 받기">
	                      	</div>
						</div>
						
						<form name="evalForm" id="evalForm" action="${ pageContext.request.contextPath }/emp/loanEvalSubmit" method="post">
						<input type="hidden" name="appNo" value="${ loanApp.appNo }">
						<input type="hidden" name="evalResult" value="Y">
						<div class="tab">
						  <h5 class="card-title text-uppercase mb-0"><span class="steps">STEP3.</span> 최종 금리 및 한도</h5>
	                      <div class="sub-blank"></div>
	                      	<p>※ AI 대출금리를 참고하여 최종 금리 및 한도를 정해주세요. </p>
	                      	<p><input placeholder="최종 대출금리 (% 제외)" name="interest" oninput="this.className = ''"></p>
						  	<p><input placeholder="최종 대출한도 (원 제외)" name="limit" oninput="this.className = ''"></p>
	                      <div>
	                      </div>
						</div>
						</form>
						
						<div class="sub-blank"></div>
						<div style="overflow:auto;">
						  <div style="float:right;">
						    <button type="button" id="prevBtn" class="btn btn-secondary" onclick="nextPrev(-1)">이전</button>
						    <button type="button" id="nextBtn" class="btn btn-secondary" onclick="nextPrev(1)">다음</button>
							<div class="sub-blank"></div>
						  </div>
						</div>
						
						<!-- Circles which indicates the steps of the form: -->
						<div style="text-align:center;margin-top:40px;">
						  <span class="step"></span>
						  <span class="step"></span>
						  <span class="step"></span>
						</div>
						

                    </div>
                    <!-- <div class="col-auto">
                      <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow">
                        <i class="ni ni-active-40"></i>
                      </div>
                    </div> -->
                  </div>
                </div>
              </div>
            </div>
            
            <div class="col-xl-6">
              <div class="card card-stats">
                <!-- Card body -->
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase mb-0">기업개황</h5>
                      <div class="table-responsive" >
			 			<table class="table align-items-center table-flush">
			                <thead class="thead-light">
					            <tr>
									<th>기업체명</th>
									<td>${ corp.name }</td>
									<th>영문기업명</th>
									<td>${ corp.nameEng }</td>
								</tr>
								<tr>
									<th>사업자번호</th>
									<td>${ corp.bizrNo }</td>
									<th>법인(주민)번호</th>
									<td>${ corp.jurirNo }</td>
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
									<td>${ corp.corpCls }</td>
								</tr>
								<tr>
									<th>업종</th>
									<td>${ corp.indutyCode }</td>
									<th>홈페이지</th>
									<td>${ corp.hmUrl }</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td>
										<c:if test="${ not empty corp.phnNo }">
											+${ corp.countryCode } ${ corp.phnNo }
										</c:if>
									</td>
									<th>팩스번호</th>
									<td>
										<c:if test="${ not empty corp.faxNo }">
											+${ corp.countryCodeFax } ${ corp.faxNo }
										</c:if>	
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<td colspan="3">${ corp.adres }</td>
								</tr>
								<tr>
									<th>설립일</th>
									<td colspan="3">${ corp.estDt }</td>
								</tr>
							
							
			                </tbody>
			              </table>
                    </div>
                  </div>
                </div>
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
			    <a class="nav-link active" id="loan-app-tab" data-toggle="tab" href="#loanApp" role="tab" aria-controls="loanApp" aria-selected="true">대출신청정보</a>
			  </li>
			  <li class="nav-item" role="presentation">
			    <a class="nav-link" id="loan-his-tab" data-toggle="tab" href="#loanHis" role="tab" aria-controls="loanHis" aria-selected="false">대출 및 상환내역</a>
			  </li>
			  <li class="nav-item" role="presentation">
			    <a class="nav-link" id="interest-tab" data-toggle="tab" href="#interest" role="tab" aria-controls="interest" aria-selected="false">이자납입내역</a>
			  </li>
			  <li class="nav-item" role="presentation">
			    <a class="nav-link" id="analysis-tab" data-toggle="tab" href="#analysis" role="tab" aria-controls="analysis" aria-selected="false">기업분석</a>
			  </li>
			</ul>
			
			<div class="tab-content" id="myTabContent">
			<!-- 대출신청 정보 -->
			  <div class="tab-pane fade show active" id="loanApp" role="tabpanel" aria-labelledby="loan-app-tab">
			  	<div class="card">
		            <div class="card-header border-0">
		              <div class="row align-items-center">
		                <div class="col">
		                  <h3 class="mb-0">신청 내용</h3>
		                </div>
		              </div>
		            </div>
            
				  	  <div class="table-responsive" >
<!-- ----------------------------------------대출신청테이블  ------------------------------------------>
				 		<table class="table align-items-center table-flush">
				           <thead class="thead-light">
						    <tr>
								<th scope="col">사업자등록번호</th>
								<th scope="col">대출상품 이름</th>
								<th scope="col">신청일</th>
								<th scope="col">대출유형</th>
								<th scope="col">대출계좌</th>
								<th scope="col">이자납부계좌</th>
								<th scope="col">신청금액</th>
								<th scope="col">대출기간</th>
								<th scope="col">담보유형</th>
								<th scope="col">지점명</th>
								<th scope="col">상태</th>
							</tr>
							</thead>
							<tbody>
								<tr>
									<td>${ loanApp.bizrNo }</td>
									<td>${ loanApp.prodName }</td>
									<td>${ loanApp.appDate }</td>
									<td>${ loanApp.loanType }</td>
									<td>${ loanApp.loanAcnt }</td>
									<td>${ loanApp.interestAcnt }</td>
									<td><fmt:formatNumber value="${ loanApp.appAmount }" pattern="###,###,###,###" /> 원</td>
									<td>${ loanApp.appMonth }</td>
									<td>${ loanApp.assType }</td>
									<td>${ loanApp.branchNm }</td>
									<td>
										<c:if test="${ loanApp.loanAppStatus eq 'FW' }">
											심사 진행중
										</c:if>
										<c:if test="${ loanApp.loanAppStatus eq 'SW' }">
											2차 심사 진행중
										</c:if>
										<c:if test="${ loanApp.loanAppStatus eq 'R' }">
											기각 
										</c:if>
										<c:if test="${ loanApp.loanAppStatus eq 'C' }">
											승인
										</c:if>
									<td>
								</tr>
							</tbody>
				        </table>
				      </div>
				      <div class="card-header border-0">
			            <div class="row align-items-center">
			              <div class="col">
			                <h3 class="mb-0">신청 서류</h3>
			              </div>
			              <div class="col text-right">
		                  <a class="btn btn-sm btn-primary" id="download" style="color:white">다운로드</a>
		                  </div>
			            </div>
			          </div>
			          
			          <div class="table-responsive" >
<!------------------------------------------ 신청 서류 테이블  ------------------------------------------>
				 		<table class="table align-items-center table-flush">
				           <thead class="thead-light">
				           	  <tr>
				           	  	<th></th>
								<th scope="col">번호</th>
								<th scope="col">서류종류</th>
								<th scope="col">발급일</th>
								<th scope="col">이름</th>
								<th scope="col">제출인</th>
								<th scope="col">제출일</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${ docList }" var="doc" varStatus="loop">
							<tr>
								<td><input type="radio" name="docRadio" value="${ doc.docNo }"></td>
								<td>${ loop.count }</td>
								<td>${ doc.docType }</td>
								<td>${ doc.issueDate }</td>
								<td>${ doc.docSaveName } (${ doc.docSize / 1000 }KB)</td>
								<td>${ doc.uploader }</td>
								<td>${ doc.uldDate }</td>
							</tr>
							</c:forEach>
							</tbody>
											
				      </table>
			    	</div>
       		  </div>
       		  </div>
       		<!-- 대출 및 상환내역 -->  
       		  <div class="tab-pane fade" id="loanHis" role="tabpanel" aria-labelledby="loan-his-tab">
       		  	<div class="card">
		            <div class="card-header border-0">
		              <div class="row align-items-center">
		                <div class="col">
		                  <h3 class="mb-0">기존 대출 내역</h3>
		                </div>
		                <div class="col text-right">
		                  <a class="btn btn-sm btn-primary" id="repay" style="color:white">상환내역</a>
		                </div>
		              </div>
		            </div>
            
            		<div id="loanHisTable">
				  	  <div class="table-responsive" >
<!------------------------------------------ 대출내역테이블  ------------------------------------------>
				 		<table class="table align-items-center table-flush">
				           <thead class="thead-light">
				           	 <tr>
								<th></th>
								<th>대출상품</th>
								<th>대출계좌</th>
								<th>대출구분</th>
								<th>시작일</th>
								<th>만기일</th>
								<th>상환률</th>
								<th>잔금</th>
								<th>원금</th>
								<th>금리</th>
								<th>이자 납부 계좌</th>
								<th>이자 납부일</th>
								<th>담보 유형</th>
								<th>이자</th>
							</tr>
				           </thead>
				           <tbody>
							<c:forEach items="${ loanHisList }" var="loanHis">
								<tr>
									<td><input type="radio" value="${ loanHis.loanNo }" name="loanHisRadio"></td>
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
								<a href="<%=request.getContextPath()%>/emp/loanEval/${ loanApp.appNo }?blockNo2=${ blockNo2 -1 }&pageNo2=${ blockStartPageNo2-1 }&bizrNo=${ corp.bizrNo }" >이전</a> &nbsp; 
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
							<a href="<%=request.getContextPath()%>/emp/loanEval/${ loanApp.appNo }?blockNo2=${ blockNo2+1 }&pageNo2=${ blockEndPageNo2+1 }&bizrNo=${ corp.bizrNo }" >다음</a> &nbsp;  
						</c:if>
						</div>
						<!------------------------------------ 페이징 끝 ------------------------------------>
					</div>
			  		</div>
       		 
					<!-- 상환내역 -->
					<div id="loanRpy"></div>
       		 	 </div>
       		  
       		  <!-- 이자납입내역 -->
       		  
       		  <div class="tab-pane fade" id="interest" role="tabpanel" aria-labelledby="interest-tab">
       		  <div class="card">
		            <div class="card-header border-0">
		              <div class="row align-items-center">
		                <div class="col">
		                  <h3 class="mb-0">이자납입내역</h3>
		                </div>
		                <div class="col text-right">
		                  <input type="checkbox" onchange="changeStatus()" checked data-toggle="toggle" id="loanStatusChk" data-on="진행중" data-off="완료">
		                </div> 
		              </div>
		            </div>
		            
       		  	<select class="custom-select custom-select-sm" id="selectAcnt" onchange="interestAjax()">
					<option selected>선택</option>
					<c:forEach items="${ loanHisListAll }" var="loanHisL">
						  <c:if test="${ loanHisL.loanStatus eq 'C' }">
							  <option class="complete" value="${ loanHisL.loanNo }">대출번호 ${ loanHisL.loanNo } | 계좌 ${ loanHisL.loanAcnt } | 대출금 
							  	<fmt:formatNumber value="${ loanHisL.pcplAmt }" pattern="###,###,###,###" /> 원
							  </option>
						  </c:if>
						  <c:if test="${ loanHisL.loanStatus eq 'I' }">
							  <option class="ing" value="${ loanHisL.loanNo }">대출번호 ${ loanHisL.loanNo } | 계좌 ${ loanHisL.loanAcnt } | 대출금 
							  	<fmt:formatNumber value="${ loanHisL.pcplAmt }" pattern="###,###,###,###" /> 원
							  </option>
						  </c:if>
					</c:forEach>
				</select> 
				
			</div>
			<div id="loanHisInterestAjax"></div>
			</div>	
		
		
			
<!------------------------------------------ 기업분석 ------------------------------------------>    
 <!-- 가장 최근 신용등급 저장해놓기 -->
 <c:forEach items="${ creditRnkList }" var="rnk" varStatus="loop">
 	<c:if test="${ loop.last }">
 		<c:set var="latestCreditRnk" value="${ rnk.CREDIT_RNK }"/>
 	</c:if>
 </c:forEach>  		  
       		  <div class="tab-pane fade" id="analysis" role="tabpanel" aria-labelledby="analysis-tab">
       		    <div class="card">
		            <div class="card-header border-0">
		              <div class="row align-items-center">
		                <div class="col">
		                  <h3 class="mb-0 greens">기업 신용등급</h3>
		                </div>
		              </div>
		            </div>
            
				  	  <div class="table-responsive" >
					    <table class="table align-items-center table-flush">
					    	<tr>
					    		<td>재무기준</td>
					    		<td rowspan="2">
					    			<div id="rnk">
					    				${ latestCreditRnk }
					    			</div>
					    		</td>
					    				
					    	</tr>
					    	<tr>
					    		<td>${ creditRnkList[2].FNC_STMT_DATE }</td>
					    	</tr>
					    </table>
					  </div>
					  <div class="table-responsive" >
					    <table class="table align-items-center table-flush">
					    	<thead class="thead-light">
					    	<tr>
					    		<th>등급</th>
					    		<th>평가(산출)일자</th>
					    	</tr>
					    	</thead>
					    	<tbody>
					    	<tr>
					    		<th>${ creditRnkList[0].CREDIT_RNK }</th>
					    		<td>${ creditRnkList[0].RNK_DATE }</td>
					    	</tr>
					    	<tr>
					    		<th>${ creditRnkList[1].CREDIT_RNK }</th>
					    		<td>${ creditRnkList[1].RNK_DATE }</td>
					    	</tr>
					    	<tr>
					    		<th>${ creditRnkList[2].CREDIT_RNK }</th>
					    		<td>${ creditRnkList[2].RNK_DATE }</td>
					    	</tr>
					    	</tbody>
					    </table>
		  			</div>
		 	 </div>
<!---------------------------------- 데이터 시각화 ---------------------------------->	


				 <div class="card">
		            <div class="card-header border-0">
		              <div class="row align-items-center">
		                <div class="col">
		                  <h3 class="mb-0 greens">요약 재무비율</h3>
		                </div>
		              </div>
		            </div>
            
				  	  <div class="table-responsive" >
					    <table class="table align-items-center table-flush">
					    	<thead class="thead-light">
						<!-- 성장성 -->
							<tr>
								<th>성장성</th>
								<th>${ year2 }</th>
								<th>${ year3 }</th>
							</tr>
							</thead>
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
					<div class="table-responsive" >
					    <table class="table align-items-center table-flush">
					    	<thead class="thead-light">
							<tr>
								<th>수익성</th>
								<th>${ year1 }</th>
								<th>${ year2 }</th>
								<th>${ year3 }</th>
							</tr>
							</thead>
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
					<div class="table-responsive" >
					    <table class="table align-items-center table-flush">
					    <thead class="thead-light">
						<!-- 안정성 -->
						<tr>
							<th>안정성</th>
							<th>${ year1 }</th>
							<th>${ year2 }</th>
							<th>${ year3 }</th>
						</tr>
						</thead>
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
			<div class="card">
				<div class="card-header border-0">
		          <div class="row align-items-center">
		             <div class="col">
		               <h3 class="mb-0 greens">주요 재무상태표</h3>
		             </div>
		          </div>
	            </div>
	            <div class="col text-right">
					<p style="float:right">단위 : 백만</p>
				</div>
				<div class="table-responsive" >
					<table class="table align-items-center table-flush">
					<thead class="thead-light">
					<tr>
						<th></th>
						<th>${ year1 }</th>
						<th>${ year2 }</th>
						<th>${ year3 }</th>
					</tr>
					</thead>
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
			</div>
			
			<div class="blank"></div>
			<div id="chartContainer1" style="height: 300px; width: 100%;"></div>
			<div class="blank"></div>
			<div class="blank"></div>
		</div>
		
		
		
		<div class="card">					
			<div class="card-header border-0">
		      <div class="row align-items-center">
		         <div class="col">
		           <h3 class="mb-0 greens">주요 손익계산서</h3>
	             </div>
              </div>
            </div>	
            <div class="col text-right">
				<p style="float:right">단위 : 백만</p>
			</div>
			<div class="table-responsive" >
				<table class="table align-items-center table-flush">
					<thead class="thead-light">
					<tr>
						<th></th>
						<th>${ year1 }</th>
						<th>${ year2 }</th>
						<th>${ year3 }</th>
					</tr>
					</thead>
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
			</div>
			
			<div class="blank"></div>
			<div id="chartContainer2" style="height: 300px; width: 100%;"></div> 
			<div class="blank"></div>
			<div class="blank"></div>
		</div>
		
		
		<div class="card">
			<div class="card-header border-0">
		      <div class="row align-items-center">
		         <div class="col">
		           <h3 class="mb-0 greens">재무제표 요약</h3>
		           <div class="sub-blank"></div>
		           <h4 class="mb-0">요약 재무상태표</h4>
	             </div>
              </div>
            </div>		
			
			<div class="col text-right">
				<p style="float:right">단위 : 백만</p>
			</div>
			<div class="table-responsive" >
				<table class="table align-items-center table-flush">
					<thead class="thead-light">	
					<tr>
						<th></th>
						<th>${ year1 }</th>
						<th>${ year2 }</th>
						<th>${ year3 }</th>
					</tr>
					</thead>
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
			</div>
			
			<div class="blank"></div>
			<div id="chartContainer3" style="height: 300px; width: 100%;"></div> 
			<div class="blank"></div>
			<div class="blank"></div>
		</div>
		
		
		
		<div class="card">		
			<div class="card-header border-0">
		      <div class="row align-items-center">
		         <div class="col">
		           <h4 class="mb-0">요약 손익계산서</h4>
	             </div>
              </div>
            </div>	
            <div class="col text-right">	
				<p style="float:right">단위 : 백만</p>
			</div>
			<div class="table-responsive" >
				<table class="table align-items-center table-flush">
					<thead class="thead-light">
					<tr>
						<th></th>
						<th>${ year1 }</th>
						<th>${ year2 }</th>
						<th>${ year3 }</th>
					</tr>
					</thead>
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
			</div>
			
			<div class="blank"></div>
			<div id="chartContainer4" style="height: 300px; width: 100%;"></div> 
			<div class="blank"></div>
			<div class="blank"></div>
		</div>
		
		
		<div class="card">		
			<div class="card-header border-0">
		      <div class="row align-items-center">
		         <div class="col">
		           <h4 class="mb-0">요약 현금흐름분석</h4>
	             </div>
              </div>
            </div>	
            <div class="col text-right">	
				<p style="float:right">단위 : 백만</p>
			</div>
			<div class="table-responsive" >
				<table class="table align-items-center table-flush">
					<thead class="thead-light">
					<tr>
						<th></th>
						<th>${ year1 }</th>
						<th>${ year2 }</th>
						<th>${ year3 }</th>
					</tr>
					</thead>
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
			</div>	
			<div class="blank"></div>
			<div id="chartContainer5" style="height: 300px; width: 100%; align: center;"></div> 
			<div class="blank"></div>
			<div class="blank"></div>
				  	  
		</div>
				</div>
       		  </div>
       	 	</div>
       </div>
       </div>
<jsp:include page="../include/footer.jsp"/>
<jsp:include page="../include/js.jsp" />
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
</body>
</html>