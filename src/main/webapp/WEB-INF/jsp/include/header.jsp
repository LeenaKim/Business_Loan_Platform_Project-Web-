<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!-- <div id="overlayer"></div>  -->
  <!-- <div class="loader">
    <div class="spinner-border text-primary" role="status">
      <span class="sr-only">Loading...</span>
    </div>
  </div> -->


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

              <ul class="site-menu main-menu js-clone-nav mr-auto d-none d-lg-block">
              	<c:if test="${ not empty userVO }">
              	<li>
					<img class="iconsInIdx" src="https://img.icons8.com/ios-filled/30/000000/user-male-circle.png" style="display: inline"/>
                	<a href="<%= request.getContextPath() %>/corp/mypage" class="nav-link iconsInIdx" style="display: inline; margin-left: -5%;">${ userVO.name }님 &nbsp;&nbsp;></a>
                </li>
                </c:if>
                
                <!-- 세무사용 메뉴 -->
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
                    <li><a href="<%= request.getContextPath() %>/corp/loanProd" class="nav-link">대출상품조회 & 가입</a></li>
                    <li><a href="<%= request.getContextPath() %>/corp/loanAppStatus">신청현황</a></li>
                    <li><a href="<%= request.getContextPath() %>/corp/loanHistory">대출내역</a></li>
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

                <li><a href="<%= request.getContextPath() %>/corp/analysis" class="nav-link">우리기업 성장리포트</a></li>
                <li><a href="<%= request.getContextPath() %>/corp/docUpload" class="nav-link">서류 보관함</a></li>
                </c:if>
                
                <c:if test="${ empty userVO and empty accVO }"> 
                	<li><a href="<%= request.getContextPath() %>/login" class="nav-link">로그인</a></li>
				</c:if>
                <c:if test="${ not empty userVO or not empty accVO }"> 
                	<li><a href="<%= request.getContextPath() %>/logout" class="nav-link">로그아웃</a></li>
                </c:if> 
              </ul>
            </nav>
          </div>


          <div class="col-6 d-inline-block d-xl-none ml-md-0 py-3" style="position: relative; top: 3px;"><a href="#" class="site-menu-toggle js-menu-toggle float-right"><span class="icon-menu h3"></span></a></div>

        </div>
      </div>
    </header>
