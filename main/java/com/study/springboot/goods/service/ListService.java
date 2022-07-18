package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface ListService {
	public void list(HttpServletRequest request, Model model);
	public void pointList(HttpServletRequest request, Model model);
}
