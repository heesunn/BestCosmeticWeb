package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface OrderManagement {
	public void deliveryReady(HttpServletRequest request, Model model); // <주문관리> 배송준비
	public void inTransit(HttpServletRequest request, Model model); // <주문관리> 배송중
	public void deliveryCompleted(HttpServletRequest request, Model model); // <주문관리> 배송완료
	public void purchaseConfirmation(HttpServletRequest request, Model model); // <주문관리> 구매확정
	public void drSearch(HttpServletRequest request, Model model);
	public void itSearch(HttpServletRequest request, Model model);
	public void dcSearch(HttpServletRequest request, Model model);
	public void pcSearch(HttpServletRequest request, Model model);
	public String stateInTransit(HttpServletRequest request, Model model); // <주문관리> 배송중으로 상태변경
	public String stateDeliveryCompleted(HttpServletRequest request, Model model); // <주문관리> 배송중으로 상태변경
}
