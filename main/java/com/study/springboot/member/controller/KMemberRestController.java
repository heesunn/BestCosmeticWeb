package com.study.springboot.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.study.springboot.member.dto.OrderDeliveryDto;
import com.study.springboot.member.dto.OrderDetail;
import com.study.springboot.member.service.SnsService;
import com.study.springboot.member.service.wjapp.AppMemberJoinService;
import com.study.springboot.member.service.wjapp.AppMemberLoginService;
import com.study.springboot.member.service.wjapp.AppOrderDeliveryService;
import com.study.springboot.member.service.wjapp.AppOrderDetailService;
import com.study.springboot.member.service.wjapp.AppOrderInfoService;

@RestController
public class KMemberRestController
{
	@Autowired
	AppMemberLoginService memberLoginService;
	@Autowired
	AppMemberJoinService memberJoinService;
	@Autowired
	SnsService snsService;
	@Autowired
	AppOrderInfoService orderInfoService;
	@Autowired
	AppOrderDeliveryService orderDeliveryService;
	@Autowired
	AppOrderDetailService orderDetailService;
	
    @PostMapping("/api/login")
    public JSONObject memberCheck(HttpServletRequest request) {
        JSONObject obj = memberLoginService.memberLogin(request);
        return obj;
    }
    @PostMapping("/api/appjoin")
    public JSONObject appJoin(HttpServletRequest request) {
        JSONObject obj = memberJoinService.AppMemberJoin(request);
        return obj;
    }
    @PostMapping("/api/snsLogin")
    public JSONObject appSnsLogin(HttpServletRequest request) {
        JSONObject obj = snsService.appSnsLogin(request);
        return obj;
    }
    @PostMapping("/api/orderInfo")
    public JSONObject orderInfo(HttpServletRequest request) {
        JSONObject obj = orderInfoService.orderInfo(request);
        return obj;
    }
    @RequestMapping("/api/orderdelivery")
    public ArrayList<OrderDeliveryDto> appOrderdelivery(HttpServletRequest request) {
    	ArrayList<OrderDeliveryDto> obj = orderDeliveryService.appOrderDeliveryInfo(request);
        return obj;
    }
    @PostMapping("/api/orderdetail")
    public ArrayList<OrderDetail> appOrderdetail(HttpServletRequest request) {
    	ArrayList<OrderDetail> obj = orderDetailService.appOrderDetail(request);
        return obj;
    }
    @PostMapping("/api/statusChange")
    public void appstatusChange(HttpServletRequest request) {
    	orderDeliveryService.appStatusChange(request);
    }
}