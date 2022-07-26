package com.study.springboot.goods.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.service.hs.AGoodsMainListViewService;


@RestController
public class GoodsRestController
{
	 @Autowired
	    AGoodsMainListViewService goodsListViewService;
	 
	 @GetMapping("/api/goodsMd")
	    public ArrayList<GoodsDto> goodsMdList(HttpServletRequest request){
	        return goodsListViewService.goodsMDListView(request);
	    }
	 
	 @GetMapping("/api/goodsBest")
	    public ArrayList<GoodsDto> goodsBestList(HttpServletRequest request){
	        return goodsListViewService.goodsBestListView(request);
	    }
	 
	 @GetMapping("/api/goodsNew")
	    public ArrayList<GoodsDto> goodsNewList(HttpServletRequest request){
	        return goodsListViewService.goodsNewListView(request);
	    }
}
