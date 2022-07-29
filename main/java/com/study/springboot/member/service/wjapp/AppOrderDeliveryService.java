package com.study.springboot.member.service.wjapp;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.member.dto.OrderDeliveryDto;

public interface AppOrderDeliveryService
{
	public ArrayList<OrderDeliveryDto> appOrderDeliveryInfo(HttpServletRequest request);
	public int appStatusChange(HttpServletRequest request);
}
