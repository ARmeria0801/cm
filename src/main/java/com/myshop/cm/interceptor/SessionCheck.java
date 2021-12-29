package com.myshop.cm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//로그인 체크 세션
public class SessionCheck extends HandlerInterceptorAdapter{
	// preHandle(request,response,handler)메소드
		// 1.Controller에서 요청(*.nhn)을 받기 전에  preHandle()가 호출되어 가로채는 역할로 사용
		// 2.로그인 하지않고(세션이 없으면) 요청하면 로그인 폼으로 이동 하도록 해주는 역할
		public boolean preHandle(HttpServletRequest request, 
				HttpServletResponse response, Object handler) throws Exception {
			HttpSession session = request.getSession();
			String mem_id = (String)session.getAttribute("mem_id");
			if (mem_id == null || mem_id.equals(""))  {		
				response.sendRedirect("member_login");	// 세션이 없으면 로그인 폼으로 이동
				return false;
			}
			return true;
		}
}
