package com.study.springboot.goods.service.hs;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.goods.dao.hs.YGoodsDao;

@Service
public class AQuestionServiceImpl implements AQuestionService{
	
	@Autowired
	YGoodsDao yGoodsDao;
	
	@Override
    public JSONObject goodsQuestionView(HttpServletRequest request) {
		String bcgKey = request.getParameter("bcgKey");
		System.out.println("2222"+bcgKey);
		JSONObject jsonObject = new JSONObject();
        jsonObject.put("question", yGoodsDao.goodsQuestionView(bcgKey));
        return jsonObject;
    }
}
