package com.study.springboot.goods.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.goods.dao.GoodsDao;
import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.service.DeleteService;
import com.study.springboot.goods.service.DetailAddService;
import com.study.springboot.goods.service.ListService;

@Controller
public class GoodsController
{
	
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	ListService listService;
	@Autowired
	DetailAddService detailAddService;
	@Autowired
	DeleteService deleteService;
	
	int BCG_KEY = 0;
	String BCG_NAME = "";
	String BCG_IMG = "";
	String BCG_CATEGORY = "";
	int BCG_PRICE = 0;
	String BCG_INFO = "";
	int BCG_DISCOUNT = 0;
	int BCG_MDPICK = 0;
	String type = "";
	String srchText = "";
	
	@RequestMapping("/admin/goodsAdd")        //신규상품 등록 뷰 (관리자)
	public String goodsAdd() {
		return "admin/goodsAdd";	
	}
	
	@RequestMapping("/admin/goodsAddDetail")  //신규상품 옵션 등록 뷰 (관리자)
	public String goodsAddDetail(HttpServletRequest request, Model model) {		
		model.addAttribute("BCG_NAME", BCG_NAME);
		return "admin/goodsAddDetail";	
	}

	@RequestMapping("/admin/goodsList")       //상품 리스트 뷰 (관리자)
	public String goodsList(HttpServletRequest request, Model model) {
		listService.list(request, model);
        return "admin/goodsList"; 
	}
	
	@RequestMapping("/admin/goodsModify")     //상품 수정 뷰 (관리자)
	public String goodsModify(HttpServletRequest request, Model model) {
		model.addAttribute("BCG_KEY", BCG_KEY);
		model.addAttribute("BCG_IMG", BCG_IMG);
		model.addAttribute("BCG_NAME", BCG_NAME);
		model.addAttribute("BCG_CATEGORY", BCG_CATEGORY);
		model.addAttribute("BCG_PRICE", BCG_PRICE);
		model.addAttribute("BCG_INFO", BCG_INFO);
		model.addAttribute("BCG_DISCOUNT", BCG_DISCOUNT);
		model.addAttribute("BCG_MDPICK", BCG_MDPICK);
		return "admin/goodsModify";	
	}
	
	@RequestMapping("/admin/upload")         //신규상품 등록 (관리자)
	public String upload(HttpServletRequest request, Model model) throws IOException {
		goodsDao.upload(request.getParameter("BCG_IMG"), 
				        request.getParameter("BCG_IMGDETAIL"),
				        request.getParameter("BCG_NAME"),
				        request.getParameter("BCG_CATEGORY"),
				        Integer.parseInt(request.getParameter("BCG_PRICE")),
				        request.getParameter("BCG_INFO"));	
		BCG_NAME = request.getParameter("BCG_NAME");
		return "admin/goodsAddDetail";
	}

	@RequestMapping("/admin/uploadDetail")    //신규상품 옵션 등록 (관리자)
    public @ResponseBody JSONObject uploadDetail(HttpServletRequest request, Model model){
        JSONObject obj = new JSONObject();
        int insertCount = detailAddService.insertDetail(request, model);
        obj.put("desc", insertCount);
        return obj;
    }
	
	@RequestMapping("/admin/opSelect")        //기존상품 옵션 추가 (관리자)
	public String opSelect(HttpServletRequest request, Model model){
		BCG_KEY = Integer.parseInt(request.getParameter("BCG_KEY"));
		GoodsDto dto = new GoodsDto();
		dto = goodsDao.opSelect(BCG_KEY); 		
		BCG_NAME = dto.getBcg_name();	
		BCG_IMG = dto.getBcg_img();	
		BCG_CATEGORY = dto.getBcg_category();	
		BCG_PRICE = dto.getBcg_price();	
		BCG_INFO = dto.getBcg_info();	
		BCG_MDPICK = dto.getBcg_mdpick();	
		BCG_DISCOUNT = dto.getBcg_discount();	
		return "admin/goodsAddDetail";	
    }
	
	@RequestMapping("/admin/delete")          //상품 삭제 (관리자)
    public @ResponseBody JSONObject delete(HttpServletRequest request, Model model){
        JSONObject obj = new JSONObject();
        int insertCount = deleteService.delete(request, model);
        obj.put("desc", insertCount);
        return obj;
    }
	
	@RequestMapping("/admin/deleteDetail")    //상품 삭제 시 옵션 같이 삭제 (관리자)
    public @ResponseBody JSONObject deleteDetail(HttpServletRequest request, Model model){
        JSONObject obj = new JSONObject();
        int insertCount = deleteService.deleteDetail(request, model);
        obj.put("desc", insertCount);
        return obj;
    }
	
	@RequestMapping("/admin/modify")         //상품 수정 (관리자)
	public String modify(HttpServletRequest request, Model model) throws IOException {
		goodsDao.modify(Integer.parseInt(request.getParameter("BCG_KEY")), 
		        		Integer.parseInt(request.getParameter("BCG_PRICE")),
				        request.getParameter("BCG_INFO"),
				        Integer.parseInt(request.getParameter("BCG_DISCOUNT")),
		        		Integer.parseInt(request.getParameter("BCG_MDPICK")));
		return "admin/goodsList";
	}
	
	@RequestMapping("/admin/adminSearch")       //상품 검색 (관리자)
	public String adminSearch(HttpServletRequest request, Model model) {    
		type = request.getParameter("type");
		srchText = request.getParameter("srchText");
		return "admin/goodsList"; 
	}
	
	@RequestMapping("/admin/searchRs")          //상품 검색 결과(관리자)
	public String searchRs(HttpServletRequest request, Model model) {    
		listService.searchList(request, model, type, srchText);
		return "admin/goodsList"; 
	}
	
	@RequestMapping("/guest/categoryAll")     //전체보기 카테고리
	public String list(HttpServletRequest request, Model model) {
		listService.list(request, model);
        return "guest/goods/categoryAll"; 
	}
	
	@RequestMapping("/guest/categoryPoint")   //포인트메이크업 카테고리
	public String pointList(HttpServletRequest request, Model model) {
		listService.pointList(request, model);
        return "guest/goods/categoryPoint"; 
	}
	
	@RequestMapping("/guest/menuLeft")        //리스트 좌측 메뉴
	public String menuLeft(HttpServletRequest request, Model model) {
	    return "guest/goods/menuLeft"; 
    }
	
	@RequestMapping("/guest/menuTop")         //상단 메뉴
	public String menuTop(HttpServletRequest request, Model model) {
	    return "guest/goods/menuTop"; 
    }
}
