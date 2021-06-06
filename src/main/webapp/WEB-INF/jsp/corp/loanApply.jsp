<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출 신청페이지</title>
<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
<script src="http://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="${ pageContext.request.contextPath }/resources/js/chkData.js"></script>
<style>
td {
	padding: 2%
}
#W {
	display: none;
} 
.tab { white-space: pre; }

</style>
<script>
	$(document).ready(function() {
		/* 
			가입페이지 로드시 로그인된 유저의 기업 정보가 가입하기 충분하지 않을시 모달창 띄우기 
		*/
		if(${ not empty userVO and empty userVO.corpCls or empty userVO.indutyCode or empty userVO.adres or empty userVO.countryCode or empty userVO.phnNo or empty userVO.estDt }){
			$('#agreeModal').modal('hide');
			$('#warning').modal('show');
		}
		/* $('#assTypeM').show(); */
		/* tab 기능 */
		$('#myTab a').on('click', function (e) {
			e.preventDefault()
			$(this).tab('show')
		})
		
		/* 약관 동의 ajax */
		$('.btn-secondary').click(function() {
			if($(this).attr('id') == 'basic'){
				$.ajax({
					url : '${ pageContext.request.contextPath }/corp/agreeBasic',
					type : 'get',
					success : function(result) {
						$('#exampleModalLabel').empty()
						$('#exampleModalLabel').append('[필수]은행여신거래기본약관')
						$('.modal-body').empty()
						$('.modal-body').append(result)
						$('#basicChk').prop("checked", true);
					},
					error : function(result) {
						alert('error')
					}
				})
			} else if($(this).attr('id') == 'view'){
				$.ajax({
					url : '${ pageContext.request.contextPath }/corp/agreeView',
					type : 'get',
					success : function(result) {
						$('#exampleModalLabel').empty()
						$('#exampleModalLabel').append('[필수]법인(신용)정보 조회 동의서')
						$('.modal-body').empty()
						$('.modal-body').append(result)
						$('#viewChk').prop("checked", true);
					},
					error : function(result) {
						alert('error')
					}
				})
			} else if($(this).attr('id') == 'use') {
				$.ajax({
					url : '${ pageContext.request.contextPath }/corp/agreeUse',
					type : 'get',
					success : function(result) {
						$('#exampleModalLabel').empty()
						$('#exampleModalLabel').append('[필수]법인(신용)정보 수집·이용·제공 동의서(여신 금융거래)')
						$('.modal-body').empty()
						$('.modal-body').append(result)
						$('#useChk').prop("checked", true);
					},
					error : function(result) {
						alert('error')
					}
				})
			}
			$('#agreeModal').modal('show')
		})
		/* 대출 유형에 따라 다른 담보 유형 셀렉트 보이기 */
		$('.type').change(function() {
			let type = $(this).val();
			if(type == 'M'){
				$('#W').val("선택").prop("selected", true);
				$('#M').show()
				$('#W').hide()
				$('#assType').show()
			} else if(type == 'W'){
				$('#M').val("선택").prop("selected", true);
				$('#M').hide()
				$('#W').show()
				$('#assType').show()
			} else {
				$('#W').val("선택").prop("selected", true);
				$('#M').val("선택").prop("selected", true);
				$('#assType').hide()
			}
		})
	})
	
	/* 가입 완료. 후에 isNull 추가 예정 */
	function doJoin() {
		let jForm = document.jForm;
		if(isNull(jForm.appAmount, '희망 대출액을 입력하세요.'))
			return false;
		if(isNull(jForm.appYear, '희망 대출 기간을 입력하세요.'))
			return false;
		if(jForm.loanType.value == 'W' && jForm.assTypeW.value == '선택'){
			alert('담보 유형을 선택해주세요.')			
			jForm.assTypeW.focus()
			return false;
		}
		if(jForm.loanType.value == 'M' && jForm.assTypeM.value == '선택'){
			alert('담보 유형을 선택해주세요.')			
			jForm.assTypeM.focus()
			return false;			
		}
		if(jForm.interestDate.value == '선택'){
			alert('이자납부일을 선택해주세요.')
			jForm.interestDate.focus()
			return false;
		}
		if(isNull(jForm.branchNm, '지점명을 입력하세요.'))
			return false;
		if($('.agreements:checked').length != $('.agreements').length){
			alert('약관에 동의해주세요.')			
			return false;
		}
		if(!$('input[name=docNo]:checkbox').is(':checked')){
			alert('서류를 제출해주세요.')
			return false;
		}
		return true; 
	}
</script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/header.jsp"/>
	<div class="container" id="changeable">
	
	
	<ul class="nav nav-tabs" id="myTab" role="tablist">
	  <li class="nav-item" role="presentation">
	    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">신청 안내</a>
	  </li>
	  <li class="nav-item" role="presentation">
	    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">상품 설명</a>
	  </li>
	</ul>
	
	<!-------------------------------------- 대출 신청 -------------------------------------->
	<div class="tab-content" id="myTabContent">
	  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
	  	<form action="<%= request.getContextPath() %>/corp/loanApp" name="jForm" method="post" onsubmit="return doJoin();">
	  	<input type="hidden" value="${ loanProd.prodNo }" name="prodNo">
	  	<input type="hidden" value="${ userVO.bizrNo }" name="bizrNo">
	  	<table class="table">
	  		<tr>
	  			<td colspan="2">
				  	<h5 class="subtitle">신청서 작성</h5>			
	  			</td>
	  		<tr>
	  			<th>대출 유형</th>
	  			<td>
		  			<input type="radio" value="M" class="type" name="loanType" checked>&nbsp;&nbsp;물적담보&nbsp;&nbsp;
		  			<input type="radio" value="W" class="type" name="loanType">&nbsp;&nbsp;보증서 담보&nbsp;&nbsp;
		  			<input type="radio" value="C" class="type" name="loanType">&nbsp;&nbsp;신용 
	  			</td>
	  		</tr>
	  		<tr>
	  			<th>상품 이름</th>
	  			<td>${ loanProd.name }</td>
	  		</tr>
	  		<tr>
	  			<th>신청법인</th>
	  			<td>${ userVO.name }</td>
	  		</tr>
	  		<tr>
	  			<th>대출금 입금 계좌</th>
	  			<td>
	  				<select class="custom-select custom-select-sm" name="loanAcnt">
	  					<option>신규 개설</option>
						<c:forEach items="${ acntList }" var="account" varStatus="loop">  
							<option>${ account.no }</option>
						</c:forEach>
					</select>
					※ '신규 개설' 신청시 자동으로 계좌 비대면 개설 후 대출금 입금 계좌로 지정됩니다.
				</td>
	  		</tr>
	  		<tr>
	  			<th>이자 납부 계좌</th>
	  			<td>
	  				<select class="custom-select custom-select-sm" name="interestAcnt">
	  					<option>계좌 없음</option>	  				
						<c:forEach items="${ acntList }" var="account" varStatus="loop">  
							<option>${ account.no }</option>
						</c:forEach>
					</select>
					※ 당행 기업 계좌가 없는 경우 신규로 개설되는 대출금 입금 계좌가 이자 납부 계좌로 지정됩니다.
				</td>
	  		</tr>
	  		<!-- <tr>
	  			<th>이자 자동이체 여부</th>
	  			<td>
	  				<input type="checkbox" id="autoInterestTrans">
	  			</td>
	  		</tr> -->
	  		<tr>
	  			<th>이자납부일</th>
	  			<td>
	  				<select name="interestDate" class="custom-select custom-select-sm">
	  					<option value="선택">선택</option>
	  					<option value="3">매달 3일</option>
	  					<option value="12">매달 12일</option>
	  					<option value="23">매달 23일</option>
	  				</select>
	  			</td>
	  		</tr>
	  		<tr>
	  			<th>희망 대출액</th>
	  			<td><input type="text" placeholder="금액을 입력하세요." name="appAmount">  원</td>
	  		</tr>
	  		<tr>
	  			<th>상환방식</th>
	  			<td>
	  				<select class="custom-select custom-select-sm">
	  					<option>만기 일시 상환</option>	  
	  				</select>	
	  			</td>
	  		</tr>
	  		<tr>
	  			<th>희망 대출기간</th>
	  			<td><input type="text" placeholder="대출 기간을 입력하세요." name="appYear">  년</td>
	  		</tr>
	  		<tr id="assType">
	  			<th>담보 유형</th>
	  			<td>
	  				<select class="custom-select custom-select-sm" id="M" name="assTypeM">
	  					<option>선택</option>	  				
	  					<option>토지</option>	  				
	  					<option>부동산</option>	  				
					</select>
					
	  				<select class="custom-select custom-select-sm" id="W" name="assTypeW">
	  					<option>선택</option>	  				
	  					<option>신용보증기금</option>	  				
	  					<option>기술보증기금</option>	  				
	  					<option>신용보증재단</option>	  				
	  					<option>소상공인 진흥원</option>	  				
	  					<option>무역보험공사</option>	  				
					</select>
				</td>
			</tr>
			<tr>
				<th>지점명</th>
				<td><input type="text" name="branchNm"></td>
	  		</tr>
	  		<tr>
	  			<td colspan="2">
	  				<h5 class="subtitle">서류 제출 안내</h5>
	  				<p>대출 신청시 아래의 필수 서류를 제출하여야 심사를 받을 수 있습니다.</p>
	  				<ol>
	  					<li>사업자등록증</li>
	  					<li>부가세과세표준증명원</li>
	  					<li>주주명부</li>
	  					<li>최근 3개년 재무제표(창립 3년 미만 기업의 경우 창립 후부터 가장 최근 재무제표까지 제출)</li>
	  					<li>담보대출시 담보 관련 서류</li>
	  				</ol>
	  			</td>
	  		</tr>
	  		<tr>
	  			<td colspan="2">
	  			<p>서류보관함에 등록된 서류중 사용할 서류를 선택하세요.<br>
	  			서류보관함에 등록되있지 않을 경우 서류보관함에서 서류 업로드 후 이용하세요.</p>
	  			<div class="card">
				  <div class="card-body">
				  	<b>파일 리스트</b><br>
				  	<div class="sub-blank"></div>
				    <c:forEach items="${ docList }" var="doc" varStatus="loop">
				    	<input type="checkbox"	name="docNo" value="${ doc.docNo }" >
				    	<c:if test="${ fn:length(doc.docType) <= 3 }">
					    	${ doc.docType }<span class="tab">&#9;&#9;&#9;&#9;</span>${ doc.docOriName }<br>
				    	</c:if>
				    	<c:if test="${ fn:length(doc.docType) eq 4}">
					    	${ doc.docType }<span class="tab">&#9;&#9;&#9;</span>${ doc.docOriName }<br>
				    	</c:if>
				    	<c:if test="${ fn:length(doc.docType) > 4 and fn:length(doc.docType) < 8 }">
					    	${ doc.docType }<span class="tab">&#9;&#9;</span>${ doc.docOriName }<br>
				    	</c:if>
				    	<c:if test="${ fn:length(doc.docType) >= 8 }">
					    	${ doc.docType }<span class="tab">&#9;</span>${ doc.docOriName }<br>
				    	</c:if>
				    </c:forEach>
				  </div>
				</div>
	  			</td>
	  		</tr>
	  	</table>
	  
	  	<table id="agree" class="table">
	  		<tr>
	  			<td colspan="2">
	  				<h5 class="subtitle">약관 동의</h5>
	  			</td>
	  		</tr>
	  		<tr>
	  			<td style="width: 80%">[필수]은행여신거래기본약관</td>
	  			<td style="width: 20%">
	  				<button type="button" class="btn btn-secondary midBtn" data-toggle="modal" data-target="#exampleModal" id="basic">내용보기</button>&nbsp;&nbsp;
	  				<input type="checkbox" class="agreements" id="basicChk" name="agrm" disabled>
	  			</td>
	  		</tr>
	  		<tr>
	  			<td style="width: 80%">[필수]법인(신용)정보 조회 동의서</td>
	  			<td>
	  				<button type="button" class="btn btn-secondary midBtn" data-toggle="modal" data-target="#exampleModal" id="view">내용보기</button>&nbsp;&nbsp;
	  				<input type="checkbox" class="agreements" id="viewChk" name="agrm" disabled>	
	  			</td>
	  		</tr>
	  		<tr>
	  			<td style="width: 80%">[필수]법인(신용)정보 수집·이용·제공 동의서(여신 금융거래)</td>
	  			<td>
	  				<button type="button" class="btn btn-secondary midBtn" data-toggle="modal" data-target="#exampleModal" id="use">내용보기</button>&nbsp;&nbsp;
	  				<input type="checkbox" class="agreements" id="useChk" name="agrm" disabled>
	  			</td>
	  		</tr>
	  	</table>
	  	<div style="text-align: center">
	  		<input type="submit" class="btn btn-primary" value="가입">
	  	</div>
	  	<div class="blank"></div>
	  	</form>
	  </div>
	  
	  <!-- Modal -->
		<div class="modal fade" id="agreeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel"></h5>
		       <!--  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button> -->
		      </div>
		      <div class="modal-body">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">동의</button>
		      </div>
		    </div>
		  </div>
		</div>
	  <!-------------------------------------- 상품 안내 -------------------------------------->
	  <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
		  <h3 class="title">${ loanProd.name }</h3>
			<table class="table">
				<tr>
					<td style="width: 20%"><b>대상</b></td>
					<td>
						${ loanProd.object }
					</td>
				</tr>
				<tr>
					<td><b>대출기간</b></td>
					<td>
						${ loanProd.termMon } 년
					</td>
				</tr>
				<tr>
					<td><b>최저금리</b></td>
					<td>
						연 ${ loanProd.interest } %
					</td>
				</tr>
				<tr>
					<td><b>한도</b></td>
					<td>
						${ loanProd.limit } 원 
					</td>
				</tr>
				<tr>
					<td><b>이자계산방법</b></td>
					<td>
						${ loanProd.interestCalMtd }
					</td>
				</tr>
				<tr>
					<td><b>상환방식</b></td>
					<td>
						${ loanProd.repType }
					</td>
				</tr>
				<tr>
					<td><b>원리금 상환방법</b></td>
					<td>
						${ loanProd.repMtd }
					</td>
				</tr>
				<tr>
					<td><b>계약해지/갱신방법</b></td>
					<td>
						${ loanProd.cancleReMtd }
					</td>
				</tr>
				<tr>
					<td><b>중도상환수수료율</b></td>
					<td>
						${ loanProd.midRpyFeeRate } %
					</td>
				</tr>
				<tr>
					<td><b>유의사항</b></td>
					<td>
						${ loanProd.notice }
					</td>
				</tr>
			</table>
	  </div>
	</div>
	
	<!------------------------------ modal ------------------------------>
	<div class="modal" id="warning" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">대출 상품 가입 안내</h5>
	       <!--  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button> -->
	      </div>
	      <div class="modal-body">
	      	대출 상품 가입을 위해선 추가적인 기업 정보를 입력해야합니다. <br>
	      	마이페이지에서 기업 정보를 수정해주세요.
	      </div>
	      <div class="modal-footer">
	        <a href="${ pageContext.request.contextPath }/corp/loanProd"><button type="button" class="btn btn-secondary">닫기</button></a>
        	<a href="${ pageContext.request.contextPath }/corp/mypage"><button type="button" class="btn btn-primary">확인</button></a>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	</div>
<jsp:include page="../include/footer.jsp"/>
<jsp:include page="../include/js.jsp" />
</body>
</html>