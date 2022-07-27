package com.study.springboot.member.service.wjapp;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface AppBasketService {
    public int deleteBasket(HttpServletRequest request);
    public int basketUpCount(HttpServletRequest request);
    public int basketDownCount(HttpServletRequest request);
    public int basketCount(HttpServletRequest request);
}
