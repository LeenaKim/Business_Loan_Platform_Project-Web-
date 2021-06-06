<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출 대시보드</title>
<jsp:include page="/WEB-INF/jsp/include/cssEmp.jsp" />
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type='text/javascript' src='https://prod-apnortheast-a.online.tableau.com/javascripts/api/viz_v1.js'></script>
</head>
<body data-spy="scroll" data-target=".site-navbar-target">
<jsp:include page="../include/empHeader.jsp"/>


<div class="header bg-primary pb-6">
      <div class="container-fluid">
        <div class="header-body">
          <div class="row align-items-center py-4">
            <div class="col-lg-6 col-7">
              <h6 class="h2 text-white d-inline-block mb-0">대출 대시보드</h6>
              <p>실시간 대출 현황 데이터를 제공합니다.</p>
            </div>
            <div class="col-lg-6 col-5 text-right">
              <a href="#" class="btn btn-sm btn-neutral" id="reload">New</a>
              <a href="#" class="btn btn-sm btn-neutral">Filters</a>
            </div>
          </div>
          
          
			<div class="row">
			<!-- 지역별 신규대출건수 -->
			    <div class="col-xl-6" style="text-align: center">
			        <div class="card card-stats">
			          <!-- Card body -->
			            <div class="card-body">
							<div class='tableauPlaceholder' style='width: 600px; height: 1070px;'> 
								<object class='tableauViz' width='700' height='1070' style='display:none;'>
									<param name='host_url' value='https%3A%2F%2Fprod-apnortheast-a.online.tableau.com%2F' /> 
									<param name='embed_code_version' value='3' /> 
									<param name='site_root' value='&#47;t&#47;beone' />
									<param name='name' value='loan_dashboard&#47;5' />
									<param name='tabs' value='no' />
									<param name='toolbar' value='yes' />
									<param name='showAppBanner' value='false' />
								</object>
							</div> 
						</div>
					</div>
				</div>
				<!-- 법인유형별 대출금액 추이 -->
				<div class="col-xl-6" style="text-align: center">
			        <div class="card card-stats">
			          <!-- Card body -->
			            <div class="card-body">
			            	<div class='tableauPlaceholder' style='width: 600px; height:500px;'>
				            	<object class='tableauViz' width='650' height='500' style='display:none;'>
					            	<param name='host_url' value='https%3A%2F%2Fprod-apnortheast-a.online.tableau.com%2F' /> 
					            	<param name='embed_code_version' value='3' /> 
					            	<param name='site_root' value='&#47;t&#47;beone' />
					            	<param name='name' value='loan_dashboard&#47;8' />
					            	<param name='tabs' value='no' />
					            	<param name='toolbar' value='yes' />
					            	<param name='showAppBanner' value='false' />
				            	</object>
			            	</div>
			            </div>
			        </div>
			        <!-- 업종별 대출건수 및 대출금액 -->
			        <div class="card card-stats">
			          <!-- Card body -->
			            <div class="card-body">
							<div class='tableauPlaceholder' style='width: 600px; height: 510px;'>
								<object class='tableauViz' width='650' height='510' style='display:none;'>
									<param name='host_url' value='https%3A%2F%2Fprod-apnortheast-a.online.tableau.com%2F' /> 
									<param name='embed_code_version' value='3' /> 
									<param name='site_root' value='&#47;t&#47;beone' />
									<param name='name' value='loan_dashboard&#47;4' />
									<param name='tabs' value='no' />
									<param name='toolbar' value='yes' />
									<param name='showAppBanner' value='false' />
								</object>
							</div>
						</div>
					</div>
			        
			    </div>
			    
			    
			 </div>
			 
			
			
			<div class="row">  
				<div class="col-xl-12" style="text-align: center">
					<div class="card card-stats">
			          <!-- Card body -->
			            <div class="card-body">
							<div class='tableauPlaceholder' style='width: 1200px; height: 500px;'>
								<object class='tableauViz' width='1200' height='500' style='display:none;'>
									<param name='host_url' value='https%3A%2F%2Fprod-apnortheast-a.online.tableau.com%2F' /> 
									<param name='embed_code_version' value='3' /> 
									<param name='site_root' value='&#47;t&#47;beone' />
									<param name='name' value='loan_dashboard&#47;2' />
									<param name='tabs' value='no' />
									<param name='toolbar' value='yes' />
									<param name='showAppBanner' value='false' />
								</object>
							</div>
			            </div>
			        </div>
				</div>
			</div>
			
			<div class="row">  
				
				<div class="col-xl-6" style="text-align: center">
					<div class="card card-stats">
			          <!-- Card body -->
			            <div class="card-body">
							<div class='tableauPlaceholder' style='width: 600px; height: 500px;'>
								<object class='tableauViz' width='600' height='500' style='display:none;'>
									<param name='host_url' value='https%3A%2F%2Fprod-apnortheast-a.online.tableau.com%2F' /> 
									<param name='embed_code_version' value='3' /> 
									<param name='site_root' value='&#47;t&#47;beone' />
									<param name='name' value='loan_dashboard&#47;7' />
									<param name='tabs' value='no' />
									<param name='toolbar' value='yes' />
									<param name='showAppBanner' value='false' />
								</object>
							</div>
						</div>
					</div>
				
				</div>
				<div class="col-xl-6" style="text-align: center">
					<div class="card card-stats">
			          <!-- Card body -->
			            <div class="card-body">
			            	<div class='tableauPlaceholder' style='width: 600px; height: 500px;'>
				            	<object class='tableauViz' width='600' height='500' style='display:none;'>
					            	<param name='host_url' value='https%3A%2F%2Fprod-apnortheast-a.online.tableau.com%2F' /> 
					            	<param name='embed_code_version' value='3' /> 
					            	<param name='site_root' value='&#47;t&#47;beone' />
					            	<param name='name' value='loan_dashboard&#47;3' />
					            	<param name='tabs' value='no' />
					            	<param name='toolbar' value='yes' />
					            	<param name='showAppBanner' value='false' />
				            	</object>
			            	</div>
			            </div>
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