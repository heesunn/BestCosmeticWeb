package com.study.springboot.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.study.springboot.member.service.SnsService;
import com.study.springboot.member.service.wjapp.AppMemberJoinService;
import com.study.springboot.member.service.wjapp.AppMemberLoginService;

@RestController
public class KMemberRestController
{
	@Autowired
	AppMemberLoginService memberLoginService;
	@Autowired
	AppMemberJoinService memberJoinService;
	@Autowired
	SnsService snsService;
	
    @PostMapping("/api/login")
    public JSONObject memberCheck(HttpServletRequest request) {
        JSONObject obj = memberLoginService.memberLogin(request);
        return obj;
    }
    @PostMapping("/api/appjoin")
    public JSONObject appJoin(HttpServletRequest request) {
        JSONObject obj = memberJoinService.AppMemberJoin(request);
        return obj;
    }
    @PostMapping("/api/snsLogin")
    public JSONObject appSnsLogin(HttpServletRequest request) {
        JSONObject obj = snsService.appSnsLogin(request);
        return obj;
    }
}