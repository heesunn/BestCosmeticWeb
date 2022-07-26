package com.study.springboot.member.dao.wjapp;

import com.study.springboot.goods.dto.GoodsDetailDto;
import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.dto.GoodsJoinLikes;
import com.study.springboot.member.dto.Like;
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
    public ArrayList<Like> likeList(String bcmNum);
    public void memberFavoriteUp(String bcmNum, String bcgKey);
    public void memberFavoriteDown(String bcmNum, String bcgKey);
    public ArrayList<GoodsJoinLikes> UserGoodsJoinLikelist(String bcmNum);


}
