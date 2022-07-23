package com.study.springboot.member.controller;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.member.dto.GoodsJoinBasketJoinGoodDetailDto;
import com.study.springboot.member.dto.MemberJoinOrderHistoryDto;
import com.study.springboot.member.service.BasketViewService;
import com.study.springboot.member.service.MemberManagementViewService;
import com.study.springboot.member.service.wjapp.AppBasketViewService;
import com.study.springboot.member.service.wjapp.GoodsListViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@RestController
public class MemberRestController
{
    @Autowired
    MemberManagementViewService memberManagementViewService;
    @Autowired
    GoodsListViewService goodsListViewService;
    @Autowired
    AppBasketViewService appBasketViewService;
    @GetMapping("/api/info")
    public ArrayList<MemberJoinOrderHistoryDto> memberManagement(HttpServletRequest request, Model model) {
        ArrayList<MemberJoinOrderHistoryDto> dtos = memberManagementViewService.memberManagementView(request,model);
        return dtos;
    }
    @GetMapping("/api/goods")
    public ArrayList<GoodsDto> goodsList(HttpServletRequest request){
        return goodsListViewService.goodsListView(request);
    }
    @GetMapping("/api/basketView")
    public ArrayList<GoodsJoinBasketJoinGoodDetailDto> basketView(HttpServletRequest request){
        return appBasketViewService.basketView(request);
    }
}
