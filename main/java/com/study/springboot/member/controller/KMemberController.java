package com.study.springboot.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.member.service.LikeServiceImpl;
import com.study.springboot.member.service.OrderDetailServiceImpl;

@Controller
public class KMemberController
{
	@Autowired
	LikeServiceImpl likeService;
	@Autowired
	OrderDetailServiceImpl orderDetail; 
	
	@RequestMapping("/")
	public String main() {
		return "guest/log/main";
	}
	@RequestMapping("/guest/loginView")
	public String loginView(HttpServletRequest request) {
		return "guest/log/loginView";
	}
	@RequestMapping("/member/like")
	public String likeView(HttpServletRequest request, Model model) {
		likeService.likeList(request, model);
		return "member/likeList";
	}
	@RequestMapping("/member/likeDelete")
	public @ResponseBody String likeDelete(HttpServletRequest request) {
		String result = likeService.likeDelete(request);
		
		return result;
	}
	@RequestMapping("/member/orderDetail")
	public String orderDetailView(@RequestParam("bco_ordernum") String ordernum ,HttpServletRequest request, Model model) {
		request.setAttribute("bco_ordernum", ordernum);
		orderDetail.orderDetail(request, model);
		return "member/orderDetail";
	}
}
