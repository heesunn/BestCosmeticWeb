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
	
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	IListService listService;
	
	@RequestMapping("/admin/goodsAdd")         
	public String goodsAdd() {
		return "admin/goodsAdd";	
	}
	
	@RequestMapping("/admin/upload")
	public String goodsAdd(HttpServletRequest request, HttpServletResponse response) throws IOException {
		goodsDao.upload(request.getParameter("BCG_IMG"), 
				     request.getParameter("BCG_IMGDETAIL"),
				     request.getParameter("BCG_NAME"),
				     request.getParameter("BCG_CATEGORY"),
				     Integer.parseInt(request.getParameter("BCG_PRICE")),
				     request.getParameter("BCG_INFO"));		
		return "admin/goodsAddDetail";
	}
	
	@RequestMapping("/admin/goodsAddDetail")
	public String goodsAddDetail() {
		return "admin/goodsAddDetail";	
	}
	
	@RequestMapping("/guest/categoryPoint")
	public String pointList(HttpServletRequest request, Model model) {
		listService.pointList(request, model);
        return "guest/goods/categoryPoint"; 
	}
	
	@RequestMapping("/guest/menuLeft")
	   public String menuLeft(HttpServletRequest request, Model model) {
	      listService.pointList(request, model);
	        return "guest/goods/menuLeft"; 
    }
	
	@RequestMapping("/guest/menuTop")
	   public String menuTop(HttpServletRequest request, Model model) {

	        return "guest/goods/menuTop"; 
	}
}
