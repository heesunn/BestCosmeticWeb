package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Service
public class BasketServiceImpl implements BasketService {
    @Autowired
    MemberDao memberDao;
    HttpSession session;
    @Override
    public int deleteBasket(HttpServletRequest request, Model model) {
        session = request.getSession();
        int bcm_num = (int) session.getAttribute("num");
        String bcg_key = request.getParameter("bcg_key");
        String bcd_detailkey = request.getParameter("bcd_detailkey");

        int deleteCount = memberDao.deleteBasket(bcm_num,bcg_key,bcd_detailkey);

        return deleteCount;
    }

    @Override
    public int basketUpCount(HttpServletRequest request, Model model) {
        session = request.getSession();
        int bcm_num = (int) session.getAttribute("num");
        String bcg_key = request.getParameter("bcg_key");
        String bcd_detailkey = request.getParameter("bcd_detailkey");
        int updateCount = memberDao.basketUpCount(bcm_num,bcg_key,bcd_detailkey);
        return updateCount;
    }

    @Override
    public int basketDownCount(HttpServletRequest request, Model model) {
        session = request.getSession();
        int bcm_num = (int) session.getAttribute("num");
        String bcg_key = request.getParameter("bcg_key");
        String bcd_detailkey = request.getParameter("bcd_detailkey");
        int updateCount = memberDao.basketDownCount(bcm_num,bcg_key,bcd_detailkey);
        return updateCount;
    }
}
