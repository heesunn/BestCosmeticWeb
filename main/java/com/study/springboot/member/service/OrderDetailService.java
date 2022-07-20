package com.study.springboot.member.service;

import org.springframework.ui.Model;

public interface OrderDetailService
{
	public void orderDetail(String bco_ordernum, Model model);
}
