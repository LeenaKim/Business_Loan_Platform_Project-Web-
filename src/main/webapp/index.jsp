<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <title>BEONE</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/fonts/icomoon/style.css">

    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/jquery-ui.css">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/owl.theme.default.min.css">

    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/jquery.fancybox.min.css">

    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/bootstrap-datepicker.css">

    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/fonts/flaticon/font/flaticon.css">

    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/aos.css">

    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/style.css">
	<style>
	a {
		color: rgba(64, 146, 143);
	}
	</style>
  </head>
  <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">


  <div id="overlayer"></div>
  <div class="loader">
    <div class="spinner-border text-primary" role="status">
      <span class="sr-only">Loading...</span>
    </div>
  </div>


  <div class="site-wrap">

    <div class="site-mobile-menu site-navbar-target">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close mt-3">
          <span class="icon-close2 js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div>


    <header class="site-navbar js-sticky-header site-navbar-target" role="banner">

      <div class="container">
        <div class="row align-items-center">

          <div class="col-6 col-xl-2">
            <h1 class="mb-0 site-logo"><a href="<%= request.getContextPath() %>" class="h2 mb-0">BEONE<!-- <span class="text-primary">.</span>  --></a></h1>
          </div>

          <div class="col-12 col-md-10 d-none d-xl-block">
            <nav class="site-navigation position-relative text-right" role="navigation">

			<!--------------------------- 기업메뉴 --------------------------->
              <ul class="site-menu main-menu js-clone-nav mr-auto d-none d-lg-block">
              	<c:if test="${ not empty userVO }">
	                <li>
						<img class="iconsInIdx" src="https://img.icons8.com/ios-filled/30/000000/user-male-circle.png" style="display: inline"/>
	                	<a href="${ pageContext.request.contextPath }/corp/mypage" class="nav-link iconsInIdx" style="display: inline; margin-left: -5%;">${ userVO.name }님 &nbsp;&nbsp;></a>
	                </li>
                </c:if>
                <c:if test="${ not empty  accVO }">
                	<li>
						<img class="iconsInIdx" src="https://img.icons8.com/ios-filled/30/000000/user-male-circle.png" style="display: inline"/>
	                	<a href="${ pageContext.request.contextPath }/acc/mypage" class="nav-link iconsInIdx" style="display: inline; margin-left: -5%;">${ accVO.name }님 &nbsp;&nbsp;></a>
                	</li>
                	<li><a href="${ pageContext.request.contextPath }/acc/docUpload" class="nav-link">담당기업 서류보관함</a></li>
                </c:if>
                
                
                <c:if test="${ empty userVO and empty accVO or not empty userVO }">
                <li class="has-children">
                  <a href="#about-section" class="nav-link">대출</a>
                  <ul class="dropdown">
                    <li><a href="${ pageContext.request.contextPath }/corp/loanProd" class="nav-link">대출상품조회 & 가입</a></li>
                    <li><a href="${ pageContext.request.contextPath }/corp/loanAppStatus">신청현황</a></li>
                    <li><a href="${ pageContext.request.contextPath }/corp/loanHistory">대출내역</a></li>
                  	<li><a href="<%= request.getContextPath() %>/corp/interest">이자조회 & 납부</a></li>
                  </ul>
                </li>
                
                <li class="has-children">
                  <a href="#about-section" class="nav-link">계좌</a>
                  <ul class="dropdown">
                    <li><a href="${ pageContext.request.contextPath }/corp/viewAcnt" class="nav-link">대출계좌조회</a></li>
                    <li><a href="${ pageContext.request.contextPath }/corp/acntDetail">거래내역조회</a></li>
                  </ul>
                </li>


                <li><a href="${ pageContext.request.contextPath }/corp/analysis" class="nav-link">우리기업 성장리포트</a></li>
               
                <li><a href="${ pageContext.request.contextPath }/corp/docUpload" class="nav-link">서류보관함</a></li>
                </c:if>
                
                
                <c:if test="${ empty userVO and empty accVO }"> 
                	<li><a href="${ pageContext.request.contextPath }/login" class="nav-link">로그인</a></li>
				</c:if>
                <c:if test="${ not empty userVO or not empty accVO}"> 
                	<li><a href="${ pageContext.request.contextPath }/logout" class="nav-link">로그아웃</a></li>
                </c:if> 
              </ul>
              
            </nav>
          </div>


          <div class="col-6 d-inline-block d-xl-none ml-md-0 py-3" style="position: relative; top: 3px;"><a href="#" class="site-menu-toggle js-menu-toggle float-right"><span class="icon-menu h3"></span></a></div>

        </div>
      </div>

    </header>



    <div class="site-blocks-cover overlay" style="background-image: url(resources/images/main2.jpg);" data-aos="fade" id="home-section">

      <div class="container">
        <div class="row align-items-center justify-content-center">


          <div class="col-md-10 mt-lg-5 text-center">
            <div class="single-text owl-carousel">
            
        
        
              <div class="slide">
                <h1 class="text-uppercase" data-aos="fade-up">자본금이 필요하세요?</h1>
                <p class="mb-5 desc"  data-aos="fade-up" data-aos-delay="100">당장 필요한데 절차가 너무 복잡하시다구요? <br>하나은행 BEONE에서 비대면 기업대출 서비스를 만나보세요.</p>
                <div data-aos="fade-up" data-aos-delay="100">
                </div>
              </div>

              <div class="slide">
                <h1 class="text-uppercase" data-aos="fade-up">우리 기업 성장 리포트</h1>
                <p class="mb-5 desc"  data-aos="fade-up" data-aos-delay="100">하나은행 BEONE에서는 기업의 3개년 분석 리포트를 제공합니다.</p>
              </div>

              <div class="slide">
                <h1 class="text-uppercase" data-aos="fade-up">이제 그만 가셔요, 대출서류 떼러.</h1>
                <p class="mb-5 desc"  data-aos="fade-up" data-aos-delay="100">하나은행 BEONE 에서 보관하고, 필요할때마다 꺼내쓰세요.</p>
              </div>

            </div>
          </div>

        </div>
      </div>

	</div>


    <section class="site-section border-bottom bg-light" id="services-section">
      <div class="container">
        <div class="row align-items-stretch" style="margin: 0px auto; text-align: center">
        
            <div class="unit-4" style="text-align: center; margin-right: 8%;">
              <div class="unit-4-icon">
                <a href="${ pageContext.request.contextPath }/corp/loanProd"><img src="resources/images/016-loupe-1.png" class="mb-4 main-icons"></a>
              </div>
              <div>
                <h3>대출상품조회</h3>
              </div>
            </div>
          
            <div class="unit-4" style="text-align: center; margin-right: 8%">
              <div class="unit-4-icon">
                <a href="<%= request.getContextPath() %>/corp/loanAppStatus"><img src="resources/images/023-smartphone-1.png" class="mb-4 main-icons"></a>
              </div>
              <div>
                <h3>대출신청현황</h3>
              </div>
            </div>
          
            <div class="unit-4" style="text-align: center; margin-right: 8%">
              <div class="unit-4-icon">
                <a href="<%= request.getContextPath() %>/corp/loanHistory"><img src="resources/images/045-folder.png" class="mb-4 main-icons"></a>
              </div>
              <div>
                <h3>대출내역</h3>
              </div>
            </div>
          
            <div class="unit-4" style="text-align: center; margin-right: 8%">
              <div class="unit-4-icon">
                <a href="${ pageContext.request.contextPath }/corp/viewAcnt"><img src="resources/images/036-credit-card-1.png" class="mb-4 main-icons"></a>
              </div>
              <div>
                <h3>계좌조회</h3>
              </div>
            </div>


            <div class="unit-4" style="text-align: center; margin-right: 8%">
              <div class="unit-4-icon">
                <a href="<%= request.getContextPath() %>/corp/analysis"><img src="resources/images/011-file-2.png" class="mb-4 main-icons"></a>
              </div>
              <div>
                <h3>우리기업<br>성장리포트</h3>
              </div>
            </div>
          
            <div class="unit-4" style="text-align: center;">
              <div class="unit-4-icon">
                <a href="<%= request.getContextPath() %>/corp/docUpload"><img src="resources/images/019-folder-2.png" class="mb-4 main-icons"></a>
              </div>
              <div>
                <h3>서류보관함</h3>
              </div>
            </div>

        </div>
      </div>
    </section>


    <section class="site-section" id="blog-section">
      <div class="container">
            <h5 class="mb-3">대출상품</h5>

        <div class="row">
          <div class="col-md-6 col-lg-4 mb-4 mb-lg-4" data-aos="fade-up" data-aos-delay="">
            <div class="h-entry">
              <a href="single.html">
                <img src="resources/images/youth2.png" alt="Image" class="img-fluid">
              </a>
              <h2 class="font-size-regular">청년창업대출</h2>
              <div class="meta mb-4">연 3.34% <span class="mx-2">&bullet;</span>최대 3억<span class="mx-2">&bullet;</span> <a href="${ pageContext.request.contextPath }/corp/loanDetail?no=6">비대면가입</a></div>
              <p>대출 대상은 다음의 사항 중 하나를 충족하는 자로 합니다.
				신용보증기금의 "청년창업특례보증"에 따라 보증서를 발급받은 기업(개인사업자 또는 법인)
				은행권 청년창업재단의 "청년창업기업에 대한 금융지원 협약"에 따라 보증서를 발급받은 기업(개인사업자 또는 법인)</p>
            </div>
          </div>
          <div class="col-md-6 col-lg-4 mb-4 mb-lg-4" data-aos="fade-up" data-aos-delay="100">
            <div class="h-entry">
              <a href="single.html">
                <img src="resources/images/boat2.png" alt="Image" class="img-fluid">
              </a>
              <h2 class="font-size-regular">제작금융</h2>
              <div class="meta mb-4">연 3.77% <span class="mx-2">&bullet;</span>최대 5억<span class="mx-2">&bullet;</span> <a href="${ pageContext.request.contextPath }/corp/loanDetail?no=1">비대면가입</a></div>
              <p>대상기업 : 선박 및 해양설비를 제작하는 국내기업<br>
				대상거래 : 선박 및 해양설비 수출관련 제작금융
			  </p>
              
            </div>
          </div>
          <div class="col-md-6 col-lg-4 mb-4 mb-lg-4" data-aos="fade-up" data-aos-delay="200">
            <div class="h-entry">
              <a href="single.html">
                <img src="resources/images/hana_mission2.png" alt="Image" class="img-fluid">
              </a>
              <h2 class="font-size-regular">하나미션클럽대출</h2>
              <div class="meta mb-4">연 3.94% <span class="mx-2">&bullet;</span>최대 1억<span class="mx-2">&bullet;</span> <a href="${ pageContext.request.contextPath }/corp/loanDetail?no=3">비대면가입</a></div>
              <p>
				한국기독교 총연합회(CCK), 한국기독교교회협의회(KNCC), 한국교회연합(CCIK), 한국독립교회 · 선교단체연합회(KAICAM)에 소속한 교회
				운영기간이 3년을 초과하는 교회,
				현 담임목사가 해당교회의 담임목사 봉직기간이 3년을 초과하는 교회
			  </p>
            </div>
          </div>

        </div>
      </div>
    </section>


<!---------------------------------------- footer ---------------------------------------->
    <footer class="site-footer">
      <div class="container">
        <div class="row">
              <div class="col-md-6 ml-auto">
                <h2 class="footer-heading mb-4">하나 네트워크</h2>
                <span class="footer-heading mb-4"><a href="https://www.hanafn.com:8002/main.do">하나금융그룹 | </a></span>
                <span class="footer-heading mb-4"><a href="https://www.kebhana.com/">하나은행 | </a></span>
                <span class="footer-heading mb-4"><a href="https://www.hanaw.com/main/main/index.cmd">하나금융투자 | </a></span>
                <span class="footer-heading mb-4"><a href="https://www.hanacard.co.kr/OPH30000000N.web?_frame=no&schID=pcd&mID=OPH30000000N">하나카드 | </a></span>
                <span class="footer-heading mb-4"><a href="https://www.hanacapital.co.kr/index.hnc">하나캐피탈</a></span>
              </div>
              <div class="col-md-3 footer-social">
                <h2 class="footer-heading mb-4">Follow Us</h2>
                <a href="#" class="pl-0 pr-3"><span class="icon-facebook"></span></a>
                <a href="#" class="pl-3 pr-3"><span class="icon-twitter"></span></a>
                <a href="#" class="pl-3 pr-3"><span class="icon-instagram"></span></a>
                <a href="#" class="pl-3 pr-3"><span class="icon-linkedin"></span></a>
              </div>
          <div class="col-md-3">
            <h2 class="footer-heading mb-4">관리자</h2>
            <a href="${ pageContext.request.contextPath }/emp/login">로그인</a>
            
          </div>
        </div>
      </div>
    </footer>
	
  </div> <!-- .site-wrap -->

 <script src="${ pageContext.request.contextPath }/resources/js/jquery-3.3.1.min.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/jquery-ui.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/popper.min.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/owl.carousel.min.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/jquery.countdown.min.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/jquery.easing.1.3.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/aos.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/jquery.fancybox.min.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/jquery.sticky.js"></script>
  <script src="${ pageContext.request.contextPath }/resources/js/isotope.pkgd.min.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/js/main.js"></script>


  </body>
</html>


