package com.tx.admin.homepage.page.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.homepage.menu.dto.HTMLViewData;
import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.homepage.menu.service.AdminMenuService;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 관리자 - 페이지관리
 * @author 
 * @version 1.0
 * @since 
 */
@Controller
public class AdminPageController {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** 메뉴리스트 서비스 */
	@Autowired private AdminMenuService AdminMenuService;
	
	@Autowired private com.tx.common.publish.service.CommonPublishService CommonPublishService;
	
	/**
	 * HTML소스 DB 리스트 페이지 - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/page.do")
	@CheckActivityHistory(desc = "페이지관리 방문")
	public String CreateHTML_ListView(Model model,Menu Menu,HTMLViewData hTMLViewData) throws Exception{ 
		
		//홈페이지 구분 리스트
		List<HomeManager> homeDivList = CommonService.getHomeDivCode(false);
		model.addAttribute("homeDivList", homeDivList);
		model.addAttribute("HTMLViewData", hTMLViewData);
		
		String mnHomedivC =Menu.getMN_HOMEDIV_C();
		//실재하는 HomeKey인지 체크
		boolean isExistsHomeKey = false;
		for( Menu m : homeDivList ){
			if( m.getMN_HOMEDIV_C().equals(mnHomedivC) ){
				isExistsHomeKey = true;
				break;
			}
		}
		
		//홈페이지 구분값 없을 시 초기값 설정 (관리자)
		if(isExistsHomeKey){
			Menu.setMN_MAINKEY(mnHomedivC);
		}else{
			Menu.setMN_HOMEDIV_C(SettingData.HOMEDIV_JACT);
			Menu.setMN_MAINKEY(SettingData.HOMEDIV_JACT);
		}
		
		Menu.setMN_DEL_YN("N");
		Menu.setMN_KEYNO(Menu.getMN_HOMEDIV_C());
		model.addAttribute("menu", Component.getData("Menu.AMN_getDataByKey", Menu));
		HomeManager hm = new HomeManager();
		hm.setHM_MN_HOMEDIV_C(Menu.getMN_HOMEDIV_C());
		hm = Component.getData("HomeManager.HM_getDataByHOMEDIV_C", hm);
		model.addAttribute("homeData", hm);
		
		model.addAttribute("mirrorPage","/txap/homepage/page.do");
		
		return "/txap/homepage/page/pra_page_list.adm";
	}
	
	@RequestMapping(value = "/txap/homepage/page/subList/listAjax.do")
	public ModelAndView pageManagerSubList(
			Model model
			,Menu Menu
			) throws Exception{ 
		
		ModelAndView mv  = new ModelAndView("/txap/homepage/page/pra_page_list_data");
		
		if(Menu.getMN_HOMEDIV_C() == null || Menu.getMN_HOMEDIV_C().equals("")){
			Menu.setMN_HOMEDIV_C(SettingData.HOMEDIV_JACT);
		}
		Menu.setMN_DEL_YN("N");
		HomeManager homeManager = Component.getData("Menu.AMN_getMenuList",Menu);
		mv.addObject("homeManager", homeManager);
		List<String> pageDivList = new ArrayList<String>();
		pageDivList.add(SettingData.MENU_TYPE_PAGE);
		pageDivList.add(SettingData.MENU_TYPE_SUBMENU);
		mv.addObject("menuList", AdminMenuService.getMenuList(homeManager, pageDivList));
		
		return mv;
	}
	
	/**
	 * HTML소스 DB 저장하기 페이지 - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/page/insertView.do")
	public String CreateHTML_insertView(
			 Model model
			,HTMLViewData hTMLViewData
			,HttpServletRequest req
			,Menu Menu
			,@RequestParam(value="action", required = false) String action
			) throws Exception{
		
		hTMLViewData.setMVD_MN_HOMEDIV_C(Menu.getMN_HOMEDIV_C());
		
		String MVD_KEYNO = Component.getData("HTMLViewData.get_pageViewKey", Menu.getMN_KEYNO());
		if(MVD_KEYNO != null && !MVD_KEYNO.equals("")){
			model.addAttribute("HTMLViewData",Component.getData("HTMLViewData.get_PageViewInfo", CommonService.createMap("MVD_KEYNO", MVD_KEYNO)));
			model.addAttribute("HTMLViewDataHistory",Component.getList("HTMLViewData.MVH_getList", MVD_KEYNO));
		}
		
		String msg = null;
		if(action != null){
			if(action.equals("insert")){
				msg = "저장되었습니다.";
			}else if(action.equals("update")){
				msg = "수정되었습니다.";
			}
		}
		model.addAttribute("homeData", Component.getData("HomeManager.HM_getDataByHOMEDIV_C", Menu.getMN_HOMEDIV_C()));
		model.addAttribute("Menu", Menu);
		model.addAttribute("msg", msg);
		
		
		return "/txap/homepage/page/pra_page_insertView";	
	}
	
	
	/**
	 * HTML소스 DB 등록/수정 동작 - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/page/insert.do")
	@CheckActivityHistory(desc = "페이지관리 등록/수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public String CreateHTML_Regist(Model model
			, HTMLViewData hTMLViewData
			, @RequestParam(value="MVD_DATA_BEFORE", required=false) String MVD_DATA_BEFORE
			, HttpServletRequest req) throws Exception{ 
		
		hTMLViewData.setMVD_REGNM("#01 USER_DTO"); // (세션없을 시 임시저장)
		
		/* 작성자 정보 저장 */
		String User = "";
		@SuppressWarnings("unchecked")
		Map<String, Object> map = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		if( map.get("UI_KEYNO") != null && !map.get("UI_KEYNO").toString().isEmpty() ){
			User = map.get("UI_KEYNO").toString();
		}
//		//xss filter
//	    XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
//		hTMLViewData.setMVD_DATA(filter.doFilter(MVD_DATA));	
		String msg = "";
	    String MVD_DATA = hTMLViewData.getMVD_DATA();
		hTMLViewData.setMVD_DATA(StringEscapeUtils.unescapeHtml3(MVD_DATA));
		
		if(hTMLViewData.getMVD_KEYNO() != null && !hTMLViewData.getMVD_KEYNO().equals("")){
			msg = "update";
			hTMLViewData.setMVD_MODNM(User);
			Component.updateData("HTMLViewData.MVD_update", hTMLViewData);
		}else{
			msg = "insert";
			hTMLViewData.setMVD_KEYNO(CommonService.getTableKey("MVD"));
			hTMLViewData.setMVD_REGNM(User);
			Component.createData("HTMLViewData.MVD_regist", hTMLViewData);
		}
		
		/* 히스토리 저장 시작*/
		double VersionNum = Component.getData("HTMLViewData.get_historyVersion",hTMLViewData);
		VersionNum += 0.01;
		String REGDT = Component.getData("HTMLViewData.get_historyDate",hTMLViewData);
		hTMLViewData.setMVH_KEYNO(CommonService.getTableKey("MVH"));
		hTMLViewData.setMVH_MVD_KEYNO(hTMLViewData.getMVD_KEYNO());
		hTMLViewData.setMVH_STDT(REGDT);
		hTMLViewData.setMVH_MODNM(User);
		hTMLViewData.setMVH_DATA(StringEscapeUtils.unescapeHtml3(MVD_DATA));
		hTMLViewData.setMVH_VERSION(VersionNum);
		
		String message = hTMLViewData.getMVH_COMMENT();
		if(hTMLViewData.getMVH_COMMENT() == null || hTMLViewData.getMVH_COMMENT().equals("")){
			message = "no message";
		}
		hTMLViewData.setMVH_COMMENT(message);
		Component.createData("HTMLViewData.MVH_regist", hTMLViewData);
		/* 히스토리 저장 끝*/
	    
		//메뉴 수정일 업데이트
		HashMap<String, Object> modimap = new HashMap<>();
		modimap.put("MODNM", User);
		modimap.put("MN_KEYNO", hTMLViewData.getMVD_MN_KEYNO());
		Component.updateData("Menu.change_MenuModifyTime", modimap);
		
		return "redirect:/txap/homepage/page/insertView.do?MN_KEYNO=" + hTMLViewData.getMVD_MN_KEYNO()+"&MN_HOMEDIV_C="+hTMLViewData.getMVD_MN_HOMEDIV_C()+"&action="+msg;

	}

	/**
	 * HTML소스 DB 미리보기 페이지 - admin
	 * 
	 * @param MVD_KEYNO
	 * @return
	 * @throws Exception
	 */   
	@RequestMapping(value = "/txap/homepage/page/detailView/iframe.do")
	public String CreateHTML_DetailViewIframe(
			Model model,
			HTMLViewData hTMLViewData
			) throws Exception{
		
		hTMLViewData = Component.getData("HTMLViewData.MVD_getDataPreview", hTMLViewData);
		
		model.addAttribute("HTMLViewData",hTMLViewData);
		return "/txap/homepage/page/pra_page_detailView_iframe";
	}
	
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/txap/homepage/page/compareAjax.do")
	@ResponseBody
	public List CreateHTML_CompareAjax(
			Model model,
			HTMLViewData hTMLViewData
			) throws Exception{
		
		return Component.getList("HTMLViewData.MVH_compareData", hTMLViewData);
	}
	
	
	/**
	 * HTML소스 DB 복원 - admin
	 * 
	 * @param MVD_KEYNO
	 * @return
	 * @throws Exception
	 */   
	@RequestMapping(value = "/txap/homepage/page/detailView/returnPageAjax.do")
	@ResponseBody
	public String CreateHTML_DetailViewReturnPageAjax(HttpServletRequest req
			, Model model
			, HTMLViewData hTMLViewData
			) throws Exception{
		
		HTMLViewData BeforeHistory = Component.getData("HTMLViewData.MVH_getData",hTMLViewData);
		String DATA = BeforeHistory.getMVH_DATA();
		return DATA;
	}
	
	/**
	 * 페이지 배포 - admin
	 * 
	 * @param 
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/txap/homepage/page/distributeAjax.do")
	@CheckActivityHistory(desc = "페이지관리 배포작업")
	@ResponseBody
	public Boolean CreateHTML_DistributeAjax(HttpServletRequest req
			, Model model
			, HTMLViewData hTMLViewData
			, @RequestParam(value="allck", required=false) Boolean allck
			) throws Exception{
		
		String Tiles = Component.getData("HomeManager.get_tiles", hTMLViewData.getMVD_MN_HOMEDIV_C());
		
		List<HashMap<String, Object>> pageList = new ArrayList<>();
		HashMap<String, Object> pageData = new HashMap<>();
		
		HashMap<String, Object> data = new HashMap<>();
		if(allck){
			data.put("allck", allck.toString());
			data.put("column", "MVD_MN_HOMEDIV_C");
			data.put("value", hTMLViewData.getMVD_MN_HOMEDIV_C());
			pageList = Component.getList("HTMLViewData.get_PageViewInfo", data);
		}else{
			pageData = Component.getData("HTMLViewData.get_PageViewInfo", CommonService.createMap("MVD_KEYNO", hTMLViewData.getMVD_KEYNO()));		
		}
		
		if(allck){
			if(pageList.size() > 0){
				for (HashMap<String, Object> hashMap : pageList) {
					publish(Tiles, hashMap, false);
				}
			}
		}else{
			publish(Tiles, pageData, false);
		}
		
		return true;
	}
	
    
    @RequestMapping(value = "/txap/homepage/page/previewAjax.do")
    @ResponseBody
    public String CreateHTML_PreviewAjax(
			  @RequestParam(value="HomeKey", required=false) String HomeKey
			, @RequestParam(value="Keyno", required=false) String Keyno
			, @RequestParam(value="keyType", required=false) String keyType
			, @RequestParam(value="contents", required=false) String contents
			) throws Exception{ 
		
        String Tiles = Component.getData("HomeManager.get_tiles", HomeKey);
        HashMap<String, Object> pageData = new HashMap<>();
        if(keyType.equals("main")){
            pageData= Component.getData("HTMLViewData.get_PageViewInfo", CommonService.createMap("MVD_KEYNO", Keyno));
        }else if(keyType.equals("history")){
            pageData= Component.getData("HTMLViewData.MVD_getDataHistory", Keyno);
            contents = (String)pageData.get("MVD_DATA");
        }
        contents = StringUtils.defaultIfEmpty(contents, "");
        CommonPublishService.pagePreview(Tiles, contents);
        
      
        return pageData.get("MN_URL")+"";
	}
    
    
	/**
	 * HTML소스 DB 미리보기 - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/{tiles}/homepage/page/preview.do")
	@CheckActivityHistory(desc = "페이지관리 콘텐츠 미리보기", homeDiv= SettingData.HOMEDIV_ADMIN)
	public ModelAndView CreateHTML_Preview(
			  @RequestParam(value="mirrorPage", defaultValue="") String mirrorPage
			, @PathVariable String tiles
			) throws Exception{ 
		
		ModelAndView mv = new ModelAndView("/user/publish/"+tiles+"/views/temp/temp");
		
		mv.addObject("mirrorPage", mirrorPage);
		
		return mv;
	}
	
	/**
	 * 배포작업
	 * */
	private void publish(String Tiles, HashMap<String, Object> pageData, Boolean previewCk){
		String pageName = "";
		if(previewCk){
			pageName = "temp";
		}else{
			pageName = (String)pageData.get("VIEWNAME");
		}
		//프로퍼티 경로 불러오기
		String resourcePath = propertiesService.getString("jspPath");
		String fileName = pageName + ".jsp";
		
		resourcePath = getFolderCk(resourcePath, "publish");
		resourcePath = getFolderCk(resourcePath, Tiles);
		resourcePath = getFolderCk(resourcePath, "views");
		
		String filePath = resourcePath+fileName;
		
		try (BufferedOutputStream bs = new BufferedOutputStream(new FileOutputStream(filePath))){

			String str = "";
			       str +=	"<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>\n";
			       str +=	"<%@ include file=\"/WEB-INF/jsp/taglib/taglib.jspf\" %>\n\n";
			       str +=	pageData.get("MVD_DATA").toString();
			bs.write(str.getBytes()); //Byte형으로만 넣을 수 있음
			
		} catch (IOException e) {
			System.out.println("파일을 생성하는 과정에서 오류가 발생했습니다.");
		}
				
	}

	/**
	 * 폴더 생성
	 * */
	private String getFolderCk(String propertiespath, String string) {
		String resourcePath = propertiespath;
		File publishFolder = new File(propertiespath+ string+ "/"); 
		if (!publishFolder.exists() || publishFolder.isFile()) {
			publishFolder.mkdirs();
		}
		resourcePath = propertiespath+ string+"/";
		return resourcePath;
	}


	/**
	 * HTML소스 DB 삭제처리 - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/page/delete.do")
	@CheckActivityHistory(desc = "페이지관리 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public String CreateHTML_deleteOrRecovery(Model model, HTMLViewData hTMLViewData, HttpServletRequest req,Menu Menu) throws Exception{ 
		
		@SuppressWarnings("unchecked")
		Map<String, Object> map = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		if( map.get("UI_KEYNO") != null && !map.get("UI_KEYNO").toString().isEmpty() ){
			String User = map.get("UI_KEYNO").toString();
			hTMLViewData.setMVD_MODNM(User);
		}
		
		Component.updateData("HTMLViewData.MVD_update_STATEYN", hTMLViewData);
		
		return "redirect:/txap/homepage/page/detailView.do?MVD_KEYNO=" + hTMLViewData.getMVD_KEYNO();
	}

}
