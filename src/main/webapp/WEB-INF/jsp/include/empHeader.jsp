<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

	<nav class="navbar navbar-top navbar-expand navbar-dark bg-primary border-bottom">
    <div class="container-fluid">
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <header class="site-navbar js-sticky-header site-navbar-target" role="banner"> 

        <div class="row align-items-center">

          <div class="col-6 col-xl-2">
            <h1 class="mb-0 site-logo whiteLetters"><a href="<%= request.getContextPath() %>/emp" class="h2 mb-0" style="color:white; font-size: 1.2em;">BEONE<span style="font-size: 70%; color: orange"> 관리자</span><!-- <span class="text-primary">.</span>  --></a></h1>
          </div>

          <div class="col-12 col-md-10 d-none d-xl-block" >
            <nav class="site-navigation position-relative text-right" role="navigation">

              <ul class="site-menu main-menu js-clone-nav mr-auto d-none d-lg-block">
                <li><a href="<%= request.getContextPath() %>/emp/logout" class="nav-link" style="color: white">로그아웃</a></li>
                <li><a href="<%= request.getContextPath() %>/emp/loanDashboard" class="nav-link" style="color: white">대출현황분석</a></li>
                <li><a href="<%= request.getContextPath() %>/emp" class="nav-link" style="color: white">${ empVO.ename }님의 업무 대시보드</a></li>
              </ul>
              
            </nav>
          </div>
          <div class="col-6 d-inline-block d-xl-none ml-md-0 py-3" style="position: relative; top: 3px;"><a href="#" class="site-menu-toggle js-menu-toggle float-right"><span class="icon-menu h3"></span></a></div>

      </div>
    </header>
	</div>
    </div>
    </nav>