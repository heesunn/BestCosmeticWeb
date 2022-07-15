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
	@RequestMapping("/guest/loginView")
	public String loginView(HttpServletRequest request) {
		return "guest/log/loginView";
	}
}
