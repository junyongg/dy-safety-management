package com.tx.jcia.intro.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.board.dto.BoardNotice;
import com.tx.admin.operation.organization.dto.OrganDTO;
import com.tx.common.common.SettingData;
import com.tx.common.component.ComponentService;

/**
 * 
 * @FileName: IntroController.java
 * @Project : cf
 * @Date : 2018. 06. 20.
 * @Author : 이혜주
 * @Version : 1.0
 */
@Controller
public class JciaIntroController {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;

//	@RequestMapping(value = "/jcia/intro/location.do")
	public ModelAndView main(HttpServletRequest req
			, Map<String, Object> commandMap
			, @RequestParam(value = "msg", defaultValue = "") String msg
			, @ModelAttribute BoardNotice BoardNotice
			) throws Exception {
		ModelAndView mv = new ModelAndView("/jcia/intro/prc_location");
		return mv;
	}
	
	@RequestMapping(value = "/jcia/intro/organization.do")
	public ModelAndView cfIntroDepartment(HttpServletRequest req
			, Map<String, Object> commandMap
			, @ModelAttribute OrganDTO OrganDTO
			) throws Exception {
		ModelAndView mv = new ModelAndView("/jcia/intro/prc_department");
		
		OrganDTO.setDN_HOMEDIV_C(SettingData.HOMEDIV_JCIA);
		mv.addObject("orgList",Component.getList("Organization.DN_getList",OrganDTO));
		mv.addObject("orgPersonList", Component.getList("Organization.DU_getList", OrganDTO));
		OrganDTO.setDN_MAINKEY("");
		mv.addObject("orgLeader",Component.getData("Organization.DN_getList",OrganDTO));
		return mv;
	}
}
