package com.study.springboot.member.auth;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.study.springboot.member.oauth2.CustomOAuth2UserService;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter
{
	@Autowired
	public AuthenticationFailureHandler handler;
	
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
		
		http.formLogin()
			.loginPage("/loginView")
			.loginProcessingUrl("/j_spring_security_check")
			.failureHandler(handler)
			.usernameParameter("j_username")
			.passwordParameter("j_password")
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
			.usersByUsernameQuery("select bcm_id, bcm_pw, bcm_enable from bc_member where bcm_id = ?")
			.rolePrefix("role_")
			.authoritiesByUsernameQuery("select bcm_id, bcm_authority from bc_member where bcm_id = ?")
			.passwordEncoder(passwordEncoder());
	}
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}

}
