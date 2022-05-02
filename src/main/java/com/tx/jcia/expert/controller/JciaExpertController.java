package com.tx.jcia.expert.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.jcia.expert.dto.ExpertDTO;
import com.tx.jcia.expert.validate.ExpertValidate;

/**
 * 
 * @FileName: ExpertController.java
 * @Project : cf
 * @Date : 2015. 05. 18.
 * @Author : 이혜주
 * @Version : 1.0
 */
@Controller
public class JciaExpertController {

	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	@RequestMapping(value = "/jcia/application/popupOpen.do")
	public ModelAndView popupOpen(HttpServletRequest req
								, Map<String, Object> commandMap
								, @RequestParam(value = "type", defaultValue = "") String type
								) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("expert", new ExpertDTO());	//메시지 표시
		if("E".equals(type)){
			mv.setViewName("/jcia/expert/prc_expert_popup.notilesJcia");
		}else if("N".equals(type)){
			mv.setViewName("/jcia/news/prc_news_popup.notilesJcia");
		}
		return mv;
	}

	@Transactional
	@RequestMapping(value = "/jcia/expert/expertInsert.do", method = RequestMethod.POST)
	@CheckActivityHistory(desc="전문가DB - 등록 처리")
	public ModelAndView expertInsert(HttpServletRequest req
			, Map<String, Object> commandMap
			, @ModelAttribute("expert") ExpertDTO ExpertDTO
			, Model model
			, @RequestParam(value="EDR_SCHOOL", required=false) String[] EDR_SCHOOL
			, @RequestParam(value="EDR_MAJOR", required=false) String[] EDR_MAJOR
			, @RequestParam(value="EDR_DEGREE", required=false) String[] EDR_DEGREE
			, @RequestParam(value="EDR_DETAILE", required=false) String[] EDR_DETAILE
			, @RequestParam(value="ER_FIELD", required=false) String[] ER_FIELD
			, BindingResult bindingResult
			) throws Exception {
		ModelAndView mv = new ModelAndView();
		String EI_KEYNO = ExpertDTO.setEI_KEYNO(CommonService.getTableKey("EI"));
		ExpertDTO.setEI_IP(CommonService.getClientIP(req));
		
		new ExpertValidate().validate(ExpertDTO, bindingResult); //validation을 수행한다.
//		beanValidator.validate(ExpertDTO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("expert", ExpertDTO);
			mv.setViewName("redirect:/jcia/index.do");
			return mv;
		}
		
		Component.createData("Expert.EI_Insert", ExpertDTO);
		
		for (int i = 0; i < EDR_SCHOOL.length; i++) {
			if(StringUtils.isEmpty(EDR_SCHOOL[i]) && StringUtils.isEmpty(EDR_MAJOR[i]) && StringUtils.isEmpty(EDR_DEGREE[i]) && StringUtils.isEmpty(EDR_DETAILE[i])){
				//학위사항에 아무것도 적혀있지 않을 경우 
			}else{
				ExpertDTO.setEDR_KEYNO(CommonService.getTableKey("EDR"));
				ExpertDTO.setEDR_EI_KEYNO(EI_KEYNO);
				ExpertDTO.setEDR_SCHOOL(EDR_SCHOOL[i]);
				ExpertDTO.setEDR_MAJOR(EDR_MAJOR[i]);
				ExpertDTO.setEDR_DEGREE(EDR_DEGREE[i]);
				ExpertDTO.setEDR_DETAILE(EDR_DETAILE[i]);
				Component.createData("Expert.EDR_Insert", ExpertDTO);
			}
		}
		
		for (int i = 0; i < ER_FIELD.length; i++) {
			if(StringUtils.isNotEmpty(ER_FIELD[i])){
				ExpertDTO.setER_KEYNO(CommonService.getTableKey("ER"));
				ExpertDTO.setER_EI_KEYNO(EI_KEYNO);
				ExpertDTO.setER_FIELD(ER_FIELD[i]);
				Component.createData("Expert.ER_Insert", ExpertDTO);				
			}
		}
		mv.setViewName("redirect:/jcia/index.do");
		return mv;
	}
	
}
