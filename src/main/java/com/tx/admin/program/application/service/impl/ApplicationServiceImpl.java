package com.tx.admin.program.application.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.admin.program.application.dto.ApplicationDTO;
import com.tx.admin.program.application.service.ApplicationService;
import com.tx.common.common.SettingData;
import com.tx.common.component.ComponentService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("ApplicationService")
public class ApplicationServiceImpl extends EgovAbstractServiceImpl implements ApplicationService {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	
	/**
	 * 결제만료로 업데이트
	 * @param req 
	 * */
	@Override
	public void checkExpiredDate(String type, HttpServletRequest req) throws Exception {
		
		List<Map<String,Object>> list = null;
		Map<String,Object> map = new HashMap<String,Object>();
		
		if("mypage".equals(type)) {	//자신이 신청한 프로그램만 조회
			@SuppressWarnings("unchecked")
			Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
			map.put("APP_APU_KEYNO", (String)user.get("UI_KEYNO"));
			list =   Component.getList("mypage.program_AllList", map);
		}else if("ApplyView".equals(type)) {	//모든 프로그램을 조회
			list = Component.getListNoParam("mypage.program_AllList");
		}
		
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
		
		String temp = dayTime.format(new Date());
		int today = Integer.parseInt(temp);
	
		for(Map<String,Object> program : list) {
			//결제만료일 형식바꾸기
			temp = (String)program.get("APP_EXPIRED");	
			int expired = 0;
			if(!StringUtils.isEmpty(temp)) {
				expired = Integer.parseInt(temp.replaceAll("-", ""));
			}
			//프로그램 시작일
			String StartDay = (String)program.get("APP_ST_DATE");	
			int stDay = 0;
			if(!StringUtils.isEmpty(StartDay)) {	//시작일이 있으면
				stDay = Integer.parseInt(StartDay.replaceAll("-", ""));	//시작일을 '-'없애고 숫자로 바꿈
			}
			
			ApplicationDTO ApplicationDTO = new ApplicationDTO();
			ApplicationDTO.setAPP_KEYNO((String)program.get("APP_KEYNO"));
			if(program.get("APP_STATUS").equals(SettingData.APPLY_WAITING) && expired < today) {	//결제대기이고 결제만료일이 오늘날짜보다 작으면
				ApplicationDTO.setAPP_STATUS(SettingData.APPLY_EXPIRED);
				Component.updateData("mypage.program_apply_type", ApplicationDTO);
			}else if(program.get("APP_STATUS").equals(SettingData.APPLY_WAITING) && stDay < today) {	//결제대기이고 프로그램 시작일이 오늘날짜보다 작으면
				ApplicationDTO.setAPP_STATUS(SettingData.APPLY_CANCEL);
				Component.updateData("mypage.program_apply_type", ApplicationDTO);
			}else if(program.get("APP_STATUS").equals(SettingData.APPLY_COMPLETE) && stDay < today) {	//신청완료이고 프로그램 시작일이 오늘날짜보다 작으면
				ApplicationDTO.setAPP_STATUS(SettingData.APPLY_PREVIEW);				
				Component.updateData("mypage.program_apply_type", ApplicationDTO);
			}
		}
	}

	/**
	 * 관람완료로 업데이트
	 * @param req 
	 * */
	@Override
	public void ViewExpiredDate(String type, HttpServletRequest req) throws Exception {
		
		List<Map<String,Object>> list = null;
		Map<String,Object> map = new HashMap<String,Object>();
		
		if("mypage".equals(type)) {	//자신이 신청한 프로그램만 조회
			@SuppressWarnings("unchecked")
			Map<String, Object> user = (Map<String, Object>) req.getSession().getAttribute("userInfo");
			map.put("APP_APU_KEYNO", (String)user.get("UI_KEYNO"));
			map.put("APP_STATUS", SettingData.APPLY_COMPLETE);
			list = Component.getList("mypage.program_BeforeViewList", map);
			
		}else if("ApplyView".equals(type)) {	//모든 프로그램을 조회
			map.put("APP_STATUS", SettingData.APPLY_COMPLETE);
			list = Component.getList("mypage.program_BeforeViewList", map);
		}
		
		if(list != null && !list.isEmpty()){
			for (Map<String, Object> key : list) {
//				String APP_KEYNO = (String)key.get("APP_KEYNO");
				map.put("APP_KEYNO", (String)key.get("APP_KEYNO"));
				map.put("APP_STATUS", SettingData.APPLY_PREVIEW);
				Component.updateData("mypage.viewOk", map);
			}
		}
	}
	
}
