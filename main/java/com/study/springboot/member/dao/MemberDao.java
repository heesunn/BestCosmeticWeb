package com.study.springboot.member.dao;

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

}
