package com.study.springboot.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class KMemberController
{
	@RequestMapping("/")
	public String main() {
		return "member/main";	
	}
	@RequestMapping("/loginView")
	public String loginView() {
		return "member/loginView";	
	}
}
