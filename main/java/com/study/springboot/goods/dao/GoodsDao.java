package com.study.springboot.goods.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.service.LPageInfo;

@Mapper
public interface GoodsDao
{	
	public int upload(String BCG_IMG, String BCG_IMGDETAIL, String BCG_CATEGORY, String BCG_NAME, int BCG_PRICE, String BCG_INFO);
	ArrayList<GoodsDto> pointList(int start, int end);
	LPageInfo articlePage(int curPage);
	public int selectCount();
}
