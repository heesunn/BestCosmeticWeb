package com.study.springboot.member.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler
{

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException
	{
		String loginid = request.getParameter("j_username");
		String loginpw = request.getParameter("j_password");
		String errormsg = "";
		
		if(exception instanceof BadCredentialsException) {
			loginFailureCount(loginid);
			errormsg = "아이디나 비밀번호가 맞지않습니다.";
		}
		else if(exception instanceof InternalAuthenticationServiceException) {
			loginFailureCount(loginid);
			errormsg = "아이디나 비밀번호가 맞지않습니다.";
		}
		else if(exception instanceof DisabledException) {
			loginFailureCount(loginid);
			errormsg = "계정이 비활성화 되었습니다. 관리자에게 문의하세요";
		}
		else if(exception instanceof CredentialsExpiredException) {
			loginFailureCount(loginid);
			errormsg = "비밀번호 유효기간이 만료 되었습니다. 관리자에게 문의하세요.";
		}
		request.setAttribute("username", loginid);
		request.setAttribute("error_message", errormsg);
		request.getRequestDispatcher("/loginForm?error=true").forward(request, response);
	}
	// 비밀번호를 3번이상 틀릴시 계정 잠금처리
	protected void loginFailureCount(String username) {
		System.out.println("fail");
//		틀린 횟수 업데이트
//		userDao.countFailure(username);
//		틀린 횟수 조회
//		int cnt = userDao.checkFailureCount(username);
//		if(cnt == 3) {
//			계정 잠금 처리
//			userDao.disabledUsername(username);
//		}
	}
}
