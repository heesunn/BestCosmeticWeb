package com.study.springboot.member.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.member.dto.Like;
import com.study.springboot.member.dto.MemberDto;
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
}
