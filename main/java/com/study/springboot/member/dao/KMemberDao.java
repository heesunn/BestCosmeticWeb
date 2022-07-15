package com.study.springboot.member.dao;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.member.dto.MemberDto;

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
}
