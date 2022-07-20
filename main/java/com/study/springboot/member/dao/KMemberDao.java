package com.study.springboot.member.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.member.dto.Like;
import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.OrderDeliveryDto;
import com.study.springboot.member.dto.OrderDetail;
import com.study.springboot.member.dto.PageInfo;

@Mapper
public interface KMemberDao {
	public void googleJoin(String bcm_snsId, String bcm_name, String bcm_email);
    public void facebookJoin(String bcm_snsId, String bcm_name, String bcm_email);
    public void kakaoJoin(String bcm_snsId, String bcm_name, String bcm_email);
    public void naverJoin(String bcm_snsId, String bcm_name, String bcm_email);
    public MemberDto googleCheck(String bcm_snsId);
    public MemberDto facebookCheck(String bcm_snsId);
    public MemberDto kakaoCheck(String bcm_snsId);
    public MemberDto naverCheck(String bcm_snsId);
    public MemberDto memberSession(String bcm_id);
    public PageInfo articlePage(int curPage);
    public int likeCount(int bcm_num);
    public ArrayList<Like> likeList(int start, int end, int bcm_num);
    public void likeDelete(int bcm_num, int bcg_key);
    public List<OrderDetail> orderDetail(String bco_ordernum);
    public MemberDto pwCheck(String bcm_num);
    public int pwChange(String bcm_num, String bcm_pw);
    public int memberDelete(String bcm_num);
    
    public List<OrderDeliveryDto> orderManagement(String orderStatus, int nEnd, int nStart);
    public int orderManagementCount(String bco_order_status);
    public String orderManagementTotalPrice(String bco_order_status);
    
    public int nameOrderManagementCount(String bco_order_status, String bcm_name);
    public String nameOrderManagementTotalPrice(String bco_order_status, String bcm_name);
    public List<OrderDeliveryDto> nameOrderManagement(String orderStatus, int nEnd, int nStart, String detail);
    
    public int recipientOrderManagementCount(String bco_order_status, String bco_recipient);
    public String recipientOrderManagementTotalPrice(String bco_order_status, String bco_recipient);
    public List<OrderDeliveryDto> recipientOrderManagement(String orderStatus, int nEnd, int nStart, String detail);
    
    public int ordernumOrderManagementCount(String bco_order_status, String bco_ordernum);
    public String ordernumOrderManagementTotalPrice(String bco_order_status, String bco_ordernum);
    public List<OrderDeliveryDto> ordernumOrderManagement(String orderStatus, int nEnd, int nStart, String detail);
    
    public int stateInTransitChange(String bco_ordernum);
    public int stateDeliveryCompletedChange(String bco_ordernum);
}
