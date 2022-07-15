package com.study.springboot.goods.service;

import lombok.Data;

@Data
public class LPageInfo {
	int totalCount;           
	int listCount;         
	int totalPage;          
	int curPage;              
	int pageCount;          
	int startPage;           
	int endPage;       
}
