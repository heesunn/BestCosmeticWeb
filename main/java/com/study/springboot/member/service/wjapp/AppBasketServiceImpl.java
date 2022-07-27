package com.study.springboot.member.service.wjapp;

import com.study.springboot.member.dao.MemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
@Service
public class AppBasketServiceImpl implements AppBasketService{
    @Autowired
    MemberDao memberDao;
    @Override
    public int deleteBasket(HttpServletRequest request) {
        int bcm_num = Integer.parseInt(request.getParameter("bcmNum"));
        String bcg_key = request.getParameter("bcg_key");
        String bcd_detailkey = request.getParameter("bcd_detailkey");
        int deleteCount = memberDao.deleteBasket(bcm_num,bcg_key,bcd_detailkey);
        return deleteCount;
    }

    @Override
    public int basketUpCount(HttpServletRequest request) {
        int bcm_num = Integer.parseInt(request.getParameter("bcmNum"));
        String bcg_key = request.getParameter("bcg_key");
        String bcd_detailkey = request.getParameter("bcd_detailkey");
        int updateCount = memberDao.basketUpCount(bcm_num,bcg_key,bcd_detailkey);
        return updateCount;
    }

    @Override
    public int basketDownCount(HttpServletRequest request) {
        int bcm_num = Integer.parseInt(request.getParameter("bcmNum"));
        String bcg_key = request.getParameter("bcg_key");
        String bcd_detailkey = request.getParameter("bcd_detailkey");
        int updateCount = memberDao.basketDownCount(bcm_num,bcg_key,bcd_detailkey);
        System.out.println(11111);
        return updateCount;
    }

    @Override
    public int basketCount(HttpServletRequest request) {
        int bcm_num = Integer.parseInt(request.getParameter("bcmNum"));
        int basketCount = memberDao.basketCount(bcm_num);
        return basketCount;
    }
}
