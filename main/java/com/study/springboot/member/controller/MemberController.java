package com.study.springboot.member.controller;

import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.ValidationMember;
import com.study.springboot.member.service.*;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;


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
	@Autowired
	UtilService utilService;
	@Autowired
	AfterPaymentService afterPaymentService;
	@Autowired
	Make1000MemberService make1000MemberService;
	@Autowired
	MemberManagementViewService memberManagementViewService;
	@Autowired
	UpgradeAdminService upgradeAdminService;
	@Autowired
	UpdatePurchaseConfirmationService updatePurchaseConfirmationService;


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
		utilService.createOrderNum(request, model);
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
	@RequestMapping("/member/completePayment")
	public String completePayment(Model model) {
		return "member/completePayment";
	}

	@RequestMapping("/member/afterPayment")
	public @ResponseBody String afterPayment(HttpServletRequest request) {
		int updateCount = afterPaymentService.afterPayment(request);
		return String.valueOf(updateCount);
	}
	@RequestMapping("/makeMemberService")
	public @ResponseBody String makeMemberService() {
		make1000MemberService.makeMember();
		return "1000명 생성완료";
	}
	@RequestMapping("/admin/memberManagement")
	public String memberManagement(HttpServletRequest request, Model model) {
		memberManagementViewService.memberManagementView(request,model);
		memberManagementViewService.allMemberCount(model);
		return "admin/memberManagement";
	}

	@RequestMapping("/admin/upgradeAdmin")
	public @ResponseBody JSONObject upgradeAdmin(HttpServletRequest request) {
		JSONObject obj = new JSONObject();
		int updateCount = upgradeAdminService.upgradeAdmin(request);
		obj.put("desc", updateCount);
		return obj;
	}
	@RequestMapping("/admin")
	public String adminMainPageReset(){
		updatePurchaseConfirmationService.updatePurchaseConfirmation();
		return "redirect:/admin/memberManagement";
	}
	@RequestMapping("/member/lastDeliveryDestination")
	public @ResponseBody JSONObject lastDeliveryDestination(HttpServletRequest request){
		JSONObject obj = utilService.lastDeliveryDestination(request);
		return obj;
	}
	@RequestMapping("/admin/push")
	public String push() {
		return "admin/pushMessage";
	}
	@RequestMapping("/admin/FCMSender")
	public String fcmSender(Model model, HttpServletRequest request, HttpServletResponse response){

		String Apikey = "AAAAj07M2yI:APA91bEo4mpDxoDwLqu15vOeEPxt2v5b0fCmkwOBcDG61Ae10bFxCkGtzuFyazCfeEpdGzyXmTeHZlQ6eZjcoowehFNOV-PXNfScKABlqkpR5ftClhby5Zqp9bLKJ8ksNEcpPzeZqz_U";
		String fcmURL = "https://fcm.googleapis.com/fcm/send";

		response.setCharacterEncoding("UTF-8");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}

		String notiTitle = request.getParameter("notiTitle");
		String notiBody = request.getParameter("notiBody");
		String message = request.getParameter("message");
		System.out.println("notiTitle = " + notiTitle);
		System.out.println("notiBody = " + notiBody);
		System.out.println("message = " + message);

		try {
			//디바이스 아이디
			String deviceId1 = "djW_rZ3bQGyFhZbZccj0Cb:APA91bFcwgkemNzOoCywB6q3b0JoxZOqk115br0v2qi1Z59QVN83x_eOxVpyp-YqwTQBADmPCrpXqMXLqUmB5k5MCRg-o8DiaRNaiow3B09tNqt_lBOi3r_YMcYII5QNR09jpxa4hw5P";

			//디바이스 아이디 담기
			ArrayList deviceList = new ArrayList();
			deviceList.add(deviceId1);

			URL url = new URL(fcmURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setUseCaches(false);
			conn.setDoInput(true);
			conn.setDoOutput(true);

			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization","key="+Apikey);
			conn.setRequestProperty("Content-Type","application/json");

			JSONObject json = new JSONObject();

			JSONObject noti = new JSONObject();
			noti.put("title", notiTitle);
			noti.put("body",notiBody);

			JSONObject data = new JSONObject();
			data.put("message",message);

			//data.put("to",deviceId1);//한명한테 보낼때
			json.put("registration_ids",deviceList);//여러명한테 보낼때..

			json.put("notification",noti);
			json.put("data", data);

			try {

				OutputStreamWriter wr = new OutputStreamWriter(
						conn.getOutputStream());
				System.out.println("json.toString() = " + json.toString());
				wr.write(json.toString());
				wr.flush();

				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

				String output;
				System.out.println("Output from Server .... \n");
				while ((output = br.readLine()) != null){
					System.out.println(output);
				}

			}catch (Exception e){
				e.printStackTrace();
			}

			model.addAttribute("notiTitle",notiTitle);
			model.addAttribute("notiBody",notiBody);
			model.addAttribute("message",message);
			model.addAttribute("result", "FCM 발송됨");



		}catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/sendResult";

	}

}
