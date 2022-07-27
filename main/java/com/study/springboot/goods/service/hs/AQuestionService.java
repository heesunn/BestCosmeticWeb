package com.study.springboot.goods.service.hs;


import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;


public interface AQuestionService {
	public JSONObject goodsQuestionView(HttpServletRequest request);
}
