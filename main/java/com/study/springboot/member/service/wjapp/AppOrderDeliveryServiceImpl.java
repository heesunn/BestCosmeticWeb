package com.study.springboot.member.service.wjapp;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dao.wjapp.AppKMemberDao;
import com.study.springboot.member.dto.OrderDeliveryDto;

@Service
public class AppOrderDeliveryServiceImpl implements AppOrderDeliveryService
{

	@Autowired
	AppKMemberDao appDao;
	@Autowired
    MemberDao memberDao;

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

	@Override
	public int appStatusChange(HttpServletRequest request) {
		int updateCount = 0;
		String status = request.getParameter("status");
		String num = request.getParameter("num");
		int bcm_num = Integer.parseInt(num);
		String bco_ordernum = request.getParameter("ordernum");
		if(status.equals("취소신청")) {
			updateCount = memberDao.cancellationRequest(bcm_num,bco_ordernum);
		}
		else if(status.equals("교환신청")) {
			updateCount = memberDao.exchangeRequest(bcm_num,bco_ordernum);
		}
		else if(status.equals("반품신청")) {
			updateCount = memberDao.refundRequest(bcm_num,bco_ordernum);
		}
		else if(status.equals("구매확정")) {
			updateCount = memberDao.purchaseConfirmation(bcm_num,bco_ordernum);
		}
		
		return updateCount;
	}
	
}
