package com.study.springboot.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class KMemberController
{
	@RequestMapping("/")
	public String main() {
		return "guest/log/main";	
	}
	@RequestMapping("/guest/log/loginView")
	public String loginView(HttpServletRequest request) {
		if(request.getHeader("Referer") != null) {
			String uri = request.getHeader("Referer");
		    if (uri != null && !uri.contains("/login")) {
		        request.getSession().setAttribute("prevPage", uri);
		    }
		}
		return "guest/log/loginView";	
	}
}
