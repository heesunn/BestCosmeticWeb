package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.member.dao.wjapp.AppGoodsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Service
public class GoodsListViewServiceImpl implements GoodsListViewService{
    @Autowired
    AppGoodsDao appGoodsDao;
    @Override
    public ArrayList<GoodsDto> goodsListView(HttpServletRequest request) {
        ArrayList<GoodsDto> dtos = appGoodsDao.goodsListView();
        return dtos;
    }
}
