package com.study.springboot.member.controller;

import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.ValidationMember;
import com.study.springboot.member.service.*;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;


@Controller
public class MemberController
{
	@Autowired
	JoinService joinService;
	@Autowired
	OrderDeliveryViewService orderDeliveryViewService;
	@Autowired
	CancelExchangeRefundViewService cancelExchangeRefundViewService;
	@Autowired
	ModifyMemberViewService modifyMemberViewService;
	@Autowired
	ModifyMemberService modifyMemberService;
	@Autowired
	BasketViewService basketViewService;
	@Autowired
	BasketService basketService;
	@Autowired
	OrderCheckService orderCheckService;
	@RequestMapping("/guest/join")
	public String join() {
		return "guest/log/joinView";
	}
	@RequestMapping("/guest/naverCaptcha")
	public String naverCaptcha(){
		return "guest/log/naverCaptcha";
	}
	@RequestMapping("/guest/joinProcess")
	public @ResponseBody JSONObject joinProcess(@ModelAttribute("dto") @Valid ValidationMember validationMember,
												BindingResult bindingResult,
												HttpServletRequest request,
												Model model) {
		JSONObject obj = new JSONObject();
		String errorMessage = joinService.joinValidation(validationMember, bindingResult);
		if (errorMessage != null) {
			obj.put("desc", errorMessage);
			return obj;
		}
		MemberDto memberDto = joinService.userCheck(request, model);
		if(memberDto==null) {
			String insertCount = joinService.join(request,model);
			obj.put("desc",insertCount);
		}else {
			obj.put("desc","-1");
		}
		return obj;
	}
	@RequestMapping("/guest/idCheck")
	public @ResponseBody JSONObject userCheck(HttpServletRequest request,Model model) {
		JSONObject obj = new JSONObject();
		MemberDto memberDto = joinService.userCheck(request, model);
		obj.put("userjson", memberDto);
		System.out.println("obj : " + obj);
		return obj;
	}
	@RequestMapping("/member/orderDelivery")
	public String orderDelivery(HttpServletRequest request, Model model) {
		orderDeliveryViewService.OrderDelivertyView(request, model);
		return "member/orderDeliveryView";
	}
	@RequestMapping("/member/cancellationRequest")
	public @ResponseBody JSONObject cancellationRequest(HttpServletRequest request, Model model) {
		JSONObject obj = new JSONObject();
		int updateCount = orderDeliveryViewService.cancellationRequest(request, model);
		obj.put("desc",updateCount);
		return obj;
	}
	@RequestMapping("/member/exchangeRequest")
	public @ResponseBody JSONObject exchangeRequest(HttpServletRequest request, Model model) {
		JSONObject obj = new JSONObject();
		int updateCount = orderDeliveryViewService.exchangeRequest(request, model);
		obj.put("desc",updateCount);
		return obj;
	}
	@RequestMapping("/member/refundRequest")
	public @ResponseBody JSONObject refundRequest(HttpServletRequest request, Model model) {
		JSONObject obj = new JSONObject();
		int updateCount = orderDeliveryViewService.refundRequest(request, model);
		obj.put("desc",updateCount);
		return obj;
	}
	@RequestMapping("/member/purchaseConfirmation")
	public @ResponseBody JSONObject purchaseConfirmation(HttpServletRequest request, Model model) {
		JSONObject obj = new JSONObject();
		int updateCount = orderDeliveryViewService.purchaseConfirmation(request, model);
		obj.put("desc",updateCount);
		return obj;
	}
	@RequestMapping("/member/cancelExchangeRefund")
	public String cancelExchangeRefund(HttpServletRequest request, Model model) {
		cancelExchangeRefundViewService.cancelExchangeRefundView(request, model);
		return "member/cancelExchangeRefundView";
	}
	@RequestMapping("/member/mypageView")
	public String mypageView() {
		return "member/mypageView";
	}
	@RequestMapping("/member")
	public String mypage() {
		return "redirect:/member/mypageView";
	}
	@RequestMapping("/member/modifyMemberView")
	public String modifyMember(HttpServletRequest request, Model model) {
		modifyMemberViewService.modifyMemberView(request, model);
		return "/member/modifyMemberView";
	}
	@RequestMapping("/member/modifyMember")
	public @ResponseBody JSONObject modifyMember(@ModelAttribute("dto") @Valid ValidationMember validationMember,
												 BindingResult bindingResult,
												 HttpServletRequest request,
												 Model model) {
		JSONObject obj = new JSONObject();
		String errorMessage = modifyMemberService.modifyValidation(validationMember, bindingResult);
		if (errorMessage != null) {
			obj.put("desc", errorMessage);
			return obj;
		}

		int updateCount = modifyMemberService.modify(request,model);
		obj.put("desc",updateCount);

		return obj;
	}
	@RequestMapping("/member/basketView")
	public String basketView(HttpServletRequest request,Model model) {
		basketViewService.basketView(request,model);
		return "member/basketView";
	}
	@RequestMapping("/member/deleteBasket")
	public @ResponseBody JSONObject deleteBasket(HttpServletRequest request, Model model) {
		JSONObject obj = new JSONObject();
		int deleteCount = basketService.deleteBasket(request,model);
		obj.put("desc", deleteCount);
		return obj;
	}

	@RequestMapping("/member/orderList")
	public @ResponseBody JSONObject orderList(HttpServletRequest request,Model model) {
		JSONObject obj = orderCheckService.orderCheck(request,model);
		return obj;
	}

	@RequestMapping("/member/paymentView")
	public String paymentView (HttpServletRequest request,Model model) {
		modifyMemberViewService.modifyMemberView(request, model);
		return "member/paymentView";
	}
	@RequestMapping("/member/basketUpCount")
	public @ResponseBody String basketUpCount(HttpServletRequest request,Model model) {
		int updateCount = basketService.basketUpCount(request,model);

		return String.valueOf(updateCount);
	}
	@RequestMapping("/member/basketDownCount")
	public @ResponseBody String basketDownCount(HttpServletRequest request, Model model) {
		int updateCount = basketService.basketDownCount(request,model);
		return String.valueOf(updateCount);
	}

}
