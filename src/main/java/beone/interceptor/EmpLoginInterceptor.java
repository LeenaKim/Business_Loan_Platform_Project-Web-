package beone.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import beone.emp.vo.EmpVO;

public class EmpLoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if (handler instanceof HandlerMethod) {
	         HandlerMethod method = (HandlerMethod)handler;
	         System.out.println("메소드 : "+ method);
	         System.out.println("controller : " + method.getBean());
	    }
		
		// 로그인 여부 체크 
		HttpSession session = request.getSession();
		EmpVO empVO = (EmpVO)session.getAttribute("empVO");
		
		if(empVO == null) {
			
			String uri = request.getRequestURI();
			uri = uri.substring(request.getContextPath().length());
			
			String query = request.getQueryString();
			System.out.println(query);
			
			if(query != null && query.length() != 0)
				uri = uri + "?" + query;
			
			session.setAttribute("dest",  uri);
			
			response.sendRedirect(request.getContextPath() + "/emp/login");
			return false;
		} 
		return true;
	}

}
