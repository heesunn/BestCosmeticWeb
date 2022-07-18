package com.study.springboot.member.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.MemberDto;

@Validated
@Service
public class SnsServiceImpl implements SnsService{
	@Autowired
	private HttpSession httpSession;
    @Autowired
    KMemberDao memberDao;
    
    @Autowired
    MemberDto memberDto;

    @Override
    public void snsLogin(String snsName, String id, String name, String email) {
		
    	if(snsName.equals("google")) {
    		memberDto = memberDao.googleCheck(id);
    		if(memberDto == null) {
    			memberDao.googleJoin(id, name, email);
    			memberDto = memberDao.googleCheck(id);
    			httpSession.setAttribute("num", memberDto.getBcm_num());
    			httpSession.setAttribute("id", memberDto.getBcm_googleid());
    			httpSession.setAttribute("name", memberDto.getBcm_name());
    			httpSession.setAttribute("email", memberDto.getBcm_email());
    		}
    		else {
    			memberDto = memberDao.googleCheck(id);
    			httpSession.setAttribute("num", memberDto.getBcm_num());
    			httpSession.setAttribute("id", memberDto.getBcm_googleid());
    			httpSession.setAttribute("name", memberDto.getBcm_name());
    			httpSession.setAttribute("email", memberDto.getBcm_email());
    		}
    	}
    	else if(snsName.equals("facebook")) {
    		memberDto = memberDao.facebookCheck(id);
    		if(memberDto == null) {
    			memberDao.facebookJoin(id, name, email);
    			memberDto = memberDao.facebookCheck(id);
    			httpSession.setAttribute("num", memberDto.getBcm_num());
    			httpSession.setAttribute("id", memberDto.getBcm_facebookid());
    			httpSession.setAttribute("name", memberDto.getBcm_name());
    			httpSession.setAttribute("email", memberDto.getBcm_email());
    		}
    		else {
    			memberDto = memberDao.facebookCheck(id);
    			httpSession.setAttribute("num", memberDto.getBcm_num());
    			httpSession.setAttribute("id", memberDto.getBcm_facebookid());
    			httpSession.setAttribute("name", memberDto.getBcm_name());
    			httpSession.setAttribute("email", memberDto.getBcm_email());
    		}
    	}
    	else if(snsName.equals("kakao")) {
    		memberDto = memberDao.kakaoCheck(id);
    		if(memberDto == null) {
    			memberDao.kakaoJoin(id, name, email);
    			memberDto = memberDao.kakaoCheck(id);
    			httpSession.setAttribute("num", memberDto.getBcm_num());
    			httpSession.setAttribute("id", memberDto.getBcm_kakaoid());
    			httpSession.setAttribute("name", memberDto.getBcm_name());
    			httpSession.setAttribute("email", memberDto.getBcm_email());
    		}
    		else {
    			memberDto = memberDao.kakaoCheck(id);
    			httpSession.setAttribute("num", memberDto.getBcm_num());
    			httpSession.setAttribute("id", memberDto.getBcm_kakaoid());
    			httpSession.setAttribute("name", memberDto.getBcm_name());
    			httpSession.setAttribute("email", memberDto.getBcm_email());
    		}
    	}
		else if(snsName.equals("naver")) {
			memberDto = memberDao.naverCheck(id);
			if(memberDto == null) {
				memberDao.naverJoin(id, name, email);
				memberDto = memberDao.naverCheck(id);
				httpSession.setAttribute("num", memberDto.getBcm_num());
    			httpSession.setAttribute("id", memberDto.getBcm_naverid());
    			httpSession.setAttribute("name", memberDto.getBcm_name());
    			httpSession.setAttribute("email", memberDto.getBcm_email());
			}
			else {
				memberDto = memberDao.naverCheck(id);
				httpSession.setAttribute("num", memberDto.getBcm_num());
    			httpSession.setAttribute("id", memberDto.getBcm_naverid());
    			httpSession.setAttribute("name", memberDto.getBcm_name());
    			httpSession.setAttribute("email", memberDto.getBcm_email());
    		}
		}
    }
}
