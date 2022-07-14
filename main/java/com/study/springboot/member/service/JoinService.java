package com.study.springboot.member.service;

import com.study.springboot.member.dto.MemberDto;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;


public interface JoinService {
    public String join(HttpServletRequest request, Model model);
    public MemberDto userCheck(HttpServletRequest request, Model model);
}
