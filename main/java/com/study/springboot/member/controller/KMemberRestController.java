package com.study.springboot.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.study.springboot.member.service.wjapp.AppMemberLoginService;

@RestController
public class KMemberRestController
{
	@Autowired
	AppMemberLoginService memberLoginService;
	
    @GetMapping("/api/login")
    public JSONObject memberCheck(HttpServletRequest request) {
        JSONObject obj = memberLoginService.memberLogin(request);
        return obj;
    }
}