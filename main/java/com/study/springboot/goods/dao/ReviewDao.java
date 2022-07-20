package com.study.springboot.goods.dao;

import com.study.springboot.goods.dto.ReviewDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface ReviewDao {
    ArrayList<ReviewDto> reviewList(int bcg_key,int nEnd, int nStart);
    public int reviewListArticlePage(int bcg_key);
}
