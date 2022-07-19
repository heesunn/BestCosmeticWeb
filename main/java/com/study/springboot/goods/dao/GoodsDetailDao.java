package com.study.springboot.goods.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.goods.dto.GoodsDetailDto;

@Mapper
public interface GoodsDetailDao {	
	public int uploadDetail(String bcg_name, String bcd_detailkey,String bcd_option ,String bcd_stock);
    public int deleteDetail(int BCG_KEY);
    public int AddStock(int totalCount, String bcg_name);
    public ArrayList<GoodsDetailDto> optionList(int BCG_KEY);
    public int stockUpdate(String BCD_STOCK, String BCD_DETAILKEY, String BCG_KEY);
    public int ModifyStock(int totalCount, String bcg_key);
    public int deleteOption(String BCD_DETAILKEY, String BCG_KEY);
}