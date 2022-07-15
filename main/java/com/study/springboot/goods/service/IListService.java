package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface IListService {
	public void pointList(HttpServletRequest request, Model model);
}
