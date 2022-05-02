package com.tx.jact.temp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.tx.common.component.ComponentService;

@Controller
public class JactTempController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	
	
	
/*	@RequestMapping(value="/cf/temp.do")
	public ModelAndView main(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/cf/sub/temp/temp");
		
		return mv;
	}
	

	@RequestMapping(value="/cf/temp/ajax.do")
	@ResponseBody
	public ModelAndView mainajax(HttpServletRequest req, Map<String,Object> commandMap
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/cf/sub/temp/temp2");
		
		
		return mv;
	}*/
	
	
	
	
		
}
