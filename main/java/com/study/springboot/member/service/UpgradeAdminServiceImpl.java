package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
@Service
public class UpgradeAdminServiceImpl implements UpgradeAdminService {
    @Autowired
    MemberDao memberDao;
    @Override
    public int upgradeAdmin(HttpServletRequest request) {

        return 0;
    }
}
