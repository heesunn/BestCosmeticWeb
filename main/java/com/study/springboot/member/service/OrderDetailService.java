package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface OrderDetailService
{
	public void orderDetail(HttpServletRequest request, Model model);
}
