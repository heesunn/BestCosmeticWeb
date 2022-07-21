package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.DeliveryInfoDto;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Random;

@Service
public class UtilServiceImpl implements UtilService{
    @Autowired
    MemberDao memberDao;
    HttpSession session;
    @Override
    public void createOrderNum(Model model) {
        Random random = new Random();
        //한번에 랜덤뽑기
        int num = random.nextInt(100000000);
        String strNum="";
        if(num>10000000){
            strNum = ""+Integer.toString(num);
        } else if(num>1000000){
            strNum = "0"+Integer.toString(num);
        }else if(num>100000){
            strNum = "0"+Integer.toString(num);
        } else if (num>10000) {
            strNum = "00"+Integer.toString(num);
        } else if (num>1000) {
            strNum = "000"+Integer.toString(num);
        } else if (num>100) {
            strNum = "0000"+Integer.toString(num);
        } else if (num>10) {
            strNum = "00000"+Integer.toString(num);
        } else {
            strNum = "000000"+Integer.toString(num);
        }
        strNum = "B"+strNum;
        System.out.println(strNum);

        model.addAttribute("orderNum", strNum);
    }

    @Override
    public JSONObject lastDeliveryDestination(HttpServletRequest request) {
        session = request.getSession();
        int bcm_num = (int) session.getAttribute("num");
        ArrayList<DeliveryInfoDto> dtos = memberDao.lastDeliveryDestination(bcm_num);
        JSONObject object = new JSONObject();
        object.put("lastDelivery", dtos);
        return object;
    }
}
