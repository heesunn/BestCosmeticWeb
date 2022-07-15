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
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.oauth2.CustomOAuth2UserService;
import com.study.springboot.member.service.MemberLoginServiceImpl;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter
{
	@Autowired
	private HttpSession session;
	
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
			.antMatchers("/").permitAll()
			.antMatchers("/css/**", "/js/**", "/img/**").permitAll()
			.antMatchers("/naver-editor/**").permitAll()
			.antMatchers("/captchaImage/**").permitAll()
			.antMatchers("/member/**").permitAll()
//			.antMatchers("/member/**").hasAnyRole("USER","ADMIN")
			.antMatchers("/admin/**").hasRole("ADMIN")
			.anyRequest().permitAll();
//			.anyRequest().authenticated();
		// 나중에 폴더구성 완성되면 그때 수정
		
		http.formLogin()
			.loginPage("/loginView")
			.loginProcessingUrl("/loginDo")
			.usernameParameter("j_username")
			.passwordParameter("j_password")
			.failureHandler(
				new AuthenticationFailureHandler() {
					@Override
					public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
							AuthenticationException exception) throws IOException, ServletException {
						request.setAttribute("message", "아이디나 비밀번호가 일치하지 않습니다.");
						RequestDispatcher dispatcher = request.getRequestDispatcher("/loginView");
						dispatcher.forward(request, response);
					}
				})
			.successHandler(
				new AuthenticationSuccessHandler() {
					@Override
					public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
							Authentication authentication) throws IOException, ServletException {
						String name = request.getParameter("j_username");
						String uri = (String) request.getSession().getAttribute("prevPage");
						loginSession.memberLogin(name);
						response.sendRedirect(uri);
					}	
			})
			.permitAll();
		
		http.logout()
			.logoutUrl("/logout")
			.deleteCookies("JSESSIONID")
			.logoutSuccessUrl("/")
			.invalidateHttpSession(true)
			.permitAll();

		
		//ssl을 사용하지않으면 true로 사용
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
			.rolePrefix("role_")
			.authoritiesByUsernameQuery("select bcm_id as j_username, bcm_authority as authority from bc_member where bcm_id = ?")
			.passwordEncoder(passwordEncoder());
	}
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}

}
