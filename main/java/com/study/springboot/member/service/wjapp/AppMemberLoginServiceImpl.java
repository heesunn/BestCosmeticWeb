package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class AppMemberLoginServiceImpl implements AppMemberLoginService
{

	@Override
	public JSONObject memberLogin(HttpServletRequest request)
	{
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		JSONObject obj = new JSONObject();
		return obj;
	}

}
