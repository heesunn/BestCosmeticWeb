package com.study.springboot.member.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.OrderDeliveryDto;
import com.study.springboot.member.dto.PageInfo;

@Service
public class OrderManagementImpl implements OrderManagement {

	@Autowired
	KMemberDao dao;
	
	int listCount = 5;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 5;		// 하단에 보여줄 페이지 리스트의 갯수
	
	@Override
	public void deliveryReady(HttpServletRequest request, Model model) {
		String orderStatus = "배송준비중";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}
		int count = dao.orderManagementCount(orderStatus);
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		model.addAttribute("cpage", nPage);
		
		int totalPrice = dao.orderManagementTotalPrice(orderStatus);
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		

		List<OrderDeliveryDto> dto = dao.orderManagement(orderStatus, nEnd, nStart);
		model.addAttribute("deliveryReady",dto);
	}
	@Override
	public String stateInTransit(HttpServletRequest request, Model model) {
		String result = "";
		int updateCount = 0;
		String[] bco_ordernumList = request.getParameterValues("bco_ordernum");
		for(int i=0; i<bco_ordernumList.length; i++) {
			updateCount += dao.stateInTransitChange(bco_ordernumList[i]);
		}
		if(updateCount == bco_ordernumList.length) {
			result = "success";
		}
		return result;
	}
	@Override
	public void inTransit(HttpServletRequest request, Model model) {
		String orderStatus = "배송중";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int count = dao.orderManagementCount(orderStatus);
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
	   	
	   	int totalPrice = dao.orderManagementTotalPrice(orderStatus);
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		

		List<OrderDeliveryDto> dto = dao.orderManagement(orderStatus, nEnd, nStart);
		model.addAttribute("inTransit",dto);
	}
	@Override
	public void stateDeliveryCompleted(HttpServletRequest request, Model model) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deliveryCompleted(HttpServletRequest request, Model model) {
		String orderStatus = "배송완료";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int count = dao.orderManagementCount(orderStatus);
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
	   	
	   	int totalPrice = dao.orderManagementTotalPrice(orderStatus);
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		

		List<OrderDeliveryDto> dto = dao.orderManagement(orderStatus, nEnd, nStart);
		model.addAttribute("deliveryCompleted",dto);
	}

	@Override
	public void purchaseConfirmation(HttpServletRequest request, Model model) {
		String orderStatus = "구매확정";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int count = dao.orderManagementCount(orderStatus);
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
	   	
	   	int totalPrice = dao.orderManagementTotalPrice(orderStatus);
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		

		List<OrderDeliveryDto> dto = dao.orderManagement(orderStatus, nEnd, nStart);
		model.addAttribute("purchaseConfirmation",dto);
	}
	@Override
	public void drSearch(HttpServletRequest request, Model model) {
		String orderStatus = "배송준비중";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		int count = 0;
		if(searchType.equals("bcm_name")) {
			count = dao.nameOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.nameOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("deliveryReady",dto);
			int totalPrice = dao.nameOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_recipient")) {
			count = dao.recipientOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.recipientOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("deliveryReady",dto);
			int totalPrice = dao.recipientOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_ordernum")) {
			count = dao.ordernumOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.ordernumOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("deliveryReady",dto);
			int totalPrice = dao.ordernumOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		PageInfo pinfo = articlePage(nPage, count, searchType, searchWord);
		model.addAttribute("page", pinfo);
		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
		
	}
	@Override
	public void itSearch(HttpServletRequest request, Model model) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void dcSearch(HttpServletRequest request, Model model) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void pcSearch(HttpServletRequest request, Model model) {
		// TODO Auto-generated method stub
		
	}
	public PageInfo articlePage(int curPage, int count, String type, String word) {
		String searchType = type;
		String searchWord = word;
		// 총 게시물의 갯수
		int totalCount = count;

		// 총 페이지 수
		int totalPage = totalCount / listCount;
		if (totalCount % listCount > 0)
		    totalPage++;
		
		// 현재 페이지
		int myCurPage = curPage;
		if (myCurPage > totalPage)
			myCurPage = totalPage;
		if (myCurPage < 1)
			myCurPage = 1;

		// 시작 페이지
		int startPage = ((myCurPage - 1) / pageCount) * pageCount + 1;

		// 끝 페이지
		int endPage = startPage + pageCount - 1;
		if (endPage > totalPage) 
		    endPage = totalPage;

		PageInfo pinfo = new PageInfo();
		pinfo.setTotalCount(totalCount);
		pinfo.setListCount(listCount);
		pinfo.setTotalPage(totalPage);
		pinfo.setCurPage(myCurPage);
		pinfo.setPageCount(pageCount);
		pinfo.setStartPage(startPage);
		pinfo.setEndPage(endPage);
		pinfo.setSearchType(searchType);
		pinfo.setSearchWord(searchWord);
		
		return pinfo;
	}
}
