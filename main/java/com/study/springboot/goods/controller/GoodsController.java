package com.study.springboot.goods.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.goods.dao.GoodsDao;
import com.study.springboot.goods.service.IListService;

@Controller
public class GoodsController
{
	public void sendJson(HttpServletResponse response, String json_data) throws IOException 
	{
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println(json_data);
		writer.close();	
	}
	
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	IListService listService;
	
	@RequestMapping("/goodsAdd")         
	public String goodsAdd() {
		return "admin/goodsAdd";	
	}
	
	@RequestMapping("/upload")
	public String goodsAdd(HttpServletRequest request, HttpServletResponse response) throws IOException {
		goodsDao.upload(request.getParameter("BCG_IMG"), 
				     request.getParameter("BCG_IMGDETAIL"),
				     request.getParameter("BCG_NAME"),
				     request.getParameter("BCG_CATEGORY"),
				     Integer.parseInt(request.getParameter("BCG_PRICE")),
				     request.getParameter("BCG_INFO"));
		String json_data = "{\"code\":\"success\", \"desc\":\"등록 완료\"}";
		sendJson(response, json_data);
		return "admin/goodsAddDetail";
	}
	
	@RequestMapping("/goodsAddDetail")
	public String goodsAddDetail() {
		return "admin/goodsAddDetail";	
	}
	
	@RequestMapping("/categoryPoint")
	public String pointList(HttpServletRequest request, Model model) {
		listService.pointList(request, model);
        return "guest/goods/categoryPoint"; 
	}
	
	@RequestMapping("/menuLeft")
	   public String menuLeft(HttpServletRequest request, Model model) {
	      listService.pointList(request, model);
	        return "guest/goods/menuLeft"; 
	   }
	
}
