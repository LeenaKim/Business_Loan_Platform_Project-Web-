package beone.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import beone.corp.vo.CorpVO;

public class LoginInterceptor extends HandlerInterceptorAdapter {

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
		CorpVO userVO = (CorpVO)session.getAttribute("userVO");
		
		if(userVO == null) {
			
			String uri = request.getRequestURI();
			uri = uri.substring(request.getContextPath().length());
			
			String query = request.getQueryString();
			System.out.println(query);
			
			if(query != null && query.length() != 0)
				uri = uri + "?" + query;
			
			session.setAttribute("dest",  uri);
			
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		} 
		return true;
	}

}
