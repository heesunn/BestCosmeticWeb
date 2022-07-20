package com.study.springboot.member.service;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface MemberManagementViewService {
    public void memberManagementView(HttpServletRequest request, Model model);
    public void allMemberCount(Model model);
}
