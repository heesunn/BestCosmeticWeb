package com.study.springboot.member.dao.wjapp;

import com.study.springboot.goods.dto.GoodsDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface AppGoodsDao {
    public ArrayList<GoodsDto> goodsListView();
}
