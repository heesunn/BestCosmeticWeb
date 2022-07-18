package com.study.springboot.goods.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GoodsDetailDao {	
	public int uploadDetail(String bcg_name, String bcd_detailkey,String bcd_option ,String bcd_stock);
    public int deleteDetail(int BCG_KEY);
    public int AddStock(int totalCount, String bcg_name);
}