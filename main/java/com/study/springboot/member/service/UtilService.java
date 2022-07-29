package com.study.springboot.member.service;

import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface UtilService {
    public String createOrderNum(HttpServletRequest request, Model model);
    public JSONObject lastDeliveryDestination(HttpServletRequest request);
}
