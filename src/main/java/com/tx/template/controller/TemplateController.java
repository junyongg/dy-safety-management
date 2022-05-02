package com.tx.template.controller;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.common.SNS.SNSInfo;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.ComponentService;

@Controller
public class TemplateController {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
//	@Autowired CommonService CommonService;
	
	
	@RequestMapping(value="/{tiles}/index.do")
	public ModelAndView templateIndex(HttpServletRequest req
			, @PathVariable String tiles
			, @RequestParam(value = "msg", defaultValue = "") String msg
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/publish/" + tiles + "/prc_main");
		
		mv.addObject("msg", URLDecoder.decode(msg, "UTF-8")); // 현재 회원인증후 메세지
		
		String HM_TILES = Component.getData("HomeManager.HM_getTiles", tiles);
		
		if(StringUtils.isEmpty(HM_TILES)){
			mv.setViewName("");
		}
		
		
		return mv;
		
	}
	
	
	/**
	 * 사용자 정의형 URL mapping
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = {"/{a}","/{a}/{b}","/{a}/{b}/{c}","/{a}/{b}/{c}/{d}","/{a}/{b}/{c}/{d}/{e}","/{a}/{b}/{c}/{d}/{e}/{f}"})
	@CheckActivityHistory
	public String userCustomURLMappingPatterns2(Model model
			, HttpServletRequest req
			, @RequestParam(value="MVH_KEYNO", required=false) String MVH_KEYNO
			, @RequestParam(value="step", required=false) String step
			) throws Exception{ 
		
		String URI = (String) req.getRequestURI();
		System.err.println("######### 901 : 사용자정의형 URL : " + URI );
		
		model.addAttribute("step",step);
		
		String tilesNm = URI.split("/")[1];
		
		Menu Menu = new Menu();
		Menu.setMN_URL(URI);
		Menu = Component.getData("Menu.AMN_getMenuByURL", Menu);
		if( Menu != null ){
			
			String pageDiv = Menu.getMN_PAGEDIV_C();
			
			
			/* 메뉴가 게시판형일 경우 */
			if(SettingData.MENU_TYPE_BOARD.equals(pageDiv) && StringUtils.isNotEmpty(Menu.getMN_BT_KEYNO()) ){
				return "forward:/"+tilesNm+"/Board/main/"+Integer.parseInt(Menu.getMN_KEYNO().split("_")[1])+"/view.do";
			}
			
			/* 메뉴가 관광형일 경우 */
			if(SettingData.MENU_TYPE_TOUR.equals(pageDiv) && StringUtils.isNotEmpty(Menu.getMN_TOURKEY()) ){
				return "forward:/"+tilesNm+"/tour/"+Integer.parseInt(Menu.getMN_KEYNO().split("_")[1])+"/view.do";
			}
			
			/* 메뉴가 일반뷰형 일 경우 */
			if(SettingData.MENU_TYPE_PAGE.equals(pageDiv) || SettingData.MENU_TYPE_SUBMENU.equals(pageDiv)){
				HashMap<String, Object> hTMLViewData = new HashMap<>();
				hTMLViewData = Component.getData("HTMLViewData.MVD_getDataByURL", URI);
				model.addAttribute("HTMLViewData", hTMLViewData);
				if(hTMLViewData != null){
					// SNS
					SNSInfo SNSInfo  = new SNSInfo();
					SNSInfo.setTITLE(hTMLViewData.get("MN_NAME").toString());
					String content = hTMLViewData.get("VIEW_DATA").toString();
					try {
						Pattern SCRIPTS = Pattern.compile("<script([^'\"]|\"[^\"]*\"|'[^']*')*?</script>",Pattern.DOTALL);
						Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>",Pattern.DOTALL);
						Pattern TAGS = Pattern.compile("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>");
//						Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
						Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
						Pattern WHITESPACE = Pattern.compile("\\s\\s+");
						
						Matcher m;
						
						m = SCRIPTS.matcher(content);
						content = m.replaceAll("");
						
						m = STYLE.matcher(content);
						content = m.replaceAll("");
						
						m = TAGS.matcher(content);
						content = m.replaceAll("");
						
						m = ENTITY_REFS.matcher(content);
						content = m.replaceAll("");
						
						m = WHITESPACE.matcher(content);
						content = m.replaceAll(" ");
						if(content.length() > 200){
							content = content.substring(0,200);
						}
						SNSInfo.setDESC(content);
						
					} catch (Exception e) {
						System.err.println("Pattern 에러");
					}
					
					model.addAttribute("SNSInfo", SNSInfo);
				}
				
				return "/publish/"+hTMLViewData.get("TILES").toString()+"/views/"+hTMLViewData.get("VIEWNAME").toString();
			}
		}
		
		
		return "";
		
	}
	
}
