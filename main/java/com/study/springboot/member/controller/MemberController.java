package com.study.springboot.member.controller;

import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.ValidationMember;
import com.study.springboot.member.service.CancelExchangeRefundViewService;
import com.study.springboot.member.service.JoinService;
import com.study.springboot.member.service.ModifyMemberViewService;
import com.study.springboot.member.service.OrderDeliveryViewService;
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

	@RequestMapping("/join")
	public String join() {
		return "guest/log/joinView";
	}
	@RequestMapping("/naverCaptcha")
	public String naverCaptcha(){
		return "guest/log/naverCaptcha";
	}
	@RequestMapping("/joinProcess")
	public @ResponseBody JSONObject joinProcess(@ModelAttribute("dto") @Valid ValidationMember validationMember,
												BindingResult bindingResult,
												HttpServletRequest request,
												Model model
												)
	{
		JSONObject obj = new JSONObject();

		if(bindingResult.hasErrors()) {
			if (bindingResult.getFieldError("id") != null){
				System.out.println(bindingResult.getFieldError("id").getDefaultMessage());
				obj.put("desc", bindingResult.getFieldError("id").getDefaultMessage());
				return obj;
			} else if (bindingResult.getFieldError("pw") != null) {
				System.out.println(bindingResult.getFieldError("pw").getDefaultMessage());
				obj.put("desc", bindingResult.getFieldError("pw").getDefaultMessage());
				return obj;
			} else if (bindingResult.getFieldError("name") != null) {
				obj.put("desc", bindingResult.getFieldError("name").getDefaultMessage());
				return obj;
			} else if (bindingResult.getFieldError("firstEmail") != null) {
				obj.put("desc", bindingResult.getFieldError("firstEmail").getDefaultMessage());
				return obj;
			} else if (bindingResult.getFieldError("secondEmail") != null) {
				obj.put("desc", bindingResult.getFieldError("secondEmail").getDefaultMessage());
				return obj;
			}
		}
		String insertCount = joinService.join(request,model);
		obj.put("desc",insertCount);
		return obj;
	}
	@RequestMapping("/idCheck")
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
	@RequestMapping("/mypageView")
	public String mypageView() {
		return "member/mypageView";
	}
	@RequestMapping("/member/modifyMember")
	public String modifyMember(HttpServletRequest request, Model model) {
		modifyMemberViewService.modifyMemberView(request, model);
		return "member/modifyMember";
	}

}
