package com.study.springboot.goods.dao.hs;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.goods.dto.GoodsDto;

@Mapper
public interface YGoodsDao {
	public ArrayList<GoodsDto> goodsMDListView();
	public ArrayList<GoodsDto> goodsBestListView();
	public ArrayList<GoodsDto> goodsNewListView();
}
