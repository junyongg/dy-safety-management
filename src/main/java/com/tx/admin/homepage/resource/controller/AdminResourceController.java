package com.tx.admin.homepage.resource.controller;

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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.homepage.menu.service.AdminMenuService;
import com.tx.admin.homepage.resource.dto.ResourcesDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.annotation.service.ActivityHistoryService;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminResourceController {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;

	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** 메뉴리스트 서비스 */
	@Autowired private AdminMenuService AdminMenuService;
	
	/** 활동기록 서비스 */
	@Autowired
	private ActivityHistoryService ActivityHistoryService;
	
	/**
	 * CSS/js설정 리스트 페이지 - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/resource/{resourceType}.do")
	@CheckActivityHistory(type = "hashmap", homeDiv = SettingData.HOMEDIV_ADMIN)
	public ModelAndView CSSSettingView(
			 Model model
			,Menu Menu
			,@PathVariable String resourceType
			,@RequestParam(value="actionType",required=false) String actionType
			,@RequestParam(value="RM_KEYNO",required=false) String RM_KEYNO
			) throws Exception{
		ModelAndView mv = new ModelAndView("/txap/homepage/resource/pra_resources_list.adm");
		
		if(!resourceType.equals("css") && !resourceType.equals("js")){
			mv.setViewName("/error/error");
			return mv;
		}
		
		//홈페이지 구분 리스트
		mv.addObject("homeDivList", CommonService.getHomeDivCode(true));
		
		if(Menu.getMN_HOMEDIV_C() != null && !Menu.getMN_HOMEDIV_C().equals("")){
			Menu.setMN_KEYNO(Menu.getMN_HOMEDIV_C());
		}else{
			Menu.setMN_KEYNO(SettingData.HOMEDIV_JACT);
		}
		
		Menu = Component.getData("Menu.AMN_getDataByKey", Menu);
		mv.addObject("menu", Menu);
		
		HashMap<String, Object> map = new HashMap<>();
		String scope[] = {"common","main","sub","board","custom"};
		map.put("MN_KEYNO", Menu.getMN_KEYNO());
		map.put("RM_TYPE", resourceType);
		
		for (int i = 0; i < scope.length; i++) {
			map.put("SCOPE", scope[i]);
			if(!scope[i].equals("custom")){
				mv.addObject("Resources"+scope[i]+"KEYNO", Component.getData("Resources.RM_getList", map));
			}else{
				mv.addObject("Resources"+scope[i]+"KEYNO", Component.getList("Resources.RM_getList", map));
			}
		}
		String msg = null;
		
		if(actionType == null || actionType.equals("")){
			actionType = "insertView";
		}else{
			if(actionType.equals("insert")){
				msg = "저장되었습니다.";
			}else if(actionType.equals("update")){
				msg = "수정되었습니다.";
			}else if(actionType.equals("distribute")){
				msg = "배포되었습니다.";
			}
		}
		
		// 활동기록
		ActivityHistoryService.setDescResourceAction(Menu.getMN_NAME(), resourceType, actionType, mv);
				
		mv.addObject("msg",msg);
		mv.addObject("resourcesType",resourceType);
		mv.addObject("SELECT_KEYNO",RM_KEYNO);
		return mv;
	}
	
	
	@RequestMapping(value = "/txap/homepage/resource/{resourceType}/Ajax.do")
	@ResponseBody
	public HashMap<String,Object> CSSSettingViewAjax(
			 ResourcesDTO ResourcesDTO
			 ,@PathVariable String resourceType
			) throws Exception{
		HashMap<String, Object> map = new HashMap<>();
		
		HashMap<String, Object> data = new HashMap<>();
		data.put("RM_MN_HOMEDIV_C", ResourcesDTO.getRM_MN_HOMEDIV_C());
		data.put("RM_TYPE", ResourcesDTO.getRM_TYPE());
		data.put("RM_KEYNO", ResourcesDTO.getRM_KEYNO());
		data.put("allck", "false");
		map.put("ResultData", Component.getData("Resources.RM_getData", data));
		
		map.put("HistoyeData", Component.getList("Resources.RMH_getList", ResourcesDTO));
		
		return map;
	}
	
	@RequestMapping(value = "/txap/homepage/resource/{resourceType}/MenuListAjax.do")
	public ModelAndView cssMenuListAjax(
			 Menu Menu
			,@PathVariable String resourceType
			,@RequestParam(value="KEYNO", required=false) String KEYNO
			,ResourcesDTO ResourcesDTO
			) throws Exception{
		ModelAndView mv  = new ModelAndView("/txap/homepage/resource/pra_resources_list_data");
		if(KEYNO != null && !KEYNO.equals("")){
			mv.addObject("MenuKeys", Component.getData("Resources.RMS_selectMenuKey", KEYNO));
		}
		
		Menu.setMN_DEL_YN("N");
		HomeManager homeManager = Component.getData("Menu.AMN_getMenuList",Menu);
		mv.addObject("homeManager", homeManager);
		mv.addObject("menuList", AdminMenuService.getMenuList(homeManager,null));
		return mv;
	}
	
	/**
	 * 저장하기 - admin
	 * 
	 * @param TCS_KEYNO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/homepage/resource/{resourceType}/insert.do")
	@Transactional
	public ModelAndView cssDataInsert(
			  @ModelAttribute ResourcesDTO ResourcesDTO
		    , @PathVariable String resourceType
			, @RequestParam(value="MN_HOMEDIV_C", required=false) String MN_HOMEDIV_C
			, @RequestParam(value="actionType", required=false) String actiontype
			, @RequestParam(value="ApplyMenu", required=false) String ApplyMenu
			, HttpServletRequest req)
			throws Exception {
		ModelAndView mv  = new ModelAndView();
		
		String actionType = "";
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		Map user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		String regName = ((String) user.get("UI_KEYNO"));
		
		String ST_REGDT = Component.getData("Resources.get_historyDate",ResourcesDTO);
		
		if(actiontype.equals("insert")){
			ResourcesDTO.setRM_KEYNO(CommonService.getTableKey("RM"));
			ResourcesDTO.setRM_MN_HOMEDIV_C(MN_HOMEDIV_C);
			ResourcesDTO.setRM_REGNM(regName);
			Component.createData("Resources.RM_insert", ResourcesDTO);
			ST_REGDT = Component.getData("Resources.get_historyDate",ResourcesDTO);
			actionType = "insert";
		}else if(actiontype.equals("update")){
			ResourcesDTO.setRM_MODNM(regName);
			Component.createData("Resources.RM_update", ResourcesDTO);
			actionType = "update";
		}
		
		/*메뉴 키 등록*/
		HashMap<String, Object> subMap = new HashMap<>();
		
		if(ApplyMenu != null && !ApplyMenu.equals("")){
			
			subMap.put("RMS_RM_KEYNO", ResourcesDTO.getRM_KEYNO());
			Component.createData("Resources.RMS_delete", ResourcesDTO.getRM_KEYNO());
			
			String[] ResourcesMenu = ApplyMenu.split(",");
			for (String string : ResourcesMenu) {
				subMap.put("RMS_MN_KEYNO",string);
				Component.createData("Resources.RMS_insert", subMap);
			}
		}
		
		
		/* 히스토리 저장 시작*/
		double VersionNum = Component.getData("Resources.get_historyVersion",ResourcesDTO);
		VersionNum += 0.01;
		ResourcesDTO.setRMH_KEYNO(CommonService.getTableKey("RMH"));
		ResourcesDTO.setRMH_RM_KEYNO(ResourcesDTO.getRM_KEYNO());
		ResourcesDTO.setRMH_STDT(ST_REGDT);
		ResourcesDTO.setRMH_MODNM(regName);
		ResourcesDTO.setRMH_DATA(ResourcesDTO.getRM_DATA());
		ResourcesDTO.setRMH_VERSION(VersionNum);
		
		String message = ResourcesDTO.getRMH_COMMENT();
		if(ResourcesDTO.getRMH_COMMENT() == null || ResourcesDTO.getRMH_COMMENT().equals("")){
			message = "no message";
		}
		ResourcesDTO.setRMH_COMMENT(message);
		Component.createData("Resources.RMH_insert", ResourcesDTO);
		/* 히스토리 저장 끝*/
		
		mv.setViewName("redirect:/txap/homepage/resource/"+resourceType+".do?RM_KEYNO="+ResourcesDTO.getRM_KEYNO()+"&MN_HOMEDIV_C="+MN_HOMEDIV_C+"&actionType="+actionType);
		return mv;

	}
	
	/**
	 * CSS소스 DB 복원 - admin
	 * 
	 * @param TCS_KEYNO
	 * @return
	 * @throws Exception
	 */   
	@RequestMapping(value = "/txap/homepage/resource/{resourceType}/detailView/returnPage.do")
	@ResponseBody
	public String CreateCSS_DetailViewReturnPage(HttpServletRequest req,
			Model model
			, ResourcesDTO ResourcesDTO
			,@PathVariable String resourceType
			) throws Exception{
		
		ResourcesDTO BeforeHistory = Component.getData("Resources.RMH_getData",ResourcesDTO);
		String DATA = BeforeHistory.getRMH_DATA();
		return DATA;
	}
	
	/**
	 * CSS소스 DB 최신데이터와 비교, 변경사항 - admin
	 * 
	 * @param TCS_KEYNO
	 * @param TCSH_KEYNO
	 * @return
	 * @throws Exception
	 */  
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/txap/homepage/resource/{resourceType}/detailView/compareAjax.do")
	@ResponseBody
	public List CreateCSS_CompareAjax(
			 Model model
			,ResourcesDTO ResourcesDTO
			,@PathVariable String resourceType
			) throws Exception{
		
		return Component.getList("Resources.RMH_compareData", ResourcesDTO);
	}
	
	/**
	 * CSS소스 DB 배포 - admin
	 * 
	 * @param TCS_MN_HOMEDIV_C
	 * @return
	 * @throws Exception
	 */  
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/txap/homepage/resource/{resourceType}/distributeAjax.do")
	public ModelAndView CSS_DistributeAjax(
			 @PathVariable String resourceType
			,ResourcesDTO ResourcesDTO
			,@RequestParam(value="allck", required=false) Boolean allck
			) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		String Tiles = Component.getData("HomeManager.get_tiles", ResourcesDTO.getRM_MN_HOMEDIV_C());
		
		List<HashMap<String, Object>> resourcesList = new ArrayList<>();
		HashMap<String, Object> resourcesData = new HashMap<>();
		
		HashMap<String, Object> data = new HashMap<>();
		data.put("RM_MN_HOMEDIV_C", ResourcesDTO.getRM_MN_HOMEDIV_C());
		data.put("RM_TYPE", ResourcesDTO.getRM_TYPE());
		data.put("RM_KEYNO", ResourcesDTO.getRM_KEYNO());
		data.put("allck", allck.toString());
		if(allck){
			ResourcesDTO.setRM_TYPE(resourceType);
			resourcesList = Component.getList("Resources.RM_getData", data);
		}else{
			resourcesData = Component.getData("Resources.RM_getData", data);			
		}
		
		if(allck){
			if(resourcesList.size() > 0){
				for (HashMap<String, Object> hashMap : resourcesList) {
					publish(Tiles, hashMap, resourceType);
				}
			}
		}else{
			publish(Tiles, resourcesData, resourceType);
		}
		
		mv.setViewName("redirect:/txap/homepage/resource/"+resourceType+".do?RM_KEYNO="+ResourcesDTO.getRM_KEYNO()+"&MN_HOMEDIV_C="+ResourcesDTO.getRM_MN_HOMEDIV_C()+"&actionType=distribute");
		
		return mv;
	}
	

	/**
	 * CSS소스 DB 배포처리 - admin
	 * 
	 * @throws Exception
	 */
	private void publish(
			  String Tiles			
			, HashMap<String, Object> resourcesData
			, String resourceType
			) throws Exception {
		
		//프로퍼티 경로 불러오기
		String resourcePath = propertiesService.getString("resourcePath") + "publish/";

		// 해당경로에 파일생성
		File publishFolder = new File(resourcePath); 
		if (!publishFolder.exists() || publishFolder.isFile()) {
			publishFolder.mkdirs();
		}
		
		String propertiespath = resourcePath;
		
		String fileName = (String)resourcesData.get("RM_FILE_NAME") +"." + resourceType;
		String filePath = propertiespath + Tiles +"/"+ resourceType +"/"+ fileName;
		
		File tilesFolder = new File(propertiespath+ Tiles+"/"); 
		if (!tilesFolder.exists() || tilesFolder.isFile()) {
			tilesFolder.mkdirs();
		}
		propertiespath = propertiespath+ Tiles+"/";
		File fileFolder = new File(propertiespath+resourceType+"/"); 
		if (!fileFolder.exists() || fileFolder.isFile()) {
			fileFolder.mkdirs();
		}
		try (BufferedOutputStream bs = new BufferedOutputStream(new FileOutputStream(filePath))){
			String str = resourcesData.get("RM_DATA").toString();
			
			if(resourcesData.get("RM_FILE_NAME").toString().contains(".min")){
				str =  str.replaceAll(System.getProperty("line.separator"), " ");
				str =  str.replaceAll("(\r\n|\r|\n|\n\r)", " ");
				str =  str.replaceAll("\\p{Z}", "");
			}
			
			bs.write(str.getBytes()); //Byte형으로만 넣을 수 있음
		} catch (IOException e) {
			System.out.println("파일을 생성하는 과정에서 오류가 발생했습니다.");
		} 
		
	}
	
	/**
	 *  리소스 삭제
	 * */
	@RequestMapping(value = "/txap/homepage/resource/{resourceType}/DeleteAjax.do")
	@ResponseBody
	public void ResourcesDeleteAjax(
			 ResourcesDTO ResourcesDTO
			) throws Exception{
		
		Component.deleteData("Resources.RM_delete", ResourcesDTO.getRM_KEYNO());
		
	}
	
}