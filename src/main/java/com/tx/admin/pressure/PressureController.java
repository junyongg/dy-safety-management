package com.tx.admin.pressure;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

@Controller
public class PressureController {

	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 문서작성할때 사용 */
	@RequestMapping(value="/txap/pressure.do")
	public ModelAndView test(
			@RequestParam(required=false, value="contents") String contents){
		ModelAndView mv  = new ModelAndView("/txap/pressure/pressure.adm");
		
		mv.addObject("contents", contents);
		return mv;
	}
	
	@RequestMapping(value="/txap/pressure/check.do")
	public ModelAndView check(@RequestParam(value="contents", required=false) String contents){
		String testContent = null;
		testContent = contents.replaceAll("[\\-\\+\\.\\^:,]","");
//		testContent = contents.replaceAll("\r\n", ""); 
		testContent= testContent.replace(System.getProperty("line.separator"), ""); 
		testContent = testContent.replaceAll("\t", ""); 
		ModelAndView mv  = new ModelAndView("/txap/pressure/pressure.adm");
		
		mv.addObject("mirrorPage", "/txap/pressure.do");
		mv.addObject("contents", testContent);
		return mv;
	}
	
	@RequestMapping(value="/test.do")
	public ModelAndView test1(@RequestParam(value="contents", required=false) String contents
			, HttpServletRequest req
			) throws Exception{
		Map<String, Object> map = (Map<String, Object>) req.getSession().getAttribute("userInfo2222");

		String abc = "";
		
		abc = abc + abc;
		
		System.err.println(CommonService.getSessionUserKey(req).equals("txadmin"));
		System.err.println("세션키 : "+CommonService.getSessionUserKey(req));
		
		ModelAndView mv  = new ModelAndView("/txap/test/test.adm");
		mv.addObject("mirrorPage", "/txap/test.do");
		return mv;

	}
	
	
}
