package com.study.springboot.member.dao;

import com.study.springboot.member.dto.GoodsJoinBasketJoinGoodDetailDto;
import com.study.springboot.member.dto.GoodsJoinDetailGoodsDto;
import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.OrderDeliveryDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;



@Mapper
public interface MemberDao {
    public int join(String bcm_id,String bcm_pw,String bcm_name,String bcm_email);
    public MemberDto userCheck(String bcm_id);
    public ArrayList<OrderDeliveryDto> orderDeliveryView(int bcm_num,int nEnd, int nStart);
    public int articlePage(int curPage);
    public int cancellationRequest(int bcm_num, String bco_ordernum);
    public int exchangeRequest(int bcm_num, String bco_ordernum);
    public int refundRequest(int bcm_num, String bco_ordernum);
    public int purchaseConfirmation(int bcm_num, String bco_ordernum);
    public ArrayList<OrderDeliveryDto> cancelExchangeRefund(int bcm_num, int nEnd, int nStart);
    public int articlePage2(int curPage);
    public MemberDto selectUser(int bcm_num);
    public int modifyMember(String bcm_email,String bcm_phonenum1,String bcm_phonenum2,String bcm_phonenum3,
                            String bcm_zipcode,String bcm_address1,String bcm_address2,String bcm_address3,
                            int bcm_num );
    public ArrayList<GoodsJoinBasketJoinGoodDetailDto> basketListView(int bcm_num);
    public int deleteBasket(int bcm_num,String bcg_key,String bcd_detailkey);
    public GoodsJoinDetailGoodsDto orderCheck(String bcg_key, String bcd_detailkey);
    public int basketUpCount(int bcm_num,String bcg_key,String bcd_detailkey);
    public int basketDownCount(int bcm_num,String bcg_key,String bcd_detailkey);

}
