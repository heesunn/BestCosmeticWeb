package com.study.springboot.member.dao.wjapp;

import com.study.springboot.goods.dto.GoodsDetailDto;
import com.study.springboot.goods.dto.GoodsDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface AppGoodsDao {
    public ArrayList<GoodsDto> goodsListView();
    public ArrayList<GoodsDto> goodsSkinCareListview();
    public ArrayList<GoodsDto> goodsPointListview();
    public ArrayList<GoodsDto> goodsBaseListview();
    public GoodsDto goodsSelectOne(String bcgKey);
    public ArrayList<GoodsDetailDto> goodsDetail(String bcgKey);
    public int goodsFavoriteUp(String bcgKey);
    public int goodsFavoriteDown(String bcgKey);

}
