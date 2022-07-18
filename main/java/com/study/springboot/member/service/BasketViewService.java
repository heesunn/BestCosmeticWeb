package com.study.springboot.member.service;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface BasketViewService {
    public void basketView(HttpServletRequest request, Model model);
}
