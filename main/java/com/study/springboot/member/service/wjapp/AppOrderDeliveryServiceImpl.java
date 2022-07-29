package com.study.springboot.member.service.wjapp;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.wjapp.AppKMemberDao;
import com.study.springboot.member.dto.OrderDeliveryDto;

@Service
public class AppOrderDeliveryServiceImpl implements AppOrderDeliveryService
{
	@Autowired
	AppKMemberDao appDao;

	@Override
	public ArrayList<OrderDeliveryDto> appOrderDeliveryInfo(HttpServletRequest request)
	{
		String bcm_num = request.getParameter("num");
		
		ArrayList<OrderDeliveryDto> obj = new ArrayList<OrderDeliveryDto>();
		ArrayList<String> ordernumList = appDao.selectOrdernum(Integer.parseInt(bcm_num));
		
		for(String ordernum : ordernumList) {
			OrderDeliveryDto dto = appDao.appOrderList(ordernum);
			obj.add(dto);
		}
		return obj;
	}
	
}
