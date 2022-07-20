package com.study.springboot.goods.dao;

import com.study.springboot.goods.dto.QuestionDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface QuestionDao {
    ArrayList<QuestionDto> questionListView(int bcg_key,int nEnd, int nStart);
    public int questionListViewArticlePage(int bcg_key);
}
