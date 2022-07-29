package com.study.springboot.member.controller;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.dto.GoodsJoinLikes;
import com.study.springboot.member.dto.GoodsJoinBasketJoinGoodDetailDto;
import com.study.springboot.member.dto.Like;
import com.study.springboot.member.dto.MemberJoinOrderHistoryDto;
import com.study.springboot.member.service.BasketViewService;
import com.study.springboot.member.service.MemberManagementViewService;
import com.study.springboot.member.service.UtilService;
import com.study.springboot.member.service.wjapp.*;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@RestController
public class MemberRestController
{
    @Autowired
    MemberManagementViewService memberManagementViewService;
    @Autowired
    GoodsListViewService goodsListViewService;
    @Autowired
    AppBasketViewService appBasketViewService;
    @Autowired
    GoodsDetailViewService goodsDetailViewService;
    @Autowired
    GoodsUpdateService goodsUpdateService;
    @Autowired
    MemberLikeListService memberLikeListService;
    @Autowired
    AppBasketService appBasketService;
    @Autowired
    UtilService utilService;
    @Autowired
    AppAfterPaymentService appAfterPaymentService;
    @GetMapping("/api/info")
    public ArrayList<MemberJoinOrderHistoryDto> memberManagement(HttpServletRequest request, Model model) {
        ArrayList<MemberJoinOrderHistoryDto> dtos = memberManagementViewService.memberManagementView(request,model);
        return dtos;
    }
    @GetMapping("/api/goods")
    public ArrayList<GoodsDto> goodsList(HttpServletRequest request){
        return goodsListViewService.goodsListView(request);
    }
    @PostMapping("/api/basketView")
    public ArrayList<GoodsJoinBasketJoinGoodDetailDto> basketView(HttpServletRequest request){
        return appBasketViewService.basketView(request);
    }
    @GetMapping("/api/category/skinCare")
    public ArrayList<GoodsDto> skinCareList(HttpServletRequest request){
        return goodsListViewService.goodsSkinCareListview(request);
    }
    @GetMapping("/api/category/point")
    public ArrayList<GoodsDto> pointList(HttpServletRequest request){
        return goodsListViewService.goodsPointListview(request);
    }
    @GetMapping("/api/category/base")
    public ArrayList<GoodsDto> baseList(HttpServletRequest request){
        return goodsListViewService.goodsBaseListview(request);
    }
    @GetMapping("/api/goodsDetailView")
    public JSONObject goodsDetailView(HttpServletRequest request) {
        return goodsDetailViewService.goodsDetailView(request);
    }
    @PostMapping("/api/goods/favoriteCount")
    public void goodsFavoriteCount(HttpServletRequest request){
        goodsUpdateService.goodsFavoriteCount(request);
    }
    @PostMapping("/api/member/likeList")
    public ArrayList<Like> likeList(HttpServletRequest request){
        return memberLikeListService.likeList(request);
    }
    @PostMapping("/api/member/UserGoodsJoinLikelist")
    public ArrayList<GoodsJoinLikes> UserGoodsJoinLikelist(HttpServletRequest request){
        return memberLikeListService.UserGoodsJoinLikelist(request);
    }
    @PostMapping("/api/member/basket/upCount")
    public void basketUpCount(HttpServletRequest request){
        appBasketService.basketUpCount(request);
    }
    @PostMapping("/api/member/basket/downCount")
    public void basketDownCount(HttpServletRequest request){
        appBasketService.basketDownCount(request);
    }

    @PostMapping("/api/member/basket/delete")
    public void basketDelete(HttpServletRequest request){
        appBasketService.deleteBasket(request);
    }
    @PostMapping("/api/member/basket/add")
    public void basketAdd(@RequestBody List<HashMap<String, Object>> json){
        appBasketService.basketAdd(json);
    }
    @GetMapping("/api/member/payment/orderNum")
    public String orderNum(HttpServletRequest request,Model model){
        return utilService.createOrderNum(request, model);
    }
    @PostMapping("/api/member/payment/after")
    public void afterPayment(@RequestBody HashMap<String, Object> json){
        appAfterPaymentService.afterPayment(json);
    }
}
