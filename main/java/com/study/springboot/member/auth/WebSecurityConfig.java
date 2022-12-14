package com.study.springboot.member.auth;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.oauth2.CustomOAuth2UserService;
import com.study.springboot.member.service.MemberLoginServiceImpl;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter
{
	private final RequestCache requestCache = new HttpSessionRequestCache();
    private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
    
	@Autowired
	public MemberDto dto;
	
	@Autowired
	MemberLoginServiceImpl loginSession;
	
	@Autowired
	private DataSource datasource;

	@Autowired
	private CustomOAuth2UserService customOAuth;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception
	{
		
		http.authorizeRequests()
			.antMatchers("/admin/**").hasAuthority("role_admin")
			.antMatchers("/member/**").hasAnyAuthority("role_user", "role_admin")
			.antMatchers("/guest/**").permitAll()
			.antMatchers("/api/**").permitAll()
			.antMatchers("/**").permitAll()
			.anyRequest().authenticated();
		
		http.formLogin()
			.loginPage("/guest/loginView")
			.loginProcessingUrl("/loginDo")
			.usernameParameter("j_username")
			.passwordParameter("j_password")
			.failureHandler(
				new AuthenticationFailureHandler() {
					@Override
					public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
							AuthenticationException exception) throws IOException, ServletException {
//						System.out.println("fail");
						request.setAttribute("message", "???????????? ??????????????? ???????????? ????????????.");
						RequestDispatcher dispatcher = request.getRequestDispatcher("guest/loginView");
						dispatcher.forward(request, response);
					}
				})
			.successHandler(
				new AuthenticationSuccessHandler() {
					@Override
					public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
							Authentication authentication) throws IOException, ServletException {
						clearSession(request);

				        SavedRequest savedRequest = requestCache.getRequest(request, response);
				        /**
				         * prevPage??? ???????????? ?????? = ???????????? ?????? /auth/login ????????? ????????? ??????
				         * ?????? Session??? prevPage attribute ??????
				         */
				        String prevPage = (String) request.getSession().getAttribute("prevPage");
				        if (prevPage != null) {
				            request.getSession().removeAttribute("prevPage");
				        }

				        // ?????? URI
				        String uri = "/";

				        /**
				         * savedRequest ???????????? ?????? = ?????? ????????? ?????? ????????? ??????
				         * Security Filter??? ?????????????????? savedRequest??? ?????? ??????
				         */
				        if (savedRequest != null) {
				            uri = savedRequest.getRedirectUrl();
				        } else if (prevPage != null && !prevPage.equals("")) {
				            // ???????????? - ??????????????? ????????? ?????? "/"??? redirect
				            if (prevPage.contains("/guest/join")) {
				                uri = "/";
				            } else {
				                uri = prevPage;
				            }
				        }
				        String bcm_id = request.getParameter("j_username");
				        loginSession.memberLogin(bcm_id);
				        redirectStrategy.sendRedirect(request, response, uri);
					}	
			})
			.permitAll();
		
		http.logout()
			.logoutUrl("/logout")
			.deleteCookies("JSESSIONID")
			.logoutSuccessUrl("/")
			.invalidateHttpSession(true)
			.permitAll();
			
		//ssl??? ????????????????????? true??? ??????
		http.csrf().disable()
			.headers().frameOptions().disable()
			.and()
			.oauth2Login()
			.userInfoEndpoint()
			.userService(customOAuth);
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.jdbcAuthentication()
			.dataSource(datasource)
			.usersByUsernameQuery("select bcm_id as j_username, bcm_pw as j_password, bcm_enable as enabled from bc_member where bcm_id = ?")
			.authoritiesByUsernameQuery("select bcm_id as j_username, bcm_authority as authority from bc_member where bcm_id = ?")
			.passwordEncoder(passwordEncoder());
	}
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
	protected void clearSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        }
    }

}
