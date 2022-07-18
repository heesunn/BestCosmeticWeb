package com.study.springboot.goods.service;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface DetailAddService {
	public int insertDetail(HttpServletRequest request, Model model);
}