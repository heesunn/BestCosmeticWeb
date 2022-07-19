package com.study.springboot.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.member.dto.ValidationMember;
import com.study.springboot.member.service.JoinService;
import com.study.springboot.member.service.LikeServiceImpl;
import com.study.springboot.member.service.MemberWithdrawalServiceImpl;
import com.study.springboot.member.service.OrderDetailServiceImpl;
import com.study.springboot.member.service.OrderManagement;
import com.study.springboot.member.service.PwChangeServiceImpl;
import com.study.springboot.member.service.PwCheckServiceImpl;

@Controller
public class KMemberController
{
	@Autowired
	LikeServiceImpl likeService;
	@Autowired
	OrderDetailServiceImpl orderDetail; 
	@Autowired
	PwChangeServiceImpl pwChange;
	@Autowired
	PwCheckServiceImpl pwCheck;
	@Autowired
	MemberWithdrawalServiceImpl withdrawal;
	@Autowired
	JoinService joinService;
	@Autowired
	OrderManagement OrderManagement;
	
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
	@RequestMapping("/member/passwordChange")
	public String pwChangeView(HttpServletRequest request, Model model) {
		return "/member/passwordChange";
	}
	@RequestMapping("/member/pwCheck")
	public @ResponseBody String pwCheck(HttpServletRequest request, Model model) {
		String result = "";
		if(pwCheck.pwCheck(request, model)) {
			result = "일치";
		}
		else {
			result = "불일치";
		}
		System.out.println(result);
		return result;
	}
	@RequestMapping("/member/pwChange")
	public @ResponseBody String pwChange(@ModelAttribute("dto") @Valid ValidationMember validationMember,
											BindingResult bindingResult,
											HttpServletRequest request,
											Model model) {
		String result = "";
		String errorMessage = pwChange.joinValidation(validationMember, bindingResult);
		if (errorMessage != null) {
			result = errorMessage;
			return result;
		}
		result = pwChange.pwChange(request, model);
		return result;
	}
	@RequestMapping("/member/out")
	public String memberWithdrawal(HttpServletRequest request, Model model) {
		return "/member/memberWithdrawal";
	}
	@RequestMapping("/member/memberDelete")
	public @ResponseBody String memberDelete(HttpServletRequest request, Model model) {
		String result = withdrawal.withdrawal(request, model);
		
		return result;
	}
	@RequestMapping("/admin/adminTop")
	public String adminTop(HttpServletRequest request, Model model) {
		return "/admin/adminTop";
	}
	@RequestMapping("/admin/adminPageView")
	public String adminPageView(HttpServletRequest request, Model model) {
		return "/admin/adminPageView";
	}
	@RequestMapping("/admin/adminMain")
	public String adminMain(HttpServletRequest request, Model model) {
		return "/admin/adminMain";
	}
	
	
	
	@RequestMapping("/admin/deliveryReady")
	public String deliveryReady(HttpServletRequest request, Model model) {
		OrderManagement.deliveryReady(request, model);
		return "/admin/deliveryReady";
	}
	@RequestMapping("/admin/inTransit")
	public String inTransit(HttpServletRequest request, Model model) {
		OrderManagement.inTransit(request, model);
		return "/admin/inTransit";
	}
	@RequestMapping("/admin/deliveryCompleted")
	public String deliveryCompleted(HttpServletRequest request, Model model) {
		OrderManagement.deliveryCompleted(request, model);
		return "/admin/deliveryCompleted";
	}
	@RequestMapping("/admin/purchaseConfirmation")
	public String purchaseConfirmation(HttpServletRequest request, Model model) {
		OrderManagement.purchaseConfirmation(request, model);
		return "/admin/purchaseConfirmation";
	}
	@RequestMapping("/admin/stateInTransit")
	public @ResponseBody String stateInTransit(HttpServletRequest request, Model model) {
		String result = OrderManagement.stateInTransit(request, model);
		
		return result;
	}
	@RequestMapping("/admin/drSearch")
	public String drSearch(HttpServletRequest request, Model model) {
		OrderManagement.drSearch(request, model);
		return "/admin/deliveryReady";
	}
	@RequestMapping("/admin/itSearch")
	public String itSearch(HttpServletRequest request, Model model) {
		
		return "/admin/inTransit";
	}
	@RequestMapping("/admin/dcSearch")
	public String dcSearch(HttpServletRequest request, Model model) {
		
		return "/admin/deliveryCompleted";
	}
	@RequestMapping("/admin/pcSearch")
	public String pcSearch(HttpServletRequest request, Model model) {
		
		return "/admin/purchaseConfirmation";
	}
}
