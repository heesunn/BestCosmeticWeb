package com.study.springboot.member.dao.wjapp;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.member.dto.MemberDto;

@Mapper
public interface AppKMemberDao
{
	public String AppPwCheck(String bcm_id);
	public MemberDto getMemberInfo(String bcm_id);
	public int createAppMemberAccount(String bcm_id, String bcm_pw, String bcm_name, String bcm_email);
}
