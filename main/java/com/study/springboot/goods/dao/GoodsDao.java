package com.study.springboot.goods.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.dto.LPageInfo;

@Mapper
public interface GoodsDao
{	//상품등록
	public int upload(String BCG_IMG, String BCG_IMGDETAIL, String BCG_CATEGORY, String BCG_NAME, int BCG_PRICE, String BCG_INFO);
	public int uploadDetail(int BCG_KEY, int BCD_DETAILKEY, String BCD_OPTION, int BCD_STOCK);
    //상품삭제
	public int delete(int BCG_KEY);
	//상품수정
	public int modify(int BCG_KEY, int BCG_PRICE, String BCG_INFO, int BCG_DISCOUNT, int BCG_MDPICK);
	//상품 옵션추가 select
	GoodsDto opSelect(int BCG_KEY);
	//전체리스트
	ArrayList<GoodsDto> list(int start, int end);
	LPageInfo articlePage(int curPage);
	public int selectCount();
	//검색 : 상품명
	ArrayList<GoodsDto> searchList(int start, int end, String type, String srchText);
	LPageInfo articlePageSearch(int curPage, String type, String srchText);
	public int selectCountSearch(String type, String srchText);
	//포인트리스트
	ArrayList<GoodsDto> pointList(int start, int end);
	LPageInfo articlePagePoint(int curPage);
	public int selectCountPoint();
}
